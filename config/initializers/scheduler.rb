# require 'rufus-scheduler'

# # Let's use the rufus-scheduler singleton
# #
# # s = Rufus::Scheduler.singleton


# # # Stupid recurrent task...
# # #
# # s.every '10s' do
# #   puts "hello"
# # end

# PriceWatch.all.each do |price_watch|
#   # get the price_watch.job_id, cancel the rufus job (if running)
#   puts "hello again"
#   # create a new Rufus singleton
#   job = Rufus::Scheduler.new
#   puts "hello again again"
#   p (job.methods - Object.methods)
#   # update price_watch to save the singleton job_id
#   # price_watch.job_id = job.id
#   # price_watch.save
#   # run the job
# end