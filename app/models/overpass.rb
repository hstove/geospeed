class Overpass
  class << self
    def maxspeed lat, lng
      url = url_for(lat, lng)

      page = Nokogiri::HTML(HTTParty.get(url))
      closest = closest_node_id(page, lat, lng)
      way = page.css("way nd[ref='#{closest}']")[0].try(:parent)

      response = {
        maxspeed: nil,
        format: nil,
        street: nil,
      }

      if way && (speed = way.css('[k="maxspeed"]')[0])
        value = speed['v']
        parts = value.split(' ')
        response[:format] = parts[1]
        response[:maxspeed] = parts[0].to_i
        if name = way.css('[k="name"]')[0]
          response[:street] = name['v']
        end
      end

      response
    end

    def closest_node_id(page, lat, lng)
      nodes = page.css('node')
      nodes = nodes.to_a.sort do |node|
        distance = 0
        distance += node["lat"].to_f.abs - lat.abs
        distance += node["lon"].to_f.abs - lng.abs
        distance
      end
      node = nodes.first
      node ? nodes.first["id"] : ''
    end

    def url_for(lat, lng)
      bottom = lat - 0.01
      top = lat + 0.01
      left = lng - 0.01
      right = lng + 0.01
      url = "http://www.overpass-api.de/api/xapi?*[maxspeed=*]"
      url += "[bbox=#{left},#{bottom},#{right},#{top}]"
    end
  end
end
