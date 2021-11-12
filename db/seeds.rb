require 'faker'

case Rails.env
    when 'development'
      User.destroy_all
      puts ":reciclar: Destroyed all Users"
      puts 'Creating users...'

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
                    )
        user.save!
      end
    when 'test'
    # test-specific seeds ...
    # (Consider having your tests set up the data they need
    # themselves instead of seeding it here!)
    when 'production'
    # production seeds (if any) ...
end
