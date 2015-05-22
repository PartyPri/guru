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

  factory :article do
    title "Article test title"
    body "Article test body"
    reel
  end
end
