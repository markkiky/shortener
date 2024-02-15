# frozen_string_literal: true

# Extend Mailer
class ApplicationMailer < ActionMailer::Base
  default from: ENV['EMAIL']
  layout 'mailer'
end
