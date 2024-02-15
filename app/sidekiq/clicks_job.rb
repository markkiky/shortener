# frozen_string_literal: true

# This job sends emails to user on status of links
class ClicksJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(*_args)
    users = User.all

    users.each do |user|
      UserMailer.clicks_email(user).deliver_now
    end
  end
end
