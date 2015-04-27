class Overpass
  def self.maxspeed lat, lng
    bottom = lat - 0.01
    top = lat + 0.01
    left = lng - 0.01
    right = lng + 0.01
    url = "http://www.overpass-api.de/api/xapi?*[maxspeed=*][bbox=#{left},#{bottom},#{right},#{top}]"

    res = HTTParty.get url
    page = Nokogiri::HTML(res)
    speeds = page.css('[k="maxspeed"]').collect { |el| el['v'] }
    ap speeds
    if speeds.size > 0
      value = speeds.group_by(&:itself).values.max_by(&:size).first
      parts = value.split(' ')
      ap value
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
