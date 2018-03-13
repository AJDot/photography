include ActionDispatch::TestProcess::FixtureFile

alice = Fabricate(:user)
portrait = Fabricate(:kind, cover: Rails.root.join("public/tmp/about.jpg").open, banner: Rails.root.join("public/tmp/about.jpg").open)
Fabricate(:session, creator: alice, kind: portrait )
