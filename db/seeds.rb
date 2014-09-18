# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Project.create!([
  {
    name: "Save the Whales", 
    description: "Save the whales and other endangered marine mammals!", 
    website: "www.savethewhales.org", 
    target_pledge_amount: 40000.00, 
    pledging_ends_on: '2015-01-01',
    team_members: "The whale lovers society"
  }, 
  {
    name: "Save the Forests", 
    description: "Stop the deforestation of earth before it's too late", 
    website: "www.savetheforests.org", 
    target_pledge_amount: 200000.00, 
    pledging_ends_on: '2015-12-31', 
    team_members: "The Eco-Warriors"
  }, 
  {
    name: "Save the Planet", 
    description: "Gaia is in trouble! We need to help her ASAP!!!", 
    website: "www.savetheplanet.org", 
    target_pledge_amount: 8000000.00,
    pledging_ends_on: '2012-12-21', 
    team_members: "Captain Planet and friends!"
  }, 
  { 
    name: "Rome is Burning..",
    description: "We're in serious trouble guys...",
    website: "www.romeisburning.org", 
    target_pledge_amount: 32000.00, 
    pledging_ends_on: 40.days.from_now,
    team_members: "Me, Myself, and I"
  }
])
