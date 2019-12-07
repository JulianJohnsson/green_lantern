class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :reductions, dependent: :destroy
  has_one :bridge, dependent: :destroy

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_create_commit :notify_signup
  after_update :notify_invited_signup, if: :saved_change_to_invitation_accepted_at?
  after_update :notify_subscription, if: :saved_change_to_stripe_subscription_id?

  scope :onboarded, -> { where("onboarded = true") }
  scope :subscribed, -> { where("stripe_subscription_id IS NOT NULL") }

  def set_default_role
    self.role ||= :user
  end

  def notify_signup
    if self.invitation_created_at == nil
      AnalyticService.new.track('Signed Up', nil, self)
      #SignupJob.perform_later(self)
      UserMailer.welcome_email(self).deliver_later
      DriftOnboardingJob.set(wait: 5.hours).perform_later(self)
    else
      AnalyticService.new.track('Invitation sent', nil, self)
    end
  end

  def notify_invited_signup
    if self.invitation_created_at != nil
      AnalyticService.new.track('Signed Up', nil, self)
      AnalyticService.new.track('Invitation accepted', nil, self)

      #SignupJob.perform_later(self)
      UserMailer.welcome_email(self).deliver_later
      DriftOnboardingJob.set(wait: 5.hours).perform_later(self)
    end
  end

  def notify_subscription
    if self.stripe_subscription_id.present?
      AnalyticService.new.track('Subscription Paid', nil, self)
      SubscriptionActivationJob.perform_later(self)
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

  def subscribed?
    stripe_subscription_id?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
end
