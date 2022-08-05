namespace :report do
  desc "TODO"
  task slack: :environment do
    notifier = Slack::Notifier.new Rails.application.credentials.slack[:token]
    count = User.count(:all)
    date_start = DateTime.now
    date_end = date_start - 1.day
    users_signup_yesterday = User.where(created_at: date_end..date_start).count
    new_microposts_yesterday = Micropost.where(created_at: date_end..date_start).count
    users_interacting = UserInteractive.where(created_at: date_end..date_start).group(:user_id)
    users_interacting_count = users_interacting.length

    notifier.ping "<@U03S92E3GAJ> <@U03S9LQTT9U>
    #{DateTime.now.strftime("%m/%d/%Y")} report:
    - Current number of users: #{count}
    - New registered user yesterday: #{users_signup_yesterday}
    - New micropost yesterday: #{new_microposts_yesterday}
    - User interacting: #{users_interacting_count}
    "
  end
end
