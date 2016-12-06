class YelpApi

  def self.client
    @client ||= Yelp::Client.new({
      consumer_key: 'rCPjCJMrMc2naKiFJG1OuQ',
      consumer_secret: '1vNPcyEIxqJPrtJwO4Xc5U59HNE',
      token: 'SJmlEkBKLgtC6WMzsZAeWxQrMwUUIaKr',
      token_secret: 'mmTFFzz8rlBGGn_dQvsqDHuOfcs'
      })
  end

  def self.search(zipcode)
    results = client.search(zipcode)
    results.businesses.map do |result|
      if !Restaurant.find_by({yelp_id: result.id})
        Restaurant.create({yelp_id: result.id, name: result.name, rating: result.rating, address: result.location.address.join(", "), city: result.location.city, zipcode: result.location.postal_code, phone: result.display_phone, url: result.url})
      else
        Restaurant.find_by({yelp_id: result.id})
      end
    end
  end

end
