FactoryBot.define do
    factory :tweet do
        sequence(:id) { |n| "#{n}"}
        sequence(:description) { |n| "Tweet Description - test #{n}"}
        updated_at {Time.now}
        created_at {Time.now}
    end
end