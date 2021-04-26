FactoryBot.define do
    factory :user do
        sequence(:id) { |n| }
        sequence(:email) {|n| "user#{n}@user.com"}
        sequence(:name) {|n| "user #{n}"}
        sequence(:username) {|n| "user_#{n}"}
        sequence(:password) {|n| "123456#{n}"}
        updated_at {Time.now}
        confirmed_at {Time.now}
        jti {SecureRandom.uuid}
        created_at {Time.now}
    end

    factory :unconfirmed_user do
        sequence(:id) { |n| }
        sequence(:email) {|n| "user#{n}@user.com"}
        sequence(:name) {|n| "user #{n}"}
        sequence(:username) {|n| "user_#{n}"}
        sequence(:password) {|n| "123456#{n}"}
        created_at {Time.now}
        updated_at {Time.now}
        jti {SecureRandom.uuid}
    end
  end