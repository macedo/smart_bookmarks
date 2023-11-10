FactoryBot.define do
  factory(:bookmark) do
    name { Faker::Internet.domain_word }
    link { Faker::Internet.url }

    user
  end
end
