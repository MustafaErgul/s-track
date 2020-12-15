class WelcomeController < ApplicationController
  def index
    render :inline => "Welcome Page!"
  end
end
