class Stock < ApplicationRecord
  has_many :user_stocks, :dependent => :destroy
  has_many :users, through: :user_stocks

  validates :ticker, presence: true

### Get data from the external API provider.
  def self.get_stock_info(symbol)
    headers = {"Content-Type" => "application/json", "Authorization" => "Token #{Rails.application.credentials.tiingo_client[:dev_api_key]}" }

    uri = URI("https://api.tiingo.com/iex/?tickers=" + symbol)
    req = Net::HTTP::Get.new(uri)

    headers.each { |key, value| req[key.to_s] = value}

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    res = http.request(req)
    response = JSON.parse(res.body)

    response.first

    begin
      new(ticker: symbol, last_price: response.first["last"])
    rescue => exception
      return nil
    end

  end

  def self.get_stock_price(symbol)
    info = get_stock_info(symbol)
    info.last_price
  end
############################################

  def self.check_db(ticker)
    where(ticker: ticker).first
  end

end
