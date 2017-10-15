User.create(username: "kevikim33", email: "kevikim33@gmail.com", password: "jumpman23")
User.create(username: "tlau", email: "tlau@gmail.com", password: "beanie")

Challenge.create(name: "Tahoe Trip", user_id: 1, budget: 350.2)
Challenge.create(name: "October: Eating out", user_id: 1, budget: 75.00)

Log.create(description: "ski", cost: 55)
Log.create(description: "bbq by lake", cost: 25)
Log.create(description: "popeye's", cost: 8)

Log.first.challenge_ids = [1]
Log.second.challenge_ids = [1,2]
Log.third.challenge_ids = [2]
