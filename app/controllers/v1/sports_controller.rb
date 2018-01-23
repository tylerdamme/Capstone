class V1::SportsController < ApplicationController
  def index
    sports = Sport.all
    render json: sports.as_json
  end
end
