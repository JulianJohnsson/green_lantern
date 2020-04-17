class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: '🎉  Bienvenue dans la communauté Carbo ! 🎉 ')
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

  def refresh_bridge_email(account)
    @account = account
    @user = @account.user
    mail(to: @user.email, subject: "Ton impact carbone n'est plus à jour")
  end

end
