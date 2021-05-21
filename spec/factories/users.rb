FactoryBot.define do

    factory :user do
        sequence(:id) { |n| "#{n}"}
        sequence(:email) {|n| "user#{n}@user.com"}
        sequence(:name) {|n| "user #{n}"}
        sequence(:username) {|n| "user_#{n}"}
        sequence(:password) {|n| "123456#{n}"}
        updated_at {Time.now}
        jti {SecureRandom.uuid}
        created_at {Time.now}

        trait :confirmed do
            confirmed_at {Time.now}
        end
    end
  end