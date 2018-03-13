Fabricator(:session) do
  title { Faker::Name.name.gsub(/[^a-z0-9]/i, ' ') }
  date { Date.today.to_s }
  gist { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph}
  cover { fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg')) }
  images { [fixture_file_upload(Rails.root.join('spec/fixtures/new_session.jpg'))] }
end
