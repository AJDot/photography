Fabricator(:kind) do
  name { Faker::Zelda.item }
  gist { Faker::Lorem.sentence }
  description { Faker::Lorem.paragraphs.join("\n") }
  price 999
  price_description { Faker::Lorem.paragraphs.join("\n") }
  banner { fixture_file_upload(Rails.root.join('spec/fixtures/new_kind.jpg')) }
  cover { fixture_file_upload(Rails.root.join('spec/fixtures/new_kind.jpg')) }
end
