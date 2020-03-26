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
    if @transaction.category.parent.present?
      @parent_modifiers = @transaction.category.parent.modifiers
    end

    @comment = Comment.new

    @accuracy_tooltip = ""
    case @transaction.accuracy when 0
      @accuracy_tooltip = "Renseigne une catégorie pour améliorer ta précision"
    when 1
      @accuracy_tooltip = "Renseigne une catégorie pour améliorer ta précision"
    when 2
      @accuracy_tooltip = "Précise les informations sur cette dépense ci-dessous"
    when 3
      @accuracy_tooltip = "Niveau de précision 3/3"
    end
  end

  # POST /transactions
  # POST /transactions.json
  def create
    params[:transaction][:amount] = -1 * params[:transaction][:amount].to_f
    params[:transaction][:date] = Date.strptime(params[:transaction][:date], '%m/%d/%Y').to_date
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        AnalyticService.new.track('Transaction created', nil, current_user)
        format.html { redirect_to transactions_path, notice: 'La dépense a bien été créée' }
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
    respond_to do |format|
      if @transaction.update(transaction_params)
        if params[:transaction][:previous_category] == "115"
          @transactions = current_user.transactions.category_id(115).order(date: :desc)
          @categorize = @transactions.where("suggested_category_id IS NULL")
          @suggested = @transactions.where("suggested_category_id IS NOT NULL")

          unless current_user.badges.include?(Badge.find(10))
            current_user.badges <<  Badge.find(10)
          end

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
      params.require(:transaction).permit(:description, :amount, :date, :category_id, :user_id, :updated_by_user, :previous_category)
    end
end
