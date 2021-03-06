class BridgesController < ApplicationController
  before_action :set_bridge, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /bridges
  # GET /bridges.json
  def index
    @bridge = Bridge.find_by_user_id(current_user.id)
    @score = Score.find_by_user_id(current_user.id)
    AnalyticService.new.identify(current_user,request)
    if @bridge
      if @bridge.bank_connected == true
        TransactionFetcherJob.perform_later(current_user)
        redirect_to @bridge , notice: 'Ton compte est en cours de synchronisation !'
        return
      end
      if params[:item_id] == nil
        AnalyticService.new.track('Account Verified', nil, current_user)
        redirect_to action: 'later', notice: "Ton email a bien été vérifié mais ton compte n'est pas connecté!"
      else
        ab_finished(bridge_new_2: "connect")

        AnalyticService.new.track('Bank Connected', nil, current_user)
        @bridge.bank_connected = true
        @bridge.save
        unless current_user.badges.include?(Badge.find(9))
          current_user.badges <<  Badge.find(9)
          AnalyticService.new.track('Badge Obtained', nil, current_user)
        end
        TransactionFetcherJob.perform_later(current_user)
        TransactionFetcherJob.set(wait: 1.minute).perform_later(current_user)
        TransactionFetcherJob.set(wait: 3.minutes).perform_later(current_user)
        redirect_to @bridge, notice: 'Ton relevé bancaire a bien été connecté, ton compte est en cours de synchronisation !'
      end
    else
      redirect_to new_bridge_path
    end
  end

  # GET /bridges/1
  # GET /bridges/1.json
  def show
    @user = current_user
    @score = current_user.scores.last
    AnalyticService.new.identify(current_user,request)
    if current_user.onboarded != true
      current_user.onboarded = true
      current_user.save
    end
  end

  # GET /account
  def account
    @bridge = Bridge.find_by_user_id(current_user.id)
    if @bridge
      @user = current_user
      @score = current_user.scores.last
      AnalyticService.new.identify(current_user,request)
      AnalyticService.new.track('Bank Connection Started', nil, current_user)
      @redirect_url = @bridge.add_item_url(current_user)
    else
      redirect_to new_bridge_path
    end
  end

  def later
    @user = current_user
    @score = current_user.scores.last
    AnalyticService.new.identify(current_user,request)
    AnalyticService.new.track('Bank Connection Skipped', nil, current_user)
    if current_user.onboarded != true
      current_user.onboarded = true
      current_user.save
    end
  end

  # GET /bridges/new
  def new
    @test = ab_test({bridge_new_2: ["start","connect"]}, 'control', 'experiment')

    @bridge = Bridge.find_by_user_id(current_user.id)
    if @bridge
      redirect_to '/account'
    elsif @test == 'experiment'
      redirect_to '/connexion'
    else
      @bridge = Bridge.new
      @user = current_user
      @score = current_user.scores.last
      AnalyticService.new.identify(current_user,request)
      AnalyticService.new.track('Bank Connection Asked', {variant: @test}, current_user)
    end
  end

  def connexion
    @test = ab_test({bridge_new_2: ["start","connect"]}, 'control', 'experiment')

    @bridge = Bridge.new
    @user = current_user
    @score = current_user.scores.last
    AnalyticService.new.identify(current_user,request)
    AnalyticService.new.track('Bank Connection Asked', {variant: @test}, current_user)
  end

  # GET /bridges/1/edit
  def edit
    @user = current_user
  end

  # POST /bridges
  # POST /bridges.json
  def create
    ab_finished(bridge_new_2: "start")

    @bridge = Bridge.new(bridge_params)
    @user = current_user

    redirect_url = @bridge.add_item_url(@user)
    AnalyticService.new.track('Bank Connection Started', nil, current_user)
    @bridge.save

    respond_to do |format|
      if @bridge.save
        format.html { redirect_to redirect_url}
        format.json { render :show, status: :created, location: @bridge }
      else
        format.html { render :new }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bridges/1
  # PATCH/PUT /bridges/1.json
  def update
    respond_to do |format|
      if @bridge.update(bridge_params)
        format.html { redirect_to @bridge, notice: 'Bridge was successfully updated.' }
        format.json { render :show, status: :ok, location: @bridge }
      else
        format.html { render :edit }
        format.json { render json: @bridge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bridges/1
  # DELETE /bridges/1.json
  def destroy
    @bridge.destroy
    respond_to do |format|
      format.html { redirect_to bridges_url, notice: 'Bridge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bridge
      @bridge = Bridge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bridge_params
      params.require(:bridge).permit(:token, :expires_at, :bank_connected, :user_id, :uuid, :last_sync_at, :credential)
    end
end
