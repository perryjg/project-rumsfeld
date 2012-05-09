FactoryGirl.define do
  factory :user do
    name 'Joe Reporter'
    email 'joe@thenews.com'
    password 'foobar'
    password_confirmation 'foobar'
  end

  factory :request do
  	recipient_name 'Joe Bureaucrat'
  	recipient_title 'PR Hack'
  	recipient_organization 'Some Agency'
  	recipient_addr '123 Government Row'
  	recipient_city 'Capital City'
  	recipient_state 'GA'
  	recipient_zip '33333'
  	request_text 'All your records'
  	user_id '1'
  	request_type_id '1'
  end
end
