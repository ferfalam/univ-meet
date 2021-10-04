##University Seed
University.create(
    {
        email: Faker::Internet.unique.email,
        password: "password",
        admin: true
    }
)

15.times do
    University.create(
        {
            name: Faker::University.unique.name,
            acronym: Faker::University.unique.greek_organization,
            phone_number: Faker::PhoneNumber.unique.phone_number,
            email: Faker::Internet.unique.email,
            password: "password",
        }
    )
end

##fields seed && group seed
20.times do
    field = Field.create(
        {
            name: Faker::University.unique.name,
            acronym: Faker::University.unique.greek_organization,
            university_id: Random.rand(2..15)
        }
    )

    Group.create(
        {
            name: "Groupe de #{field.name}"
        }
    )
end

##requests seed
20.times do
    Request.create(
        {
            title: Faker::Lorem.sentence(2),
            description: Faker::Lorem.paragraph(5),
            university_id: Random.rand(2..15)
        }
    )
end

## Student seed && Group Student Map
50.times{
    student = Student.create(
        {
            firstname: Faker::Name.first_name,
            lastname: Faker::Name.last_name,
            phone_number: Faker::PhoneNumber.unique.phone_number,
            personal_number: Faker::PhoneNumber.unique.phone_number,
            email: Faker::Internet.unique.email,
            password: "password",
            card_image: Faker::Avatar.image, 
            valid_until: Faker::Date.between_except(from: Date.today, to:1.year.from_now, excepted: Date.today),
            university_id: Random.rand(2..15),
            field_id: Random.rand(1..20),
        }
    )

    GroupStudentsMap.create(
        {
            student_id: student.id,
            group_id: student.field_id
        }
    )
}

## Post seed
100.times do
    Post.create(
        {
            image: Faker::Avatar.image, 
            content: Faker::Lorem.paragraph(5),
            student_id: Random.rand(1..50)
        }
    )
end

## Favorite seed
70.times do
   Favorite.create(
       {
           post_id: rand(1..100),
           student_id: rand(1..50)
       }
   ) 
end

## Conversation seed
25.times do
    Conversation.create(
        {
            statut: ['personal', 'group'].sample,
            receiver_id: rand(1..20),
            student_id: rand(1..50)
        }
    )
end

## Messages seed
150.times do
    Message.create(
        {
            content: Faker::Lorem.paragraph(5),
            conversation_id: rand(1..25),
            student_id: rand(1..50)
        }
    )
end