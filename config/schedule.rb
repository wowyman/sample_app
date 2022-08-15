set :environment, "development"

every 1.day, at: "7:00 am" do
  rake "report:slack"
end
