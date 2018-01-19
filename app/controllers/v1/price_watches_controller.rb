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
    render json: {message: "alert set!"}
  end
end
