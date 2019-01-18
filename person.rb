require 'active_record'
require 'pry'

# Assumptions
# Assume datetime is a string field
# 30 minutes is the first hour and 24*60 minutes is the  last
# left open , right closed range, open excludes the end point (]
# give priority to the available time rather than unavailable time

MINUTE_STEP = 30 # minutes steps considered for the available slots
TOTAL_HOURS = 24 # Total hours in a day
MINUTES_IN_HOUR = 60 # Minutes in one hour
TOTAL_MINUTES = 1440 # Total minutes in a day


# Set up a database that resides in RAM
ActiveRecord::Base.establish_connection(
  adapter:  'postgresql', # or 'postgresql' or 'sqlite3'
  database: 'ict_test',
  username: 'postgres',
  password: 'abhishek',
  host:     'localhost'
)

# Set up database tables and columns
ActiveRecord::Schema.define do
  create_table :people, force: true do |t|
    t.string :name
    t.string :start_time
    t.string :end_time
    t.text :t_r_vector
  end
end

# # Set up model classes
# class ApplicationRecord < ActiveRecord::Base
#   self.abstract_class = true
# end

# String Class
class String
  def minutize
    time_arr = split(':').map{ |x| x.to_i}
    time_arr[0] * 60 + time_arr[1]
  end
end

# Range Vector Class
class RangeVector
  attr_reader :vector

  def initialize(start_time='0:0', end_time='0:0')
    @vector = rangify(start_time, end_time)
  end

  def rangify(start_time, end_time)
    range_vector = []
    (MINUTE_STEP..TOTAL_MINUTES).step(MINUTE_STEP) do |x|
      range_vector << ((x > start_time.minutize && x <= end_time.minutize) ? 1 : 0)
    end
    range_vector
  end
end

# Person Class
class Person < ActiveRecord::Base
  serialize :t_r_vector
  
  def time_range_vector
    time_range_vector_size = (MINUTES_IN_HOUR/MINUTE_STEP)*TOTAL_HOURS
    vr = RangeVector.new

    available_time_ranges = Person.where(name: self.name).pluck(:start_time,:end_time)
    time_range_availability_vector = Array.new(time_range_vector_size,0)

    available_time_ranges.each do |at|
      range_vector = vr.rangify(at[0], at[1])
      range_vector.each_with_index do |element,index|
        was_previously_slot_available = !time_range_availability_vector[index].zero?
        is_slot_available = !range_vector[index].zero?
        time_range_availability_vector[index] = (was_previously_slot_available || is_slot_available) ? 1 : 0 
      end
    end

    time_range_availability_vector
  end

  def available_for?(start_time, end_time)
    to_check_range_vector = RangeVector.new(start_time, end_time).vector
    time_range_vector.each_with_index do |availability, index|
      return false if (availability - to_check_range_vector[index]) < 0
    end
    return true
  end

  def store_time_range_vector
    self.update!(t_r_vector: time_range_vector)
  end
end
