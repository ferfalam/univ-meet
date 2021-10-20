FactoryBot.define do
  factory :student do
    firstname {'john'}
    lastname {"doe"}
    phone_number {"11111111"}
    personal_number {'22222222'}
    email {'johndoe@gmail.com'}
    card_image {"image"}
    university {1}
    field {1}
    password {"password"}
  end
end
