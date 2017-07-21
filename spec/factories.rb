FactoryGirl.define do
  factory :user do
    name     "Sasha Gaidarenko"
    email    "sashagajdarenko@gmail.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
