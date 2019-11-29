class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Category.all.parent_categories
    @transactions_history = current_user.transactions.carbone_contribution
    @transactions = @transactions_history.month_ago(params[:month].to_i || 0)
    @carbone_by_parent_category = @categories.sort_by {|c| c.name}.map {|c| [c, @transactions.parent_category_id(c.id).sum(:carbone)]}
    @carbone_total = 0
    @carbone_by_parent_category.each do |c,v|
      @carbone_total = @carbone_total + v
    end
  end

  def show
    @category = Category.find(params[:id])
    @categories = Category.all.sub_categories(@category.id)
    @transactions = current_user.transactions.carbone_contribution.parent_category_id(@category.id).month_ago(params[:month].to_i || 0)

    @carbone_by_category = @categories.sort_by {|c| c.id}.map {|c| [c, @transactions.category_id(c.id).sum(:carbone)]}
    @carbone_category_total = @transactions.sum(:carbone)

    @colors = @categories.sort_by {|c| c.id}.map { |c| c.color }
  end

  def track
    @bridge = Bridge.find_by_user_id(current_user.id)
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @score = current_user.scores.last
    @transaction_list = current_user.transactions.carbone_contribution.recent.order(date: :desc).first(5)

    if (Date.today - Date.today.beginning_of_month).to_i < 5 && params[:month] == nil
      params[:month] = 1
    end

    if @score.kind.to_sym == :dynamic
      @transactions = current_user.transactions.carbone_contribution.month_ago(params[:month].to_i || 0)
      @score.detail = @categories.sort_by {|c| c.id}.map {|c| @transactions.parent_category_id(c.id).sum(:carbone)*12/1000}
      @score.total = @score.detail.inject(0){|sum,x| sum.to_f + x.to_f }
    end

    @data = []
    for i in 0..4
      @data = @data << [@categories[i].name, (@score.detail[i].to_f*1000/12).round(2)]
    end

    if @score.kind.to_sym == :dynamic
      case Category.find(Category.find(@score.top_category[0]).parent_id).name when 'Transports'
        @top_category_advice = ['⛵', 150, "c'est l'équivalent du poids de", 'petits voiliers']
      when 'Alimentation'
        @top_category_advice = ['🐮', 750, 'pèsent aussi lourd que', 'vaches limousines']
      when 'Logement'
        @top_category_advice = ['🐊', 400, 'pèsent aussi lourd que', 'crocodiles adultes']
      when 'Biens de consommation'
        @top_category_advice = ['👖', 15, "c'est autant que la fabrication de", 'jeans délavés']
      when 'Loisirs & Services'
        @top_category_advice = ['🦓', 300, 'pèsent aussi lourd que', 'zèbres']
      end
      rand = rand(5)
      case rand when 0
        @top_transaction_advice = ['🥖', "Cette dernière grosse dépense, c'est autant d'émissions que la production de #{(@score.top_transaction[1].to_f/0.38).to_f.round(0)} baguettes"]
      when 1
        @top_transaction_advice = ['🖥', "Cette dernière grosse dépense génère autant de C02 que la fabrication de #{(@score.top_transaction[1].to_f/568).to_f.round(0)} écrans plats"]
      when 2
        @top_transaction_advice = ['🛀', "Si tu prenais #{(@score.top_transaction[1].to_f/0.7).to_f.round(0)} bains chauds...ça générerait autant de carbone que ta dernière grosse dépense !"]
      when 3
        @top_transaction_advice = ['🛋', "Cette dernière grosse dépense, c'est autant de carbone que la fabrication de #{(@score.top_transaction[1].to_f/204).to_f.round(0)} canapés convertible !"]
      when 4
        @top_transaction_advice = ['🛴', "Cette dernière grosse dépense, c'est autant de carbone généré par une balade de #{(@score.top_transaction[1].to_f/0.202).to_f.round(0)} km en trotinette électrique"]
      end
    end

    AnalyticService.new.identify(current_user,request)
  end

  def reduce
    @categories = Category.all.parent_categories.sort_by {|c| c.id}
    @score = current_user.scores.last

    @my_carbone = []
    @average_carbone = []
    for i in 0..4
      @my_carbone = @my_carbone << [@categories[i], (@score.detail[i].to_f*1000/12).round(2)]
      total = 0
      count = 0
      User.all.onboarded.each do |user|
        total = total + user.scores.last.detail[i].to_f
        count = count + 1
      end
      @average_carbone = @average_carbone << [@categories[i], (total/ count*1000/12).round(2)]
    end
  end

end
