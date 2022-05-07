# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

post_code= ["35000", "75000", "31000", "33000", "85000", "17000", "33000", "69000", "35360", "29000", "56000", "22000", "31360"]

#cities
10.times do
    City.create!(name: Faker::Nation.capital_city, zip_code: post_code.sample )
end

#users
20.times do
    firstname = Faker::Name.first_name
    lastname = Faker::Name.last_name
    email = firstname + "." + lastname + "@thp.com"
    phone = Faker::Number.leading_zero_number(digits: 10)
    User.create!(email:email, phone_number: phone, description:  Faker::Quotes::Shakespeare.as_you_like_it_quote , city: City.all.sample)
end

#housings
50.times do
    puts "Housing"
    admin = User.all.sample
    bed = 0
    while bed ==0
        bed = Faker::Number.number(digits: 1)
    end
    price = bed * Faker::Number.between(from: 25, to: 40)
    des = Faker::Lorem.paragraphs
    welcome = Faker::Lorem.sentence

    housing = Housing.create!(admin: admin, available_beds: bed, price: price, description: des, welcome_message: welcome, city: City.all.sample)

    #reservations
    5.times do
        loop do
            startdate = 0
            enddate = 20
            while (enddate - startdate).to_i > 10 #séjour de 10 jours max
            startdate = Faker::Date.between(from: Date.today, to: 6.months.from_now)
            enddate = Faker::Date.between(from: startdate, to: 6.months.from_now)
            end
            resa = Reservation.new(guest: User.all.sample, housing: housing, start_date: startdate, end_date: enddate)
            if resa.save
                p "start date: #{startdate}, #{enddate}  et durée #{resa.reservation_duration}"
                break
            end
        end
    end
    5.times do
        loop do
            startdate = 0
            enddate = 20
            while (enddate - startdate).to_i > 10 #séjour de 10 jours max
            startdate = Faker::Date.between(from: 6.months.ago , to: 10.days.ago)
            enddate = Faker::Date.between(from: startdate , to: Date.today)
            end
            resa = Reservation.new(guest: User.all.sample, housing: housing, start_date: startdate, end_date: enddate)
            if resa.save
                p "start date: #{startdate}, #{enddate}  et durée #{resa.reservation_duration}"
                break
            end
        end
    end

end