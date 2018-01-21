require 'rufus-scheduler'

# scheduler = Rufus::Scheduler.new
# job = scheduler.every '1s' do
#   puts 'Hello World!'
# end
# scheduler.join
# sleep 5
# scheduler.unschedule(job)
# puts "done"

scheduler = Rufus::Scheduler.new
job_id = scheduler.every "1s" do
  puts "Hello World!"
end
puts "jobs..."
p scheduler.jobs.count
p scheduler.jobs
puts "id..."
# p scheduler.jobs[0].id
scheduler.jobs.each do |job|
  scheduler.unschedule(job.id)
end
sleep 5
scheduler.unschedule(job_id)
puts "done"