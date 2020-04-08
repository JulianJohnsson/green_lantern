class SubscriptionsController < ApplicationController
  layout "stripe"
  before_action :authenticate_user!
  before_action :check_onboarding

  def index
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @average_price = 15 * @carbone_count / 750
    AnalyticService.new.track('Subscription Viewed', nil, current_user)
  end

  def project
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @users = User.subscribed
    @total = @users.sum(:subscription_price) * 50 * (0.days.ago.month) / 1000 + 220
    @target = 100
    AnalyticService.new.track('Subscription Viewed', nil, current_user)
    render :layout => 'application'
  end

  def formula
    @users = User.subscribed
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @average_price = 15 * @carbone_count / 750
    AnalyticService.new.track('Project selected', nil, current_user)
    render :layout => 'checkout'
  end

  def payment
    if current_user.subscribed?
      redirect_to '/subscriptions/show', notice: "You are already a subscriber!"
      return
    end
    @score = current_user.scores.last
    if params[:quantity] == nil && params[:price].present?
      params[:quantity] = params[:price].to_i * 50
    end
    case params[:plan] when 'neutre'
      @carbone_count = @score.total*1000/12.to_i
      @price = @carbone_count * 0.02
    when 'heros'
      @carbone_count = @score.total*1000/12.to_i * 2
      @price = @carbone_count * 0.02
    when 'libre'
      @price = params[:price].to_i
      @carbone_count = @price * 50
    end
    case params[:project] when "1"
      @color = 'danger'
      @name = 'Carbo Nord'
      @logo = "Picto_Projet_Nord.png"
    when "2"
      @color = 'info'
      @name = 'Carbo Ouest'
      @logo = "Picto_Projet_Aquitaine.png"
    when "3"
      @color = 'warning'
      @name = 'Carbo Sud'
      @logo = "Picto_Projet_Med.png"
    end
    AnalyticService.new.track('Subscription Choosed', nil, current_user)
    render :layout => 'checkout'
  end

  def new
    if current_user.subscribed?
      redirect_to '/subscriptions/show', notice: "Tu es déjà abonné !"
    end
    @score = current_user.scores.last
    if params[:quantity] == nil && params[:price].present?
      params[:quantity] = params[:price].to_i * 50
    end
    case params[:plan] when 'bonsai'
      @color =  'rose'
      @carbone_count = @score.total*1000/12.to_i
      @price = @carbone_count * 0.02
      @image = 'Bonsai_dark.png'
    when 'cocotier'
      @color =  'orange'
      @carbone_count = @score.total*1000/12.to_i * 2
      @price = @carbone_count * 0.02
      @image = 'Cocotier_dark.png'
    when 'bambou'
      @color =  'warning'
      @price = params[:price].to_i
      @carbone_count = @price * 50
      @image = 'Pousse_dark.png'
    end
    AnalyticService.new.track('Subscription Choosed', nil, current_user)
  end

  def show
  end

  def create
    begin
      Stripe.api_key = Rails.application.credentials[:stripe][Rails.env.to_sym][:private_key]

      plan_id = params[:plan_id]
      plan = Stripe::Plan.retrieve(plan_id)
      token = params[:stripeToken]

      customer = if current_user.stripe_id?
                  Stripe::Customer.retrieve(current_user.stripe_id)
                 else
                  Stripe::Customer.create(email: current_user.email, source: token)
                end

      subscription = customer.subscriptions.create(plan: plan.id, quantity: params[:quantity].to_i)

      options = {
        stripe_id: customer.id,
        stripe_subscription_id: subscription.id,
        subscribed: true,
        subscription_plan: params[:plan],
        subscription_project: params[:project],
        subscription_price: params[:quantity].to_i * 0.02,
        subscription_started_at: DateTime.now.to_date
      }

      options.merge!(
        card_last4: params[:user][:card_last4],
        card_exp_month: params[:user][:card_exp_month],
        card_exp_year: params[:user][:card_exp_year],
        card_type: params[:user][:card_type]
      ) if params[:user][:card_last4]

      current_user.update(options)

      unless current_user.badges.include?(Badge.find(3))
        current_user.badges <<  Badge.find(3)
        AnalyticService.new.track('Badge Obtained', nil, current_user)
      end

      redirect_to '/subscriptions/show', notice: "Ton abonnement a bien été activé, tu vas recevoir une facture par email d’ici quelques minutes"

    rescue Stripe::CardError => e
      AnalyticService.new.track('Payment Error', nil, current_user)
      redirect_to "/subscriptions/payment?plan=#{params[:plan]}&quantity=#{params[:quantity]}", alert: "#{e.error.code} : #{e.error.message}"
    end
  end

  def destroy
    Stripe.api_key = Rails.application.credentials[:stripe][Rails.env.to_sym][:private_key]
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil, subscribed: false)

    AnalyticService.new.track('Subscription Cancelled', nil, current_user)

    redirect_to root_path, notice: "Ton abonnement a bien été arrêté"
  end

end
