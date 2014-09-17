def project_attributes(overrides = {})
  {name: "Example Project", 
   description: "This is the description for the example project", 
   website: "www.exampleproject.com", 
   target_pledge_amount: 100.00,
   pledging_ends_on: 20.days.from_now
  }.merge(overrides)
end
