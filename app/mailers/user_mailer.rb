class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Bienvenue dans la communauté Carbo !')
  end

  def new_comment(comment)
    @comment = comment
    @transaction = @comment.my_transaction
    @recipients = User.where("role = 2")
    emails = @recipients.collect(&:email).join(",")
    mail(to: emails, subject: 'Nouveau commentaire sur une transaction')
  end
end
