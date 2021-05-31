FactoryBot.define do
    factory :tweet do
        sequence(:id) { |n| "#{n}"}
        sequence(:description) { |n| "Tweet Description - test #{n} #hola"}
        updated_at {Time.now}
        created_at {Time.now}
        trait :invalid do
            description {"#holaa"}
        end
    end

end