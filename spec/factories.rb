require 'faker'

FactoryGirl.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    title 'Ace Reporter'
    organization 'The News'
    address { Faker::Address.street_address }
    city    { Faker::Address.city }
    state   { Faker::Address.state_abbr }
    zip     { Faker::Address.zip_code }
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :request do
  	recipient_name { Faker::Name.name }
  	recipient_title 'PR Hack'
  	recipient_organization { Faker::Company.name }
  	recipient_addr         { Faker::Address.street_address }
  	recipient_city         { Faker::Address.city }
  	recipient_state        { Faker::Address.state_abbr }
  	recipient_zip          { Faker::Address.zip_code }
  	request_text 'All your records are belong to us'
  	user
  end
end
