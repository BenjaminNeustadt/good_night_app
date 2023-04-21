# Seed users
user1 = User.create(name: "Jon")
user2 = User.create(name: "Dan")
user3 = User.create(name: "Tony")
user4 = User.create(name: "Abdul")
user5 = User.create(name: "Kwame")

# Seed sleeps
sleep1  = Sleep.create(created_at: Time.now - 7.hours, updated_at: Time.now, user: user1)
sleep2  = Sleep.create(created_at: Time.now - 8.hours, updated_at: Time.now, user: user1)
sleep3  = Sleep.create(created_at: Time.now - 6.hours, updated_at: Time.now, user: user1)
sleep4  = Sleep.create(created_at: Time.now - 5.hours, updated_at: "Still sleeping...", user: user2)
sleep5  = Sleep.create(created_at: Time.now - 9.hours, updated_at: Time.now, user: user2)
sleep6  = Sleep.create(created_at: Time.now - 11.hours, updated_at: Time.now, user: user3)
sleep7  = Sleep.create(created_at: Time.now - 9.hours, updated_at: "Still sleeping...", user: user4)
sleep8  = Sleep.create(created_at: Time.now - 8.hours, updated_at: "Still sleeping...", user: user4)
sleep9  = Sleep.create(created_at: Time.now - 7.hours, updated_at: Time.now, user: user5)
sleep10 = Sleep.create(created_at: Time.now - 6.hours, updated_at: Time.now, user: user5)
sleep11 = Sleep.create(created_at: Time.now - 6.hours, updated_at: Time.now, user: user5)
sleep12 = Sleep.create(created_at: Time.now - 7.hours, updated_at: Time.now, user: user5)
sleep13 = Sleep.create(created_at: Time.now - 7.hours, updated_at: "Still sleeping...", user: user5)

# Seed followers

Follow.create(follower: user1, followee: user2)
Follow.create(follower: user2, followee: user3)
Follow.create(follower: user3, followee: user1)
Follow.create(follower: user5, followee: user1)
Follow.create(follower: user4, followee: user5)
