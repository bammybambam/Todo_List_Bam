# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

env :PATH, "/Users/patchara/.rbenv/shims:/Users/patchara/.rbenv/bin:/usr/local/bin:/usr/bin:/bin"
set :environment, "development"
set :output, "log/cron.log"

job_type :runner, "cd :path && /Users/patchara/.rbenv/shims/bundle exec /Users/patchara/.rbenv/shims/ruby bin/rails runner -e :environment ':task' :output"

every 1.day, at: "08.00 am" do
  runner "SendReminderEmailsJob.perform_now"
end
