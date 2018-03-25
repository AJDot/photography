Fabricator(:event) do
  title { Faker::Zelda.game }
  date { Date.today.to_s }
  gist { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraph}
  cover { fixture_file_upload(Rails.root.join('spec/fixtures/new_event.jpg')) }
  images { [fixture_file_upload(Rails.root.join('spec/fixtures/new_event.jpg')), fixture_file_upload(Rails.root.join('spec/fixtures/new_kind.jpg'))] }
end
