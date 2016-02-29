FactoryGirl.define do
  factory :interest do
    name 'Waacking'
  end

  factory :user do
    sequence(:email) {|n| "test#{n}@example.com" }
    password "foobar123"
    first_name "Toshiro"
    last_name "Sugihara"
  end

  factory :reel do
    name "Foo Reel"
    user
  end

  factory :story do
    title "Story test title"
    body "Story test body"
    reel
  end

  factory :medium do
    title "I'm a Medium"
  end

  factory :credit do
    role "Inspiration"
    sequence(:credit_receiver_email) {|n| "test#{n}@example.com" }
    credit_receiver_id 2
    reel_id 1
    reel_owner_id 1
  end

  factory :notification do
  end
end
