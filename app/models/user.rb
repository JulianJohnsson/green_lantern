class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :scores, dependent: :destroy
  has_many :reductions, dependent: :destroy
  has_one :bridge, dependent: :destroy
  has_one :notification_preference, dependent: :destroy
  has_one :notification_datum, dependent: :destroy
  has_many :user_modifiers, dependent: :destroy
  has_many :accounts, dependent: :destroy
  has_and_belongs_to_many :badges

  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, :if => :new_record?
  after_create :set_invite_encrypt
  after_create_commit :notify_signup
  after_create :create_notification_preference
  after_update :notify_invited_signup, if: :saved_change_to_invitation_accepted_at?
  after_update :notify_subscription, if: :saved_change_to_stripe_subscription_id?

  scope :onboarded, -> { where("onboarded = true") }
  scope :subscribed, -> { where("stripe_subscription_id IS NOT NULL") }

  def set_default_role
    self.role ||= :user
  end

  def notify_signup
    if self.invitation_created_at == nil
      SignupJob.set(wait: 1.minute).perform_later(self)
      #UserMailer.welcome_email(self).deliver_later
      DriftOnboardingJob.set(wait: 5.hours).perform_later(self)
      SurveyOptinJob.set(wait: 2.days).perform_later(self)
      DriftSubscriptionJob.set(wait: 3.days).perform_later(self)
    else
      AnalyticService.new.identify(self, nil)
      AnalyticService.new.track('Invitation sent', nil, User.find(self.invited_by_id))
    end
  end

  def notify_invited_signup
    if self.invitation_created_at != nil
      #AnalyticService.new.track('Signed Up', nil, self)
      AnalyticService.new.track('Invitation accepted', nil, User.find(self.invited_by_id))

      SignupJob.perform_later(self)
      #UserMailer.welcome_email(self).deliver_later
      DriftOnboardingJob.set(wait: 5.hours).perform_later(self)
      SurveyOptinJob.set(wait: 2.days).perform_later(self)
      DriftSubscriptionJob.set(wait: 3.days).perform_later(self)
      user = User.find(self.invited_by_id)
      unless user.badges.include?(Badge.find(4))
        user.badges <<  Badge.find(4)
      end

    end
  end

  def set_invite_encrypt
    SetInviteEncryptJob.perform_later(self)
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

  def set_level
    case when self.badges.count < 6
      then rank = 0
      level = "NIVEAU GLAND"
      to_next = 6 - self.badges.count
      image = "badge_gland_white.png"
    when self.badges.count < 12 && self.badges.count >= 6
      then rank = 1
      level = "NIVEAU POUSSE"
      to_next = 12 - self.badges.count
      image = "badge_pousse_white.png"
    when self.badges.count < 18 && self.badges.count >= 12
      then rank = 2
      level = "NIVEAU BONSAI"
      to_next = 18 - self.badges.count
      image = "badge_bonsai_white.png"
    when self.badges.count < 24 && self.badges.count >= 18
      then rank = 3
      level = "NIVEAU COCOTIER"
      to_next = 24 - self.badges.count
      image = "badge_cocotier_white.png"
    when self.badges.count >= 24
      then rank = 4
      level = "NIVEAU BAOBAB"
      image = "badge_baobab_white.png"
    end
    return level, to_next, rank, image
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
end
