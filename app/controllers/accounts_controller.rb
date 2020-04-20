class AccountsController < ApplicationController
  before_action :set_account, only: [:update]
  before_action :authenticate_user!

  def index
    Account.refresh_accounts(current_user)
    @accounts = current_user.accounts.active
    @bridge = Bridge.find_by_user_id(current_user.id)
    @redirect_url = @bridge.add_item_url(current_user)
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.js { flash.now[:notice] = "Le nombre de personnes à prendre en compte pour le calcul carbone des dépenses de ce compte a bien été mis à jour." }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.active = false
    @account.save
    redirect_to accounts_path, :notice => "Ce compte a bien été supprimé, il ne sera plus synchronisé."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:people)
    end
end
