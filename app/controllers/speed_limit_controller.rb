class SpeedLimitController < ApplicationController
  def show
    speed = Rails.cache.fetch(['maxspeed', params[:latitude], params[:longitude]]) do
      Overpass.maxspeed(params[:latitude].to_f, params[:longitude].to_f)
    end
    render json: { maxspeed: speed }
  end
end
