class TransactionModifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:index]

  def new
  end

  def create
    @transaction_modifier = TransactionModifier.new(transaction_modifier_params)
    @modifier = @transaction_modifier.modifier

    respond_to do |format|
      if @transaction_modifier.save
        @transaction = Transaction.find(@transaction_modifier.transaction_id)
        @transaction.save
        format.html { redirect_to "/transactions/#{@transaction_modifier.transaction_id}/edit", notice: 'Transaction modifier was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        format.js { flash.now[:notice] = "La dépense a bien été mise à jour et son estimation carbone re-calculée" }
      else
        format.html { render :new }
        format.json { render json: @transaction_modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @transaction_modifier = TransactionModifier.find(params[:id])
    @modifier = @transaction_modifier.modifier

    respond_to do |format|
      if @transaction_modifier.update(transaction_modifier_params)
        @transaction = Transaction.find(@transaction_modifier.transaction_id)
        @transaction.save
        format.html { redirect_to "/transactions/#{@transaction.id}/edit", notice: 'Transaction modifier was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        format.js { flash.now[:notice] = "La dépense a bien été mise à jour et son estimation carbone re-calculée" }
      else
        format.html { render :new }
        format.json { render json: @transaction_modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @transaction_modifier = TransactionModifier.find(params[:id])
    @modifier = @transaction_modifier.modifier
    @transaction_modifier.destroy
    @transaction = Transaction.find(@transaction_modifier.transaction_id)
    @transaction.save
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
      format.js { flash.now[:notice] = "La dépense a bien été mise à jour et son estimation carbone re-calculée" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_modifier_params
      params.require(:transaction_modifier).permit(:transaction_id, :modifier_option_id, :coeff, :modifier_id)
    end

end
