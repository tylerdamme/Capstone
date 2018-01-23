class V1::PriceWatchesController < ApplicationController

  def update
    pricewatch_id = params[:id]
    pricewatch = PriceWatch.find_by(ticketmaster_id: params[:ticketmaster_id])
    if pricewatch == nil
      pricewatch = PriceWatch.new(
      user_id: current_user.id,
      ticketmaster_id: params[:ticketmaster_id],
      event_id: params[:event_id],
      form_input: params[:form_input])
    end
    pricewatch.form_input = params[:form_input]
    pricewatch.save


    # kill all rufus jobs
    scheduler = Rufus::Scheduler.singleton
    scheduler.jobs.each do |job|
      scheduler.unschedule(job.id)
    end
    # start rufus jobs
    PriceWatch.all.each do |price_watch|
      job_id = scheduler.every '10s' do
        # puts "job #{job_id}"
        response = Unirest.get("https://app.ticketmaster.com/discovery/v2/events?apikey=#{ENV['TICKETMASTER_API_KEY']}&id=#{price_watch.ticketmaster_id}&countryCode=US")
        ticketmaster_price = response.body["_embedded"]["events"][0]["priceRanges"][0]["min"]
        event_time = response.body["_embedded"]["events"][0]["dates"]["start"]["dateTime"]
        if event_time < Time.now
          scheduler.unschedule(job_id)
        elsif ticketmaster_price <= price_watch.form_input
          puts "ticket price met"
          client = Twilio::REST::Client.new(
            ENV['TWILIO_ACCOUNT_SID'],
            ENV['TWILIO_AUTH_TOKEN'],
            )

          client.messages.create(
            from: ENV['TWILIO_PHONE_NUMBER'],
            to: ENV['CELL_PHONE_NUMBER'],
            body: "Good news!!! Your ticket price has been met!")
          scheduler.unschedule(job_id)
        else
          puts "still running"
        end
      end
    end

    # job_id = Rufus::Scheduler.singleton.every '1s' do
    #   puts "job #{job_id}"
    # end


    render json: {message: "alert set!"}
  end
end