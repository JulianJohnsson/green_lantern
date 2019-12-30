class ReductionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_onboarding

  def new
    @reduction = Reduction.new
  end

  def index
    @reductions = current_user.reductions.visible.order("month_carbone desc").first(3)
    @tips = Tip.all

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

  def update
    @reduction = Reduction.find(params[:id])
    respond_to do |format|
      if @reduction.update(reduction_params)
        AnalyticService.new.track('Reduction advice hidden', nil, current_user)
        format.html { redirect_to reductions_path, notice: "C'est noté, tu ne verras plus ce conseil" }
        format.json { render :show, status: :ok, location: @reduction }
      else
        format.html { redirect_to reductions_path, notice: "Il y a eu un problème pour masque ce conseil" }
        format.json { render json: @reduction.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def reduction_params
    params.require(:reduction).permit(:user_id, :title, :category_id, :parent_category_id, :month_carbone, :month_cost, :hidden)
  end

end
