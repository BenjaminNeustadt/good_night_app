
user_1 = User.create(name: "Jon")
user_1.sleeps.create(created_at: Time.now - 20.hours, updated_at: Time.now - 6.hours)

user_2 = User.create(name: "Dan")
user_2.sleeps.create(created_at: Time.now - 15.hours, updated_at: Time.now - 5.hours)

user_3 = User.create(name: "Tony")
user_3.sleeps.create(created_at: Time.now - 12.hours, updated_at: Time.now - 9.hours)
user_3.followers.create(name: "Stacy")

user_4 = User.create(name: "Franko")
user_4.sleeps.create(created_at: Time.now - 10.hours, updated_at: Time.now - 9.hours)
