class UserMailer < ApplicationMailer

  default from: 'notifications@jk5116-odin-book.herokuapp.com'

  def welcome_email(user)
    @user = user
    @url = 'jk5116-odin-book.herokuapp.com'
    mail(to: @user.email, subject: 'Ready to be a Norse God? Welcome to OdinBook')
  end

end
