class Overpass
  class << self
    def maxspeed lat, lng
      url = url_for(lat, lng)

      page = Nokogiri::HTML(HTTParty.get(url))
      closest = closest_node_id(page, lat, lng)
      ap closest
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
      distances = {}
      nodes = page.css('node')
      nodes = nodes.to_a.sort do |node1, node2|

        unless distance1 = distances[node1['id']]
          distance1 = distance_from_node(node1, lat, lng)
          node = nodes.select {|n| n['id'] == node1['id'] }[0]
          distances[node['id']] ||= distance1 if node
        end
        unless distance2 = distances[node2['id']]
          distance2 = distance_from_node(node2, lat, lng)
          node = nodes.select {|n| n['id'] == node2['id'] }[0]
          distances[node['id']] ||= distance2 if node
        end

        distance1 <=> distance2
      end

      node = nodes.first
      if node
        distance = distances[node['id']]
        Rails.logger.info "Node Distance - #{distance}"
        if distance < 200
          node['id']
        else
          ''
        end
      else
        ''
      end
    end

    # returns the distance of two points in meters
    # https://stackoverflow.com/questions/639695/how-to-convert-latitude-or-longitude-to-meters
    def distance_from_node(node, lat, lng)
      # distance = 0
      # distance += (node["lat"].to_f.abs - lat.abs).abs
      # distance += (node["lon"].to_f.abs - lng.abs).abs
      # distance
      radius = 6378.137 # Radius of earth in KM
      dLat = (lat - node['lat'].to_f) * Math::PI / 180
      dLon = (lng - node['lon'].to_f) * Math::PI / 180
      a = Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(node['lat'].to_f * Math::PI / 180) * Math.cos(lat * Math::PI / 180) *
        Math.sin(dLon/2) * Math.sin(dLon/2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
      d = radius * c
      d * 1000
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
