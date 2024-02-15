# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def clicks_email(user)
    @user = user
    @links = @user.links
    mail(message_id: user.id, in_reply_to: user.id, to: @user.email, subject: 'Your short links statistics')
  end
end
