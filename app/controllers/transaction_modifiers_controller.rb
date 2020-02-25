class TransactionModifiersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_transaction, only: [:index]

  def new
  end

  def create
    @transaction_modifier = TransactionModifier.new(transaction_modifier_params)

    respond_to do |format|
      if @transaction_modifier.save
        format.html { redirect_to "/transactions/#{@transaction_modifier.transaction_id}/transaction_modifiers", notice: 'Transaction modifier was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
        format.js { flash.now[:notice] = "" }
      else
        format.html { render :new }
        format.json { render json: @transaction_modifier.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @modifiers = @transaction.category.modifiers
    #@modifiers << Category.find(@transaction.parent_category_id).modifiers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_modifier_params
      params.require(:transaction_modifier).permit(:transaction_id, :modifier_option_id, :modifier, :modifier_id)
    end

end
