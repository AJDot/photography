class Etsy
  def initialize(api_key, user_id)
    @api_key = api_key
    @user = user_id
    @host = "openapi.etsy.com"
    @path = "/v2"
  end

  def shop(shop_id, options={})
    uri = URI::HTTPS.build(host: @host, path: @path + "/shops/#{shop_id}", query: "api_key=#{@api_key}")
    if options[:includes]
      uri.query += "&includes=#{options[:includes].join(',')}"
    end
    response = RestClient.get uri.to_s
    body = JSON.parse response.body
    results = body['results'][0]
  end
end
