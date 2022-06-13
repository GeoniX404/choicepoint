# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USERNAMES = ['rmgodfrey', 'aackle00', 'GeoniX404', 'chriswall24']
# Turn this hash into an array to get a random sample
CHOICE_POINTS = {
  "What should I wear to my job interview?" => ["Button-up shirt", "Suit", "T-shirt"],
  "What car should I buy?" => ["Chevrolet", "Toyota"],
  "Where should I live?" => ["Tokyo", "New York", "London", "Paris", "Sydney", "Berlin"]
}.to_a
DAY_RANGE = 30
seconds_per_day = 86_400
DEADLINE_FIRST = Time.now - (DAY_RANGE * seconds_per_day)
DEADLINE_LAST = Time.now + (DAY_RANGE * seconds_per_day)
NUMBER_OF_CHOICE_POINTS = 3
HIGHEST_SCORE = 100
# Odds that a user votes for a particular choice point.
VOTE_PROBABILITY = 2.0 / 3.0

def create_users
  USERNAMES.each do |username|
    email = "#{username}@mail.com"
    password = '123456'
    user = User.create!(
      email: email,
      password: password,
      name: username,
      reputation: rand(5..40)
    )
    puts "Created user #{username}\n\tEmail: #{email}\n\tPassword: '#{password}'"
    create_choice_points(user)
  end
end

def make_users_vote
  User.all.each do |user|
    ChoicePoint.all.each do |choice_point|
      next if choice_point.user == user || rand > VOTE_PROBABILITY

      option = choice_point.options.sample
      vote = Vote.create!(option: option, user: user)
      option.increase_score(vote)
    end
  end
end

def create_choice_points(user)
  NUMBER_OF_CHOICE_POINTS.times do
    title, option_descriptions = CHOICE_POINTS.sample
    choice_point = ChoicePoint.create!(
      title: title,
      description: Faker::Lorem.sentence,
      user: user,
      # Gets a random time between DEADLINE_FIRST and DEADLINE_LAST
      # See "https://stackoverflow.com/questions/2683857/how-to-generate-a-random-date-and-time-between-two-dates"
      deadline: Time.at(
        ((DEADLINE_LAST.to_f - DEADLINE_FIRST.to_f) * rand) + DEADLINE_FIRST.to_f
      )
    )
    create_options(choice_point, option_descriptions)
  end
end

def create_options(choice_point, option_descriptions)
  option_descriptions.each do |description|
    Option.create!(
      description: description,
      pros: Faker::Lorem.sentence,
      cons: Faker::Lorem.sentence,
      choice_point: choice_point,
      # score: HIGHEST_SCORE * rand
    )
  end
end

puts "Destroying existing users and choice points"
User.destroy_all
puts "Creating seeds..."
create_users
make_users_vote
puts "New seeds created"
