class SiteController < ApplicationController

  before_action :current_user

  def index
    if current_user
      redirect_to @current_user
    end
  end

end
