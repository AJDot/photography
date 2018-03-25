include ActionDispatch::TestProcess::FixtureFile

alice = Fabricate(:user)
tmp_images = Dir.glob(Rails.root.join('public/tmp/*.jpg'))
engagement = Fabricate(
  :kind,
  name: "Engagement",
  cover: Pathname.new(tmp_images.sample).open,
  banner: Pathname.new(tmp_images.sample).open
)
portrait = Fabricate(
  :kind,
  name: "Portrait",
  cover: Pathname.new(tmp_images.sample).open,
  banner: Pathname.new(tmp_images.sample).open
)
family = Fabricate(
  :kind,
  name: "Family",
  cover: Pathname.new(tmp_images.sample).open,
  banner: Pathname.new(tmp_images.sample).open
)
# newborn = Fabricate(
#   :kind,
#   name: "Newborn",
#   cover: Pathname.new(tmp_images.sample).open,
#   banner: Pathname.new(tmp_images.sample).open
# )
# flowers = Fabricate(
#   :kind,
#   name: "Flowers",
#   cover: Pathname.new(tmp_images.sample).open,
#   banner: Pathname.new(tmp_images.sample).open
# )

20.times do
  Fabricate(:event, cover: Pathname.new(tmp_images.sample).open, creator: alice, kind: Kind.all.sample)
end
