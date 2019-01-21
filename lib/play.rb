#!/home/aviisekh/.rbenv/shims/ruby

require './person'
Person.create!(name:'Ram', start_time: '5:00', end_time: '7:00')
Person.create!(name:'Ram', start_time: '15:00', end_time: '20:45')
Person.create!(name:'Shyam', start_time: '12:00', end_time: '18:30')
Person.create!(name:'Hari', start_time: '08:00', end_time: '23:59')

p = Person.where(name:"Ram")
trv = p.first.time_range_vector
p.first.store_time_range_vector
v = RangeVector.new('12:00', '18:30') 
a = p.first.available_for?('1:00', '5:00')
b = p.first.available_for?('6:00', '6:30')
c = p.first.available_for?('15:30', '21:30')

# v.rangify('12:00', '18:30')
# p.first.time_range_vector

def person_available_for(start_time, end_time)
    available_people = []
    Person.select(:name).distinct.each do |person|
        available_people << person if person.available_for?(start_time, end_time) 
    end

    return available_people
end

message = "Available Persons are "

person_available_for("15:30","18:00").each do |person|
    message += person.name + ","
end

puts message