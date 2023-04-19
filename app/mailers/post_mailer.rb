class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.post_created.subject
  #
  def post_created
    @user = params[:user]
    @article = params[:article]
    @greeting = "Hi"
    attachments['unnamed.jpg'] = File.read('app/assets/images/unnamed.jpg')
    mail(
      from: "support@genboot.com",
      to: email_address_with_name(User.first.email, User.first.username), 
      cc: User.pluck(:email), 
      bcc: "secret@genboot.com", 
      subject: "New Article Created"
    ) 
  end
end