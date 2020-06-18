p "Cleaning database...."
Restaurant.destroy_all
Invitation.destroy_all
Event.destroy_all
Cuisine.destroy_all
User.destroy_all
Result.destroy_all

p "The database is empty"
p "404 DREAM TEAM!"
# Create users
p "creating 4 users!"
array_num = 0
name_array = ["Rithvik", "Lacy", "Jason", "Arie"]
email_array = ["Rithvik@decide.com", "Lacy@decide.com", "Jason@decide.com", "Arie@decide.com"]
password = "123456"

4.times do
  new_user = User.new(
    name: name_array[array_num],
    email: email_array[array_num],
    password: password,
    avatar: "https://kitt.lewagon.com/placeholder/users/random"
     )
    p 'user created'
    new_user.save!
  array_num += 1
end
p "success!"

# Create events
p "creating 4 events!"
array_num = 0
event_name_array = ["Rithvik's cray party", "Lacy's big night out", "Jason's daughters birthday", "Arie's post lockdown feed"]
event_description_array = ["Celebrate this cray party, have a dope time!", "Celebrate my daughters second birthday with me!", "It's time to party!", "Let's catch up over dinner and share lockdown stories!"]
event_time = 1000000000

4.times do
  new_event = Event.new(
    name: event_name_array[array_num],
    description: event_description_array[array_num],
    start_at: "2020-06-21 08:00:00",
    decided: false)
  new_event.save!
  array_num += 1
  event_time += 1000000000
end
p "success!"

# Create cuisines
array_num = 0
cuisines_array = ["Afghan", "African", "Asian", "BBQ", "Bakery", "Bangladeshi", "British", "Burgers", "Cafe", "Chinese", "Crepes", "Desserts", "Ethiopian", "Fish and Chips", "French", "Frozen Yogurt", "Ice Cream", "Indian", "Indonesian", "Iranian", "Italian", "Japanese", "Kebab", "Korean BBQ", "Malaysian", "Mexican", "Middle-Eastern", "Modern Australian", "Pizza", "Portugese", "Pakistani", "Pacific" "Ramen", "Salad", "Sri Lankan", "Sushi", "Thai", "Turkish", "Vegan", "Vegetarian", "Vietnamese"]
cuisines_len = cuisines_array.length.to_i
p "creating #{cuisines_len} cuisines!"

until array_num == cuisines_len
  new_cuisine = Cuisine.new(name: cuisines_array[array_num])
  new_cuisine.save!
  array_num += 1
end
p "success!"

# Cuisene events
# p "creating 4 cuisine events!"
# array_num = 1
# 4.times do
#   new_cuisine_event = CuisineEvent.new
#   new_cuisine_event.event = Event.find(array_num)
#   new_cuisine_event.cuisine = Cuisine.find(array_num)
#   new_cuisine_event.save!
#   array_num += 1
# end
# p "success!"

# Create invitations
p "creating 4 invitations per user"
location_array = ["122 Albert St, Port Melbourne, VIC 3207", "99 Beacon Rd, Port Melbourne, VIC 3207", "396 Clarendon St, South Melbourne, VIC 3205", "120 Princes St, Port Melbourne, VIC"]
var = 0
array_num = 0
users = User.all
users.each do |user|
  4.times do
    new_invitation = Invitation.new(
      status: "Confirmed",
      location: location_array[var]
      )
    new_invitation.user = User.find(user.id)
    new_invitation.event = Event.find(array_num + 1)
    new_invitation.cuisine = Cuisine.all.sample
    new_invitation.save!
    array_num += 1
  end
  array_num = 0
  var += 1
end
p "success!"

p "creating 4 restaurants"
yelp_id_array = ["italia-39-pizzeria-and-degustation-melbourne", "11-inch-pizza-melbourne", "jing-jai-thai-melbourne", "China Chilli"]
rest_name_array = ["Italia +39 Pizzeria & Degustation", "11 Inch Pizza", "Jing Jai Thai", "China Chilli"]
rest_desc_array = ["Pizza", "Pizza", "Thai", "Szechuan, Specialty Food"]
rest_location_array = ["362 Lt Bourke St, Melbourne Victoria 3000, Australia", "5B/353-359 Lt Collins St, Melbourne Victoria 3000, Australia", "271-273 Flinders Lane, Melbourne Victoria 3000, Australia", "206 Bourke St, Melbourne Victoria 3000, Australia"]
var = 0

4.times do
  new_restaurant = Restaurant.new(
    yelp_id: yelp_id_array[var],
    name: rest_name_array[var],
    description: rest_desc_array[var],
    location: location_array[var])
  new_restaurant.save!
  var += 1
end
p "success!"

# p "Creating 4 results"
# var = 1

# 4.times do
#   new_result = Result.new
#   event = Event.find(var)
#   new_result.event = event
#   new_result.restaurant = Restaurant.find(var)
#   new_result.save!
#   var += 1
# end
# p "success!"
p "Let's go DREAM TEAM!"






#
# p "creating 4 cuisine events"

# 4.times do
#   new_cuisine_event = Cuisine_event.new
# end










