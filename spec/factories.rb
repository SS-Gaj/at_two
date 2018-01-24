FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true  
    end
  end

#Листинг 10.9: +фабрика микросообщений
  factory :micropost do
    content "Lorem ipsum"
    user
  end
## конец Листинг 10.9
end
