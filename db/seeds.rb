# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


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
    start_at: (Time.now + event_time))
  new_event.save!
  array_num += 1
  event_time += 1000000000
end
p "success!"

# Create cuisines
p "creating 4 cuisines!"
array_num = 0
cuisines_array = ["Pizza", "Burgers", "Chinese", "Mexican"]

4.times do
  new_cuisine = Cuisine.new(name: cuisines_array[array_num])
  new_cuisine.save!
  array_num += 1
end
p "success!"

# Create invitations
p "creating 4 invitations per user"
location_array = ["122 Albert St, Port Melbourne, VIC 3207", "99 Beacon Rd, Port Melbourne, VIC 3207", "396 Clarendon St, South Melbourne, VIC 3205", "120 Princes St, Port Melbourne, VIC"]
var = 0
array_num = 0
users = User.all
users.each do |user|
  4.times do
    new_invitation = Invitation.new(
      status: ["Pending", "Accepted", "Rejected"].sample,
      location: location_array[var]
      )
    new_invitation.user = User.find(var + 1)
    new_invitation.event = Event.find(var + 1)
    p Cuisine.all.sample
    new_invitation.cuisine = Cuisine.all.sample
    new_invitation.save!
    array_num += 1
  end
  var += 1
end
p "success!"

#
# p "creating 4 cuisine events"

# 4.times do
#   new_cuisine_event = Cuisine_event.new
# end










