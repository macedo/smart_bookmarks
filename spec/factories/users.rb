FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { "SecretPassword123" }
  end
end
