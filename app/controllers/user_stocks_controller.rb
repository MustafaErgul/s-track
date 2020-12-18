class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker])
    if stock.blank?
      stock = Stock.get_stock_price(params[:ticker])
<<<<<<< HEAD
=======
      p stock.inspect
>>>>>>> aea0d4aba9d68ad3d18dcc4e310a86885113e13d
      stock["ticker"].save
    end
    @user_stock = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

end
