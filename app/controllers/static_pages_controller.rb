class StaticPagesController < ApplicationController
  def contact
  end

  def team
  end

  def bienvenue
  	@first_name = params[:first_name]
  end

  def home
  	@gossips = Gossip.all
  end
end
