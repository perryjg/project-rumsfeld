FactoryGirl.define do
  factory :user do
    name 'John Perry'
    email 'jgperry@ajc.com'
    password 'foobar'
    password_confirmation 'foobar'
  end
end
