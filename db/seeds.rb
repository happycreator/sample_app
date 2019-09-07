## Users
User.create(name:  "ユーザー1",
  email: "user1@example.com",
  password:              "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now)

User.create(name:  "ユーザー2",
  email: "user2@example.com",
  password:              "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now)

User.create(name:  "管理者1",
  email: "admin1@example.com",
  password:              "password",
  password_confirmation: "password",
  admin:     true,
  activated: true,
  activated_at: Time.zone.now)

User.create(name:  "管理者2",
  email: "admin2@example.com",
  password:              "password",
  password_confirmation: "password",
  admin:     true,
  activated: true,
  activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }