
require 'faker'

puts Faker::Name.unique.name

puts Faker::Internet.email