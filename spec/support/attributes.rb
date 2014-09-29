def project_attributes(overrides = {})
  {name: "Example Project", 
   description: "This is the description for the example project", 
   website: "https://www.exampleproject.com", 
   target_pledge_amount: 100.00,
   pledging_ends_on: 20.days.from_now, 
   team_members: "The Team Members", 
   image_file_name: "project.png"
  }.merge(overrides)
end

def pledge_attributes(overrides = {})
  {
    name: "Example", 
    email: "example@example.com", 
    comment: "Example Comment", 
    amount: 200.00
  }.merge(overrides)
end

def user_attributes(overrides = {})
  { 
    name: "Example User", 
    username: "exampleuser", 
    email: "user@example.com", 
    password: "foobar", 
    password_confirmation: "foobar"
  }.merge(overrides)
end
