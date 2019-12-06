class GiftsController < ApplicationController
  before_action :set_gift, only:[:choose_formula, :edit, :checkout, :show, :update, :submit]

  def new
    @gift = Gift.new
    @countries = Country.all
  end

  def create
    @gift = Gift.new(gift_params)
    respond_to do |format|
      if @gift.save
        AnalyticService.new.track('Gift Country set', nil, current_user)
        format.html { redirect_to "/gifts/#{@gift.id}/choose_formula" }
        format.json { render :show, status: :ok, location: @gift }
      else
        format.html { render :new }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  def choose_formula
    @country = Country.find(@gift.country_id)
    @month_value = (@country.total*1000/12).to_i
  end

  def update
    respond_to do |format|
      if @gift.update(gift_params)
        if request.referer.include? "/choose_formula"
          AnalyticService.new.track('Gift formula chosen', nil, current_user)
          format.html { redirect_to "/gifts/#{@gift.id}/edit" }
        elsif request.referer.include? "/edit"
          AnalyticService.new.track('Gift contact details set', nil, current_user)
          format.html { redirect_to "/gifts/#{@gift.id}/checkout" }
        end
        format.json { render :show, status: :ok, location: @gift }

      else
        format.html { render edit_gift_path(@gift) }
        format.json { render json: @gift.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def checkout
    case @gift.formula when 'bonsai'
      @color =  'rose'
      @carbone_count = @gift.quantity
      @price = @gift.price
      @image = 'Bonsai_dark.png'
    when 'cocotier'
      @color =  'orange'
      @carbone_count = @gift.quantity
      @price = @gift.price
      @image = 'Cocotier_dark.png'
    when 'bambou'
      @color =  'warning'
      @carbone_count = @gift.quantity
      @price = @gift.price
      @image = 'Pousse_dark.png'
    end
  end

  def submit
    Stripe.api_key = Rails.application.credentials[:stripe][Rails.env.to_sym][:private_key]
    token = params[:stripeToken]
    customer = if current_user && current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
               else
                Stripe::Customer.create(email: @gift.author_email, source: token)
              end
    charge = Stripe::Charge.create({
      amount: (@gift.price*100).to_i,
      currency: "eur",
      description: "Cadeau Carbo",
      customer: customer.id
    })
    unless charge&.id.blank?
      # If there is a charge with id, set order paid.
      @gift.charge_id = charge.id
      @gift.status = :paid
      @gift.save
      AnalyticService.new.track('Gift Paid', nil, current_user)
      GiftPaymentJob.perform_later(@gift)
      redirect_to @gift, notice: "Ton paiement a bien été accepté, tu vas recevoir une facture par email d’ici quelques minutes"
    end
  rescue Stripe::StripeError || Stripe::CardError => e
    # If a Stripe error is raised from the API,
    # set status failed and an error message
    @gift.status = :payment_failed
    @gift.save
    redirect_to "/gifts/#{@gift.id}/checkout", danger: "Ton paiement a échoué"
  end

  def show
  end

  private

  def set_gift
    @gift = Gift.find(params[:id])
  end

  def gift_params
    params.require(:gift).permit(:author_email, :recipient_email, :quantity, :price, :country_id, :author_name, :recipient_name, :invitation_text, :formula)
  end
end
