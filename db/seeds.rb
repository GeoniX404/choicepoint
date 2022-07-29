# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

USERNAMES = ['rmgodfrey', 'GeoniX404', 'aackle00', 'chriswall24', 'donwaffle37']
NUMBER_OF_ADDITIONAL_USERS = 50
seconds_per_day = 86_400
DEADLINE_FIRST = Time.now - (15 * seconds_per_day) # 15 days before now
DEADLINE_LAST = Time.now + (30 * seconds_per_day) # 30 days after now
NUMBER_OF_CHOICE_POINTS = 3
HIGHEST_SCORE = 100
# Odds that a user votes for a particular choice point.
VOTE_PROBABILITY = 1.0 / 2.0
FEEDBACK_PROBABILITY = 0.5 / 2.0
FAVORITE_PROBABILITY = 0.5 / 2.0
REPUTATION_RANGE = 5..40

CHOICE_POINTS = [
  {
    title: "What should I wear for my job interview?",
    description: "I'm interviewing for a job as a technical writer for a major technology company",
    options: [
      {
        description: "Button-up shirt",
        pros: "I look good in button-up shirts",
        cons: "All of my button-up shirts are dirty"
      },
      {
        description: "Suit",
        pros: "Suits are considered very professional",
        cons: "I find them uncomfortable to wear"
      },
      {
        description: "T-shirt",
        pros: "I find T-shirts very comfortable",
        cons: "They’re not considered very professional"
      }
    ]
  },
  {
    title: "What should I name my cat?",
    description: "I just got an orange cat. She’s very playful, and loves to roll over. But I can’t think of a name!",
    options: [
      {
        description: "Vinny",
        pros: "She likes to hang out by the window, which is called a 'vindu' in Norwegian.",
        cons: "The name takes a long time to explain"
      },
      {
        description: "Odo",
        pros: "Named after my favorite Star Trek character",
        cons: "Maybe not appropriate for a cat?"
      },
      {
        description: "Wrinkles",
        pros: "This is what the cat was called at the shelter.",
        cons: "I’m not personally a big fan of this name."
      }
    ]
  },
  {
    title: "Where should I go on vacation?",
    description: "I have two weeks off from work, and I want to make the most of them.",
    options: [
      {
        description: "Tokyo",
        pros: "I’ve wanted to go to Tokyo all my life.",
        cons: "I don’t speak Japanese, and it will probably be hard for me to get around."
      },
      {
        description: "New York",
        pros: "I live nearby, so the trip won’t be very long.",
        cons: "It’s boring to travel so close to home!"
      },
      {
        description: "London",
        pros: "I want to see the famous sights, like Big Ben and Buckingham Palace.",
        cons: "I’m not really sure what else to see aside from the big sights."
      },
      {
        description: "Paris",
        pros: "I want to eat all sorts of delicious French pastries.",
        cons: "I’m worried the weather will be a bit too warm for me."
      },
      {
        description: "Sydney",
        pros: "I want to go to the beaches.",
        cons: "The flight to get there is very long!"
      }
    ]
  },
  {
    title: "What car should I buy?",
    description: "I’ve never bought a car before, and I need a little help! I’ve narrowed it down to two options.",
    options: [
      {
        description: "Chevrolet Malibu",
        pros: "The seats seem really comfortable.",
        cons: "The trunk seems small."
      },
      {
        description: "Toyota Camry",
        pros: "Has a very good track record.",
        cons: "I’ve heard they’re a bit loud."
      },
    ]
  },
  {
    title: "Which programming language should I learn?",
    description: "I've decided to start learning to program, and I’m wondering which languages are most learner-friendly.",
    options: [
      {
        description: "Ruby",
        pros: "It seems almost like English in some ways.",
        cons: "The documentation seems hard to read."
      },
      {
        description: "Python",
        pros: "Has a very vibrant online community.",
        cons: "The meaningful whitespace might get confusing."
      },
      {
        description: "JavaScript",
        pros: "I’ll need to learn it if I want to do front-end web development.",
        cons: "It’s a bit intimidating!"
      }
    ]
  },
  {
    title: "How long should I wait before following up on the interview?",
    description: "I was interviewed for a job last week, and I still haven’t heard back!",
    options: [
      {
        description: "Two more weeks",
      },
      {
        description: "One more week",
      },
      {
        description: "Follow up right now!",
      }
    ]
  },
  {
    title: "Which of my employees should I promote?",
    description: "To protect their identities, I’ll use pseudonyms.",
    options: [
      {
        description: "Amy",
        pros: "She’s a really hard worker.",
        cons: "She’s often late to work."
      },
      {
        description: "Ezekiel",
        pros: "He responds very quickly to emails.",
        cons: "He doesn’t get along well with others."
      },
      {
        description: "Barton",
        pros: "He gets me coffee every day.",
        cons: "He’s probably just doing that to get promoted."
      },
      {
        description: "Shizue",
        pros: "She’s the smartest person in the office.",
        cons: "She’s still quite inexperienced."
      }
    ]
  },
  {
    title: "Where should I go to college?",
    description: "I live in the western United States, and I’m interested in studying science.",
    options: [
      {
        description: "UCLA",
      },
      {
        description: "UC Berkeley",
      },
      {
        description: "UC Santa Barbara",
      },
      {
        description: "University of Southern California",
      },
      {
        description: "University of Arizona"
      }
    ]
  },
  {
    title: "What book should I read next?",
    description: "I like all kinds of books—genre is not really an issue!",
    options: [
      {
        description: "Wolf Hall",
      },
      {
        description: "Half of a Yellow Sun",
      },
      {
        description: "Normal People",
      },
      {
        description: "The Emperor of All Maladies",
      },
      {
        description: "Persepolis"
      }
    ]
  },
  {
    title: "Which transit route should I take to school?",
    description: "I live in the Leslieville neighbourhood in Toronto, Canada, and I go to school at the University of Toronto.",
    options: [
      {
        description: "31 bus to Greenwood Station, and then the subway to St. George.",
      },
      {
        description: "Walk up to Gerrard, and take the 506 streetcar to St. George.",
      },
      {
        description: "Walk down to Queen, take the 501 streetcar to Osgoode, and take the subway up to Queen’s Park.",
      },
    ]
  },
  {
    title: "Should I tell my friend that I don’t find his jokes funny?",
    description: "He’s very dear to me, but sometimes his jokes just don’t land.",
    options: [
      {
        description: "Yes",
      },
      {
        description: "No",
      },
    ]
  },
  {
    title: "Which operating system should I use on my computer?",
    description: "I don’t know anything about computers… I need help!",
    options: [
      {
        description: "Windows",
      },
      {
        description: "MacOS",
      },
      {
        description: "Linux",
      },
    ]
  },
  {
    title: "What subject should I study in school?",
    description: "Nothing really interests me that much, but I have to pick something!",
    options: [
      {
        description: "Political science",
      },
      {
        description: "History",
      },
      {
        description: "Philosophy",
      },
      {
        description: "Psychology",
      },
      {
        description: "Classics",
      },
      {
        description: "English",
      },
    ]
  },
  {
    title: "What TV show should I start watching?",
    description: "I don’t have a lot of free time, so I have to pick wisely!",
    options: [
      {
        description: "Stranger Things",
      },
      {
        description: "Better Call Saul",
      },
      {
        description: "Peaky Blinders",
      },
      {
        description: "Severance",
      },
    ]
  },
  {
    title: "What kind of laundry detergent should I use?",
    description: "I’ve been getting so much conflicting advice, and I just want my clothes to be clean!",
    options: [
      {
        description: "Liquid detergent",
      },
      {
        description: "Powder detergent",
      },
      {
        description: "Pods",
      },
    ]
  },
].shuffle

def create_users
  USERNAMES.each do |username|
    email = "#{username}@mail.com"
    password = '123456'
    user = User.create!(
      email: email,
      password: password,
      name: username,
      reputation: username == "donwaffle37" ? 34 : rand(REPUTATION_RANGE)
    )
    puts "Created user #{username}\n\tEmail: #{email}\n\tPassword: '#{password}'"
    create_choice_points(user)
  end
  create_additional_users
end

def make_users_do_things
  User.all.each do |user|
    ChoicePoint.all.each do |choice_point|
      if choice_point.user == user && choice_point.expired? && rand < FEEDBACK_PROBABILITY
        chosen_option = choice_point.options.sample
        chosen_option.chosen = true
        chosen_option.save
        choice_point.successful = [true, false].sample
        choice_point.feedback = "Feedback Provided"
        choice_point.save
        chosen_users = chosen_option.voters
        if choice_point.successful
          chosen_users.each do |user|
            user.update(reputation: user.reputation + 5)
          end
        end
      elsif choice_point.user != user && rand < VOTE_PROBABILITY
        option = choice_point.options.sample
        vote = Vote.create!(option: option, user: user)
        option.increase_score(vote)
      end
      if choice_point.user != user && rand < FAVORITE_PROBABILITY
        user.favorite(choice_point)
      end
    end
    puts "#{user.name} has voted, provided feedback, and favorited choice points"
  end
end

def create_additional_users
  NUMBER_OF_ADDITIONAL_USERS.times do
    user = Faker::Internet.user
    # Could be refactored
    User.create!(
      email: user[:email],
      password: '123456',
      name: user[:username],
      reputation: rand(REPUTATION_RANGE)
    )
    puts "Created #{user[:username]}"
  end
end

def create_choice_points(user)
  NUMBER_OF_CHOICE_POINTS.times do
    cp = CHOICE_POINTS.pop
    choice_point = ChoicePoint.create!(
      title: cp[:title],
      description: cp[:description],
      user: user,
      # Gets a random time between DEADLINE_FIRST and DEADLINE_LAST
      # See "https://stackoverflow.com/questions/2683857/how-to-generate-a-random-date-and-time-between-two-dates"
      deadline: Time.at(
        ((DEADLINE_LAST.to_f - DEADLINE_FIRST.to_f) * rand) + DEADLINE_FIRST.to_f
      )
    )
    create_options(choice_point, cp[:options])
  end
end

def create_options(choice_point, options)
  options.each do |option|
    Option.create!(
      description: option[:description],
      pros: option[:pros],
      cons: option[:cons],
      choice_point: choice_point,
      score: HIGHEST_SCORE * rand
    )
  end
end

puts "Destroying existing users and choice points"
User.destroy_all
puts "Creating seeds..."
create_users
make_users_do_things
puts "New seeds created"
