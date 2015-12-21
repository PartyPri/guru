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
end
