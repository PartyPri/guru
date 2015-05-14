FactoryGirl.define do
  factory :interest do
    name 'Waacking'
  end

  factory :user do
    email "test@example.com"
    password "foobar123"
    first_name "Toshiro"
    last_name "Sugihara"
  end
end
