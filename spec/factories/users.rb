FactoryGirl.define do
  factory :user do
    email { Forgery::Internet.email_address }
    password "Qw123456"
  end
end
