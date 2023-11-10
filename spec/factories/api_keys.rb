FactoryBot.define do
  factory(:api_key) do
    sequence(:name) { |n| "api_key_#{n}" }

    trait :for_user do
      bearer factory: %i[user]
    end

    trait :revoked do
      revoked_at { Time.now.utc }
    end
  end
end
