require 'rails_helper'

RSpec.describe SpeedLimitController, type: :controller do

  describe "GET #show", :vcr do
    it "returns http success" do
      get :show, latitude: 48.7588802, longitude: -122.4875853
      data = JSON.parse(response.body)
      expect(data['maxspeed']).to equal(25)
      expect("#{data['format']}").to eq('mph')
    end
  end

end
