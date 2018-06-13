class HomeController < ApplicationController
  def index
    @events = Event.limit(9)
  end
  def profil_user

  end
end
