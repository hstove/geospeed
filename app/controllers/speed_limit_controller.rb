class SpeedLimitController < ApplicationController
  def show
    result = Rails.cache.fetch(['maxspeed-v2', params[:latitude], params[:longitude]]) do
      Overpass.maxspeed(params[:latitude].to_f, params[:longitude].to_f)
    end
    render json: result
  end
end
