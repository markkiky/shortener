# frozen_string_literal: true

email = 'markkaris438@gmail.com'
password = '123456'

begin
  User.find_by(email:)
rescue ActiveRecord::NotFound
  User.create(email:, password:, password_confirmation: password)
end
