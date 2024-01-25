# spec/factories/links.rb
FactoryBot.define do
  factory :link do
    user
    url { 'https://youtube.com' }
    expiry_date { Date.today + 30 }
  end
end
