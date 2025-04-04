require 'faker'
require 'open-uri'
require 'json'

puts "Cleaning up database..."
# Destroy in the correct order to avoid foreign key constraints
puts "Destroying Ratings..."
Rating.destroy_all if defined?(Rating)
puts "Destroying Messages..."
Message.destroy_all if defined?(Message)
puts "Destroying Chatrooms..."
Chatroom.destroy_all if defined?(Chatroom)
puts "Destroying Invitations..."
Invitation.destroy_all if defined?(Invitation)
puts "Destroying Friendships..."
Friendship.destroy_all if defined?(Friendship)
puts "Destroying GamesSessionList..."
GamesSessionList.destroy_all if defined?(GamesSessionList)
puts "Destroying GameSessions..."
GameSession.destroy_all if defined?(GameSession)
puts "Destroying GamesListGames..."
GamesListGame.destroy_all if defined?(GamesListGame)
puts "Destroying GamesLists..."
GamesList.destroy_all if defined?(GamesList)
puts "Destroying Games..."
Game.destroy_all if defined?(Game)
puts "Destroying Platforms..."
Platform.destroy_all if defined?(Platform)
puts "Destroying Users..."
User.destroy_all if defined?(User)
puts "Database cleaned"

case Rails.env
    when 'development', 'production'
      puts 'Creating users...'

      admin = User.new(
                    first_name: "Admin",
                    last_name: "Admin",
                    age: 58,
                    nickname: "Admin",
                    email: "test@test.com",
                    password: "password",
                    # photo: image_tag "profile.png"
                    )
      admin.save!
      puts "✅ Created admin user"

      9.times do |i|
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name

        # Use a different image service that's more reliable
        begin
          file = URI.open("https://randomuser.me/api/portraits/#{['men', 'women'].sample}/#{i+1}.jpg")
        rescue OpenURI::HTTPError => e
          puts "⚠️ Failed to get avatar image, using placeholder"
          file = URI.open("https://via.placeholder.com/300")
        end

        user = User.new(
                    first_name: first_name,
                    last_name: last_name,
                    age: rand(16..55),
                    nickname: Faker::Internet.slug(words: first_name.downcase + ' ' + last_name.downcase),
                    email: Faker::Internet.email(name: first_name.downcase + ' ' +  last_name.downcase, separators: '_'),
                    password: "123456",
                    )

        user.photo.attach(io: file, filename: 'avatar.jpg', content_type: 'image/jpeg')
        if user.save!
          puts "✅ Created user #{i+1}: #{user.nickname}"
        end
      end
    when 'test'
      # test-specific seeds ...
      # (Consider having your tests set up the data they need
      # themselves instead of seeding it here!)
end

puts "Creating platforms..."
pc_platform = Platform.create(name: "PC (Windows)")
browser_platform = Platform.create(name: "Web Browser")
puts "Platforms created"

puts "Fetching games from API..."

# Add error handling for API fetch
begin
  url = "https://www.freetogame.com/api/games"
  games_data = JSON.parse(URI.open(url).read)
  puts "✅ Successfully fetched #{games_data.length} games from API"
rescue => e
  puts "⚠️ Error fetching games from API: #{e.message}"
  # Fallback to sample data if API fails
  puts "Using sample game data instead"
  games_data = [
    {"id" => 582,"title" => "Tarisland","thumbnail" => "https://www.freetogame.com/g/582/thumbnail.jpg","short_description" => "A cross-platform MMORPG developed by Level Infinite and Published by Tencent.","game_url" => "https://www.freetogame.com/open/tarisland","genre" => "MMORPG","platform" => "PC (Windows)","publisher" => "Tencent","developer" => "Level Infinite","release_date" => "2024-06-22","freetogame_profile_url" => "https://www.freetogame.com/tarisland"},
    {"id" => 540,"title" => "Overwatch 2","thumbnail" => "https://www.freetogame.com/g/540/thumbnail.jpg","short_description" => "A hero-focused first-person team shooter from Blizzard Entertainment.","game_url" => "https://www.freetogame.com/open/overwatch-2","genre" => "Shooter","platform" => "PC (Windows)","publisher" => "Activision Blizzard","developer" => "Blizzard Entertainment","release_date" => "2022-10-04","freetogame_profile_url" => "https://www.freetogame.com/overwatch-2"},
    {"id" => 516,"title" => "PUBG: BATTLEGROUNDS","thumbnail" => "https://www.freetogame.com/g/516/thumbnail.jpg","short_description" => "Get into the action in one of the longest running battle royale games PUBG Battlegrounds.","game_url" => "https://www.freetogame.com/open/pubg","genre" => "Shooter","platform" => "PC (Windows)","publisher" => "KRAFTON, Inc.","developer" => "KRAFTON, Inc.","release_date" => "2022-01-12","freetogame_profile_url" => "https://www.freetogame.com/pubg"}
  ]
end

puts "Creating games with enhanced data..."
games_created = 0

# Check if all the fields exist in the Game model
game_attributes = Game.column_names
needs_migration = false

# Check for developer attribute
unless game_attributes.include?('developer')
  puts "⚠️ 'developer' field is missing from Game model."
  needs_migration = true
end

# Check for publisher attribute
unless game_attributes.include?('publisher')
  puts "⚠️ 'publisher' field is missing from Game model."
  needs_migration = true
end

# Check for release_date attribute
unless game_attributes.include?('release_date')
  puts "⚠️ 'release_date' field is missing from Game model."
  needs_migration = true
end

# Check for game_url attribute
unless game_attributes.include?('game_url')
  puts "⚠️ 'game_url' field is missing from Game model."
  needs_migration = true
end

# Check for freetogame_profile_url attribute
unless game_attributes.include?('freetogame_profile_url')
  puts "⚠️ 'freetogame_profile_url' field is missing from Game model."
  needs_migration = true
end

if needs_migration
  puts "⚠️ Some fields are missing from the Game model. Only using available fields."
  puts "Run this migration: rails g migration AddDetailsToGames developer:string publisher:string release_date:string game_url:string freetogame_profile_url:string"
end

games_data.each do |game_data|
  # Find or create platform
  platform_name = game_data['platform']
  platform = Platform.find_or_create_by(name: platform_name)

  # Create the game with more fields from the API
  puts "Creating #{game_data['title']}"

  # Create the game with additional details, but only if the fields exist
  game_params = {
    name: game_data['title'],
    summary: game_data['short_description'],
    thumbnail: game_data['thumbnail'],
    category: game_data['genre'],
    platform_id: platform.id
  }

  # Only add these fields if they exist in the model
  game_params[:developer] = game_data['developer'] if game_attributes.include?('developer')
  game_params[:publisher] = game_data['publisher'] if game_attributes.include?('publisher')
  game_params[:release_date] = game_data['release_date'] if game_attributes.include?('release_date')
  game_params[:game_url] = game_data['game_url'] if game_attributes.include?('game_url')
  game_params[:freetogame_profile_url] = game_data['freetogame_profile_url'] if game_attributes.include?('freetogame_profile_url')

  game = Game.new(game_params)

  # Save the game and handle errors
  if game.save
    puts "✅ Created #{game.name}"
    games_created += 1
  else
    puts "❌ Failed to create #{game_data['title']}: #{game.errors.full_messages.join(', ')}"
  end
end

puts "#{games_created} games created successfully!"

# Create some example game sessions
puts "Creating game sessions..."
User.all.each do |user|
  # Each user creates 1-3 game sessions
  rand(1..3).times do
    game = Game.all.sample
    date = Faker::Date.between(from: Date.today, to: 1.month.from_now)
    time = DateTime.now + rand(9..17).hours

    game_session = GameSession.new(
      user: user,
      game: game,
      date: date,
      time: time,
      description: [
        "Let's team up and conquer #{game.name}! All skill levels welcome.",
        "Looking for teammates to play #{game.name}. Voice chat preferred.",
        "Casual #{game.name} session - just for fun!",
        "Competitive #{game.name} - serious players only",
        "Beginners welcome! Learning #{game.name} together."
      ].sample
    )

    if game_session.save
      # Create a chatroom for this session
      chatroom = Chatroom.create(
        game_session: game_session,
        name: "#{game.name} #{game_session.id}"
      )

      puts "✅ Created game session for #{game.name} hosted by #{user.nickname}"
    else
      puts "❌ Failed to create game session: #{game_session.errors.full_messages.join(', ')}"
    end
  end
end

puts "Creating sample ratings..."
# Check if Rating model exists
if defined?(Rating)
  # Check if the necessary columns exist
  rating_attributes = Rating.column_names
  if rating_attributes.include?('score') && rating_attributes.include?('comment')
    # Add some sample ratings
    User.all.each do |user|
      # Each user rates 2-5 games
      Game.all.sample(rand(2..5)).each do |game|
        rating = Rating.new(
          user: user,
          game: game,
          score: rand(3..5),  # Mostly positive ratings
          comment: [
            "Really enjoying this game!",
            "Great gameplay, highly recommend.",
            "Fun to play with friends.",
            "Good game but needs some improvements.",
            "Awesome graphics and storyline.",
            "Worth playing if you like this genre.",
            nil  # Some ratings without comments
          ].sample
        )

        if rating.save
          puts "✅ #{user.nickname} rated #{game.name}: #{rating.score}/5"
        else
          puts "❌ Failed to create rating: #{rating.errors.full_messages.join(', ')}"
        end
      end
    end
  else
    puts "⚠️ Rating model exists but doesn't have the expected columns. Skipping ratings creation."
  end
else
  puts "⚠️ Rating model not found. Skipping ratings creation."
end

puts "Seed completed successfully! 🎮"
