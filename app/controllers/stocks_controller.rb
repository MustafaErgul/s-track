class StocksController < ApplicationController

  def search
    stock = Stock.get_stock_info(params[:stock])
    render json: stock
  end

end
