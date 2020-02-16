class Category < ApplicationRecord
  has_many :transactions
  belongs_to :parent, :class_name => 'Category', optional: true
  has_many :children, -> { order(:name) }, :class_name => 'Category', :foreign_key => 'parent_id'

  after_update :update_transactions, if: :saved_change_to_coeff?

  scope :root_categories, -> {where("id IN (1,12,24,25,70,136)")}
  scope :parent_categories, -> {where("parent_id=0 AND coeff>0")}
  scope :sub_categories, -> (int) {where("parent_id = ?", int)}

  def self.top_category_advice(score)
    top_category_advice_array = ["","","","",""]
    top_category_advice_array[1] = ['⛵', 150, "c'est l'équivalent du poids de", 'petits voiliers']
    top_category_advice_array[4] = ['🐮', 750, 'pèsent aussi lourd que', 'vaches limousines']
    top_category_advice_array[3] = ['🐊', 450, 'pèsent aussi lourd que', 'crocodiles adultes']
    top_category_advice_array[0] = ['👖', 15, "c'est autant que la fabrication de", 'jeans délavés']
    top_category_advice_array[2] = ['🦓', 300, 'pèsent aussi lourd que', 'zèbres']

    case when score.top_category[1].to_f < 150
      top_category_advice = top_category_advice_array[0]
    when score.top_category[1].to_f < 300
      top_category_advice = top_category_advice_array[rand(2)]
    when score.top_category[1].to_f < 450
      top_category_advice = top_category_advice_array[rand(3)]
    when score.top_category[1].to_f < 750
      top_category_advice = top_category_advice_array[rand(4)]
    when score.top_category[1].to_f >= 750
      top_category_advice = top_category_advice_array[rand(5)]
    end
    top_category_advice
  end

  def self.top_transaction_advice(score)
    rand = rand(5)
    case rand when 0
      top_transaction_advice = ['🥖', "Cette dernière grosse dépense, c'est autant d'émissions que la production de #{(score.top_transaction[1].to_f/0.38).to_f.round(0)} baguettes"]
    when 1
      top_transaction_advice = ['🖥', "Cette dernière grosse dépense génère autant de C02 que la fabrication de #{(score.top_transaction[1].to_f/568).to_f.round(0)} écrans plats"]
    when 2
      top_transaction_advice = ['🛀', "Si tu prenais #{(score.top_transaction[1].to_f/0.7).to_f.round(0)} bains chauds...ça générerait autant de carbone que ta dernière grosse dépense !"]
    when 3
      top_transaction_advice = ['🛋', "Cette dernière grosse dépense, c'est autant de carbone que la fabrication de #{(score.top_transaction[1].to_f/204).to_f.round(0)} canapés convertible !"]
    when 4
      top_transaction_advice = ['🛴', "Cette dernière grosse dépense, c'est autant de carbone généré par une balade de #{(score.top_transaction[1].to_f/0.202).to_f.round(0)} km en trotinette électrique"]
    end
    top_transaction_advice
  end

  def self.top_growth_advice(score)
  end

  def update_transactions
    transactions = self.transactions
    transactions each do |t|
      t.save
    end
  end

end
