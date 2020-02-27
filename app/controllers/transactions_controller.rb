class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /transactions
  # GET /transactions.json
  def index
    @comment = Comment.new
    if params[:parent_category] != nil
       @transactions = current_user.transactions.month_ago(params[:month].to_i || 0).parent_category_id(params[:parent_category]).order(date: :desc)
    elsif params[:category] != nil
      @transactions = current_user.transactions.month_ago(params[:month].to_i || 0).category_id(params[:category]).order(date: :desc)
    else
      @transactions = current_user.transactions.month_ago(params[:month].to_i || 0).order(date: :desc)
    end
    AnalyticService.new.identify(current_user,request)
  end

  def categorize
    @comment = Comment.new
    @transactions = current_user.transactions.category_id(115).order(date: :desc)

    @categorize = @transactions.where("suggested_category_id IS NULL")
    @suggested = @transactions.where("suggested_category_id IS NOT NULL")

  end

  def dashboard
    @transactions = current_user.transactions.carbone_contribution.recent.order(date: :desc)
    @bridge = Bridge.find_by_user_id(current_user.id)
    @categories = Category.all.parent_categories

    if (Date.today - Date.today.beginning_of_month).to_i < 5
      # accomodate empty beginning of month by displaying previous month
      @current_month_count = current_user.transactions.month_ago(1).sum(:carbone)
      @last_month_count = current_user.transactions.month_ago(2).sum(:carbone)
      @carbone_by_category = @categories.map{|c| [c.name, current_user.transactions.carbone_contribution.parent_category_id(c.id).month_ago(1).sum(:carbone)]}.to_h
      @average_by_user = Transaction.all.month_ago(1).sum(:carbone) / Transaction.all.month_ago(1).distinct.count(:user_id)
    else
      @current_month_count = current_user.transactions.month_to_date(0).sum(:carbone)
      @last_month_count = current_user.transactions.month_to_date(1).sum(:carbone)
      @carbone_by_category = @categories.map{|c| [c.name, current_user.transactions.carbone_contribution.parent_category_id(c.id).month_ago(0).sum(:carbone)]}.to_h
      @average_by_user = Transaction.all.month_to_date(0).sum(:carbone) / Transaction.all.month_to_date(0).distinct.count(:user_id)
    end
    @top_category = {@carbone_by_category.key(@carbone_by_category.values.max) => @carbone_by_category.values.max }
    AnalyticService.new.identify(current_user,request)
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
    @modifiers = @transaction.category.modifiers
    @parent_modifiers = @transaction.category.parent.modifiers
    @comment = Comment.new
  end

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    @transactions = current_user.transactions.category_id(115).order(date: :desc)
    @categorize = @transactions.where("suggested_category_id IS NULL")
    @suggested = @transactions.where("suggested_category_id IS NOT NULL")
    respond_to do |format|
      if @transaction.update(transaction_params)
        if params[:transaction][:previous_category] == "115"
          format.html { redirect_to '/categorize', notice: 'La dépense (et les dépenses similaires) ont bien été catégorisées, et leur poids carbone a été calculé.' }
          format.js { flash.now[:notice] = 'La dépense (et les dépenses similaires) ont bien été catégorisées, et leur poids carbone a été calculé.' }
        elsif params[:transaction][:previous_category] != "" && params[:transaction][:previous_category] != "115"
          format.html { redirect_to transactions_path(:month => params[:transaction][:month], :category => params[:transaction][:previous_category]), notice: 'La dépense a bien été mise à jour, ainsi que son poids carbone.' }
          format.js { flash.now[:notice] = "La dépense a bien été catégorisée, et son poids carbone a été calculé." }
        else
          format.html { redirect_to transactions_path(:month => params[:transaction][:month]), notice: 'La dépense a bien été mise à jour, ainsi que son poids carbone.' }
          format.js { flash.now[:notice] = "La dépense a bien été catégorisée, et son poids carbone a été calculé." }
        end
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
    AnalyticService.new.track('Transaction updated',
      {
        updated_by_user: params[:transaction][:updated_by_user],
        previous_category: params[:transaction][:previous_category],
        new_category: params[:transaction][:category_id]
      },
      current_user
    )
    @score = current_user.scores.last
    @score.save
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:external_id, :description, :raw_description, :amount, :date, :category_id, :user_id, :carbone, :parent_category_id, :updated_by_user, :previous_category)
    end
end
