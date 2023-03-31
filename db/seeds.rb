# Create two test users

# First user will "clock in" once
user_1 = User.create(name: "Jon")
user_1.sleeps.create

# First user will "clock in" twice
user_2 = User.create(name: "Dan")
user_2.sleeps.create
user_2.sleeps.create


user_3 = User.create(name: "Tony")
user_3.sleeps.create
user_3.followers.create(name: "Stacy")