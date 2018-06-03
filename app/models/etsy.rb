module Etsy
  @@host = "openapi.etsy.com"
  @@path = "/v2"

  def self.api_key
    ENV['ETSY_API_KEY']
  end

  def self.path
    @@path
  end

  def self.host
    @@host
  end

  class Shop
    def self.api_key
      Etsy.api_key
    end

    def self.host
      Etsy.host
    end

    def self.path
      Etsy.path
    end

    def self.find(options={})
      if options[:shop_id]
        uri = URI::HTTPS.build(host: host, path: path + "/shops/#{options[:shop_id]}", query: "api_key=#{api_key}")
      elsif options[:shop_name]
        uri = URI::HTTPS.build(host: host, path: path + "/shops", query: "api_key=#{api_key}&shop_name=#{options[:shop_name]}")
      end

      if options[:includes]
        uri.query += "&includes=#{options[:includes].join(',')}"
      end

      response = RestClient.get uri.to_s
      body = JSON.parse response.body
      results = body['results'][0]
    end
  end
end
