class Stock < ApplicationRecord

### Get data from the external API provider.
  def self.get_stock_info(symbol)
    headers = {"Content-Type" => "application/json", "Authorization" => "Token #{Rails.application.credentials.tiingo_client[:dev_api_key]}" }

    uri = URI("https://api.tiingo.com/iex/?tickers=" + symbol)
    req = Net::HTTP::Get.new(uri)

    begin
      headers.each { |key, value| req[key.to_s] = value}

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      res = http.request(req)
      response = JSON.parse(res.body)

      response.first
    rescue => exception
      return nil
    end

  end

  def self.get_stock_price(symbol)

    info = get_stock_info(symbol)
    info["last"]
  end
############################################

end
