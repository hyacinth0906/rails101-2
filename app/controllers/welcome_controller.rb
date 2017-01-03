class WelcomeController < ApplicationController
  def index
    flash[:warning] = "这是提醒信息"
  end
end
