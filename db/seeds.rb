SEED_DATA = [
  {
    name: "Pixies",
    albums: [
      {
        name: "Doolittle",
        songs: [
          { track_number: 1,  title: "Debaser" },
          { track_number: 2,  title: "Tame" },
          { track_number: 3,  title: "Wave of Mutilation" },
          { track_number: 4,  title: "I Bleed" },
          { track_number: 5,  title: "Here Comes Your Man" },
          { track_number: 6,  title: "Dead" },
          { track_number: 7,  title: "Monkey Gone to Heaven" },
          { track_number: 8,  title: "Mr. Grieves" },
          { track_number: 9,  title: "Crackity Jones" },
          { track_number: 10, title: "La La Love You" },
          { track_number: 11, title: "No 13 Baby" },
          { track_number: 12, title: "There Goes My Gun" },
          { track_number: 13, title: "Hey" },
          { track_number: 14, title: "Silver" },
          { track_number: 15, title: "Gouge Away" },
        ]
      },
      {
        name: "Surfer Rosa",
        songs: [
          { track_number: 1,  title: "Bone Machine" },
          { track_number: 2,  title: "Break My Body" },
          { track_number: 3,  title: "Something Against You" },
          { track_number: 4,  title: "Broken Face" },
          { track_number: 5,  title: "Gigantic" },
          { track_number: 6,  title: "River Euphrates" },
          { track_number: 7,  title: "Where Is My Mind?" },
          { track_number: 8,  title: "Cactus" },
          { track_number: 9,  title: "Tony's Theme" },
          { track_number: 10, title: "Oh My Golly!" },
          { track_number: 11, title: "Vamos (Surfer Rosa)" },
          { track_number: 12, title: "I'm Amazed" },
          { track_number: 13, title: "Brick is Red" },
        ]
      }
    ]
  },
  {
    name: "CHVRCHES",
    albums: [
      {
        name: "Every Open Eye",
        songs: [
          { track_number: 1,  title: "Never Ending Circles" },
          { track_number: 2,  title: "Leave a Trace" },
          { track_number: 3,  title: "Keep You On My Side" },
          { track_number: 4,  title: "Make Them Gold" },
          { track_number: 5,  title: "Clearest Blue" },
          { track_number: 6,  title: "High Enough to Carry You Over" },
          { track_number: 7,  title: "Empty Threat" },
          { track_number: 8,  title: "Down Side of Me" },
          { track_number: 9,  title: "Playing Dead" },
          { track_number: 10, title: "Bury It" },
          { track_number: 11, title: "Afterglow" },
          { track_number: 12, title: "Get Away" },
          { track_number: 13, title: "Follow You" },
          { track_number: 14, title: "Bow Down" },
        ]
      },
      {
        name: "The Bones of What You Believe",
        songs: [
          { track_number: 1,  title: "The Mother We Share" },
          { track_number: 2,  title: "We Sink" },
          { track_number: 3,  title: "Gun" },
          { track_number: 4,  title: "Tether" },
          { track_number: 5,  title: "Lies" },
          { track_number: 6,  title: "Under the Tide" },
          { track_number: 7,  title: "Recover" },
          { track_number: 8,  title: "Night Sky" },
          { track_number: 9,  title: "Science/Visions" },
          { track_number: 10, title: "Lungs" },
          { track_number: 11, title: "By the Throat" },
          { track_number: 12, title: "You Caught the Light" },
          { track_number: 13, title: "Strong Hand" },
          { track_number: 14, title: "Broken Bones" },
        ]
      }
    ]
  },
  {
    name: "Home",
    albums: [
      {
        name: "Odyssey",
        songs: [
          { track_number: 1,  title: "Intro" },
          { track_number: 2,  title: "Native" },
          { track_number: 3,  title: "Decay" },
          { track_number: 4,  title: "Oort Cloud" },
          { track_number: 5,  title: "Tides" },
          { track_number: 6,  title: "Nights (I Wish I Could Be There)" },
          { track_number: 7,  title: "Odyssey" },
          { track_number: 8,  title: "New Machines" },
          { track_number: 9,  title: "Resonance" },
          { track_number: 10, title: "Come Back Down" },
          { track_number: 11, title: "Half Moon" },
          { track_number: 12, title: "On the Way Out" },
        ]
      },
    ]
  },
  {
    name: "Pinback",
    albums: [
      {
        name: "Blue Screen Life",
        songs: [
          { track_number: 1,  title: "Offline P.K." },
          { track_number: 2,  title: "Concrete Seconds" },
          { track_number: 3,  title: "Boo" },
          { track_number: 4,  title: "BBTone" },
          { track_number: 5,  title: "Penelope" },
          { track_number: 6,  title: "Talby" },
          { track_number: 7,  title: "X.I.Y." },
          { track_number: 8,  title: "Prog" },
          { track_number: 9,  title: "Your Sickness" },
          { track_number: 10, title: "Seville" },
          { track_number: 11, title: "West" },
          { track_number: 12, title: "Tres" },
        ]
      },
    ]
  },
]

# We only want to run seeds once, if any artists exist, skip seeding DB
unless Artist.exists?
  ApplicationRecord.transaction do
    # Seed all the artist, album, song data
    SEED_DATA.each do |artist|
      new_artist = Artist.find_or_create_by!(name: artist[:name])
      artist[:albums].each do |album|
        new_album = new_artist.albums.create!(name: album[:name])
        album[:songs].each do |song|
          new_album.songs.create!(song.merge(length_seconds: rand(120..220)))
        end
      end
    end
    # Seed the basic user
    User.create!(email: "user@example.com", api_key: DEFAULT_API_KEY)
  end
end
