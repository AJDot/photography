Fabricator(:user) do
  name { Faker::Name.name.gsub(/[^a-z0-9]/i, '_') }
  email { Faker::Internet.email }
  password 'password'
  summary { Faker::Lorem.paragraphs.join("\n") }
end
