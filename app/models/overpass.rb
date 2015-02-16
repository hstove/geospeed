class Overpass
  def self.maxspeed lat, lng
    bottom = lat - 0.001
    top = lat + 0.001
    left = lng - 0.001
    right = lng + 0.001
    url = "http://www.overpass-api.de/api/xapi?*[maxspeed=*][bbox=#{left},#{bottom},#{right},#{top}]"

    res = HTTParty.get url
    page = Nokogiri::HTML(res)
    if max = page.css('[k="maxspeed"]')[0]
      value = max['v']
      parts = value.split(' ')
      if parts[1] == 'mph'
        parts[0].to_i
      else
        parts[0].to_i * 0.621371
      end
    else
      nil
    end
  end
end
