#!/home/aviisekh/.rbenv/shims/ruby

require './person'
Person.create!(name:'Ram', start_time: '5:00', end_time: '7:00')
Person.create!(name:'Ram', start_time: '15:00', end_time: '20:45')
Person.create!(name:'Shyam', start_time: '12:00', end_time: '18:30')
Person.create!(name:'Hari', start_time: '08:00', end_time: '23:59')


p =  Person.where(name:"Ram")
trv = p.first.time_range_vector

v = RangeVector.new('12:00', '18:30')
binding.pry
# v.rangify('12:00', '18:30')
# p.first.time_range_vector
