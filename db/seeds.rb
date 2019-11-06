for i in 1..10
    user = User.create(
        email: "test+#{i}@test.com",
        password: "Testing123"
    )

    puts "Created user #{user.id}"

    for y in 1..rand(1..3)
        user.fish.create(
            name: Faker::Creature::Animal.name,
            description: Faker::Lorem.paragraph,
            price: rand(100..300000)
        )

        puts "Create fish #{y} on user #{user.id}"
    end
end