FactoryBot.define do
    factory :tweet do
        sequence(:id) { |n| }
        description {"Tweet Description - test"}
        updated_at {Time.now}
        created_at {Time.now}
    end
end