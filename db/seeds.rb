require 'faker'
require 'open-uri'
require 'json'


case Rails.env
    when 'development'
      User.destroy_all
      puts ":reciclar: Destroyed all Users"
      puts 'Creating users...'
      # file = URI.open('https://i.pravatar.cc/{size}')
      admin = User.new(
                    first_name: "Admin",
                    last_name: "Admin",
                    age: 58,
                    nickname: "Admin",
                    email: "test@test.com",
                    password: "password"
                    )
      admin.save!

      9.times do
        first_name = Faker::Name.first_name
        last_name = Faker::Name.last_name
        user = User.new(
                    first_name: first_name,
                    last_name: last_name,
                    age: rand(16..55),
                    nickname: Faker::Internet.slug(words: first_name.downcase + ' ' + last_name.downcase),
                    email: Faker::Internet.email(name: first_name.downcase + ' ' +  last_name.downcase, separators: '_'),
                    password: Faker::Internet.password(min_length: 6)
                    # User.photo.attach(io: file, filename: 'nes.png', content_type: 'image/png')
                    )
        user.save!
        chat = Chatroom.new
        chat.user = user
        chat.save!
      end
    when 'test'
    # test-specific seeds ...
    # (Consider having your tests set up the data they need
    # themselves instead of seeding it here!)
    when 'production'
    # production seeds (if any) ...
end

puts "Cleaning up database..."
Game.destroy_all
puts "Database cleaned"

url = "https://www.freetogame.com/api/games"
  games = JSON.parse(open("#{url}").read)
  games.each do |game|
    platform = Platform.find_or_create_by(name: game['platform'])
    puts "Creating #{game['title']}"
    Game.create(
      name: game['title'],
      summary: game['short_description'],
      thumbnail: game['thumbnail'],
      category: game['genre'],
      platform_id: platform.id
    )
  end
puts "Games created"
