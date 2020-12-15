module ApplicationHelper

  APIToken = "1d5c26b65158c7a431eb550b1dc556fc6fd8982b"

  def get_stock_info(symbol)
    headers = {"Content-Type" => "application/json", "Authorization" => "Token #{APIToken}" }

    uri = URI("https://api.tiingo.com/iex/?tickers=" + symbol)
    req = Net::HTTP::Get.new(uri)

    headers.each { |key, value| req[key.to_s] = value}

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    res = http.request(req)
    response = JSON.parse(res.body)

    response.first
  end

  def self.get_stock_price(symbol)

    info = get_stock_info(symbol)
    info["last"]
  end

end
