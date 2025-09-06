# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Create initial pricing data for the carpet calculator
Price.find_or_create_by(name: 'carpet_fitting_cost') do |price|
  price.value = 7.50
  price.description = 'Cost per square meter for carpet fitting'
end

Price.find_or_create_by(name: 'vinyl_fitting_cost') do |price|
  price.value = 10.50
  price.description = 'Cost per square meter for vinyl fitting'
end

Price.find_or_create_by(name: 'gripper_rod_price') do |price|
  price.value = 60.30
  price.description = 'Price per box of gripper rods (covers 152 sqm)'
end

Price.find_or_create_by(name: 'underlay_price_per_roll') do |price|
  price.value = 60.00
  price.description = 'Price per roll of underlay (covers 15 sqm)'
end

Price.find_or_create_by(name: 'spray_adhesive_price') do |price|
  price.value = 60.00
  price.description = 'Price for 12 tins of spray adhesive (1 tin per 10 sqm)'
end

Price.find_or_create_by(name: 'door_trim_price') do |price|
  price.value = 9.00
  price.description = 'Price per door trim'
end

Price.find_or_create_by(name: 'plyboarding_cost') do |price|
  price.value = 10.50
  price.description = 'Cost per square meter for plyboarding'
end

Price.find_or_create_by(name: 'plyboard_price') do |price|
  price.value = 34.00
  price.description = 'Price per plyboard sheet (covers 2.9768 sqm)'
end

Price.find_or_create_by(name: 'min_charge') do |price|
  price.value = 150.00
  price.description = 'Minimum charge for small rooms'
end

puts "Seeded #{Price.count} pricing records"
