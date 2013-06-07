Rails Association Drills

SCENARIO 1

		class User
			has_many :posts
		end

		:class_name - "Post"
		:primary_key - "users.id"
		:foreign_key - "posts.user_id"

SCENARIO 2

		class User
			has_many :posts
		end

		:class_name => "Post"
		:primary_key => "users.id"
		:foreign_key => "posts.user_id"

		class Post
			belongs_to :user
		end

		:class_name => "User"
		:primary_key => "users.id"
		:foreign_key => "posts.user_id"

Scenario 3

		class User
			has_many :writings
		end

		class Post
			belongs_to :author
		end

		:class_name => "Writing"
		:primary_key => "users.id"
		:foreign_key => "writings.author_id"

		:class_name "Author"
		:primary_key => "authors.id"
		:foreign_key => "posts.author_id"

Scenario 4

		class Spaceman
			has_many :minions
			has_many :planet_visits
			has_one :spaceship
			belongs_to :race
		end

		:class_name => "Minion"
		:primary_key => "spacemen.id"
		:foreign_key => "minions.spaceman_id"

		:class_name => "PlanetVisit"
		:primary_key => "spacemen.id"
		:foreign_key => "planet_visits.spaceman_id"

		:class_name => "Spaceship"
		:primary_key => "spacemen.id"
		:foreign_key => "spaceships.spaceman_id"

		:class_name => "Race"
		:primary_key => "races.id"
		:foreign_key => "spacemen.race_id"

Scenario 5

#Building on Scenario 4

			class Minion
				belongs_to :overlord
			end

			class Visit
				belongs_to :visitor
				belongs_to :planet
			end

			class Spaceship
				belongs_to :owner
			end

			class Race
				has_many :people
			end

			class Planet
			end

			:class_name => "Overlord"
			:primary_key => "overlords.id"
			:foreign_key => "minions.overlord_id"

			:class_name => "Visitor"
			:primary_key => "visitors.id"
			:foreign_key => "visits.visitor_id"

			:class_name => "Planet"
			:primary_key => "planets.id"
			:foreign_key => "visitor.planet_id"

			:class_name => "Owner"
			:primary_key => "owners.id"
			:foreign_key => "spaceships.owner_id"

			:class_name => "Person"
			:primary_key => "races.id"
			:foreign_key => "person.race_id"

QUESTION 2

SCENARIO 3

		class User
			has_many :writings
		end

		class Post
			belongs_to :author
		end

		:class_name => "Post"
		:primary_key => "users.id"
		:foreign_key => "posts.author_id"

		:class_name "User"
		:primary_key => "users.id"
		:foreign_key => "posts.author_id"

SCENARIO 4 & 5

		class Spaceman
			has_many :minions
			has_many :planet_visits
			has_one :spaceship
			belongs_to :race
		end

		class Minion
			belongs_to :overlord
		end

		class Visit
			belongs_to :visitor
			belongs_to :planet
		end

		class Spaceship
			belongs_to :owner
		end

		class Race
			has_many :people
		end

		class Planet
		end

		#UNDER class Spaceman
		:class_name => "Minion"
		:primary_key => "spacemen.id"
		INCORRECT :foreign_key => "minions.spaceman_id" 
		CORRECT :foreign_key => "minions.overlord_id"

		:class_name => "Visit"
		:primary_key => "spacemen.id"
		:foreign_key => "visits.visitor_id"

		:class_name => "Spaceship"
		:primary_key => "spacemen.id"
		INCORRECT :foreign_key => "spaceships.spaceman_id"
		CORRECT :foreign_key => "spaceships.owner_id"

		:class_name => "Race"
		:primary_key => "races.id"
		:foreign_key => "spacemen.race_id"

		#UNDER class Minion
		:class_name => "Spaceman"
		:primary_key => "spacemen.id"
		:foreign_key => "minions.overlord_id"

		#UNDER class Visit
		:class_name => "Spaceman"
		:primary_key => "spacemen.id"
		:foreign_key => "visits.visitor_id"

		:class_name => "Planet"
		:primary_key => "planets.id"
		:foreign_key => "visits.planet_id"

		#UNDER class Spaceship
		:class_name => "Spaceman"
		:primary_key => "spacemen.id"
		:foreign_key => "spaceships.owner_id"

		#UNDER class Race
		:class_name => "Spaceman"
		:primary_key => "races.id"
		:foreign_key => "spacemen.race_id"

QUESTION 3

	class Spaceman
		has_many :planet_visits
		has_many :visited_planets, :through => :planet_visits, :source => :planet
	end

QUESTION 4

	class User
		has_many :memberships
		has_many :my_teams, :through => :memberships, :source =>:team
	end

class Membership
		belongs_to :user
		belongs_to :team
	end

	class Team
		has_many :memberships
		has_many :players, :through => :memberships, :source => :user
		# has_many :player_ids, through :players, :source => :membership
		#provided by the has_many association
	end

QUESTION 5

	class User
		has_many :posts
	end

	class Post
		belongs_to :user
	end

u = User.create(name: 'Jim')
u.post_ids = [3, 4, 5]

1. Yes

2. The foreign key "posts.user_id" for posts 3, 4, and 5 have all been changed from 1 to 2

3. Yes (database automatically updated by the .singular_id= method that is provided with the has_many association)

4. INCORRECT u1 = User.first
INCORRECT u1.post_ids = [1, 5]

Post.find(5).user = User.first

QUESTION 7

class Team
	has_many :memberships
	has many :users, :through => :memberships
end

class Membership
	belongs_to :user
	belongs_to :team
end

class User
	has_many :memberships
	has_many :teams, :through => :memberships, :source => :team
end


1. Yes
2. The foreign_key "team_id" on the membership class