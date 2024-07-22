# Use this file to easily define all of your cron jobs.
set :environment, "development"
every :sunday, at: '11:15pm' do
    runner "Article.reset_view_counts"
 end
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
set :output, './log/cron.log'
every 1.minutes do
  runner "puts 'helllo world '"
end

# Learn more: http://github.com/javan/whenever
