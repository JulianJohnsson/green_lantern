class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '🎉  Bienvenue dans la communauté Carbo ! 🎉 ')
  end

  def weekly_score_update(user)
    @user = user
    @score = user.transactions.week.carbone_contribution.sum(:carbone).round(0)
    @last_score = user.transactions.previous_week.carbone_contribution.sum(:carbone).round(0)
    mail(to: @user.email, subject: "Tu as généré #{@score} kg de CO2 cette semaine")
  end

  def new_match_ready(match_id)
    match = Match.find(match_id)
    @user = User.find(match.user_id)
    @opponent = User.find(match.opponent_id)
    @match = match
    mail(to: @user.email, subject: '🥊 Tu es prêt pour le match du siècle ? 🥊')
  end

  def new_comment(comment)
    @comment = comment
    @transaction = @comment.my_transaction
    @recipients = User.where("role = 2")
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: 'Nouveau commentaire sur une transaction')
  end

  def new_subscription(subscription)
    @subscription = subscription
    @recipients = User.where("role = 2")
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: 'Nouvel abonnement demandé')
  end
end
