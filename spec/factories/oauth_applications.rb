FactoryBot.define do
  factory(:application, class: "Doorkeeper::Application") do
    name { Faker::App }
    redirect_uri { "" }
    scopes { "" }
  end
end
