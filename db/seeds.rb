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

# Create settings for content management
Setting.find_or_create_by(key: 'about_us') do |setting|
  setting.value = "At GT Carpets, we pride ourselves on our rich history of delivering unparalleled carpet services. Founded by Gareth Taylor, a seasoned expert with over two decades of experience in the carpet industry, our company has established itself as a beacon of quality and reliability in Buxton, UK.

Gareth's journey began as a passionate apprentice, quickly evolving into a master of the trade. His expertise, coupled with a keen eye for detail and dedication to customer satisfaction, has driven GT Carpets to become the go-to choice for clients seeking top-notch carpet and flooring solutions.

Our mission is simple: to provide exceptional service and high-quality products that meet and exceed our clients' expectations. We're committed to bringing comfort, style, and warmth to homes and businesses, one floor at a time.

Thank you for considering GT Carpets for your flooring needs. We look forward to transforming your space with our expert installation services."
  setting.description = 'About Us section content'
end

Setting.find_or_create_by(key: 'our_expertise') do |setting|
  setting.value = "Personalized Consultation
We provide personalized consultations to understand your specific needs, help you navigate our extensive range of options, and ensure the final installation exceeds your expectations.

Carpet Installation
Discover the warmth and comfort that a new carpet can bring to your home. We offer a comprehensive selection of styles and materials to suit any room, ensuring a perfect match for your décor and lifestyle needs.

Vinyl Flooring Installation
For durability and style, our vinyl flooring options are unmatched. Ideal for kitchens, bathrooms, and high-traffic areas, vinyl offers a versatile solution that combines easy maintenance with aesthetic appeal."
  setting.description = 'Our Expertise section content'
end

Setting.find_or_create_by(key: 'contact_phone') do |setting|
  setting.value = '07494 789381'
  setting.description = 'Business phone number'
end

Setting.find_or_create_by(key: 'contact_email') do |setting|
  setting.value = 'gareth@gtcarpets.uk'
  setting.description = 'Business email address'
end

Setting.find_or_create_by(key: 'contact_name') do |setting|
  setting.value = 'Gareth Taylor'
  setting.description = 'Business owner name'
end

Setting.find_or_create_by(key: 'calculator_enabled') do |setting|
  setting.value = 'true'
  setting.description = 'Enable/disable the price calculator on the website'
end

puts "Seeded #{Setting.count} content settings"
