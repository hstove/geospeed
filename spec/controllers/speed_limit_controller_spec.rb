require 'rails_helper'

RSpec.describe SpeedLimitController, type: :controller do

  describe "GET #show", :vcr do
    it "returns http success when close enough" do
      get :show, latitude: 48.758551, longitude: -122.482603
      data = JSON.parse(response.body)
      expect(data['maxspeed']).to eq(25)
      expect(data['format']).to eq('mph')
      expect(data['street']).to eq('F Street')
    end

    it "returns nil when not close enough" do
      get :show, latitude: 48.7588802, longitude: -122.4875853
      data = JSON.parse(response.body)
      expect(data['maxspeed']).to eq(nil)
      expect(data['format']).to eq(nil)
    end

    it "returns nil when not found" do
      get :show, latitude: 48.691939992301265, longitude: -122.49252342328188
      data = JSON.parse(response.body)
      expect(data['maxspeed']).to eq(nil)
      expect(data['format']).to eq(nil)
    end
  end

end
