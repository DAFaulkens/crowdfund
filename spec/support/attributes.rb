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
