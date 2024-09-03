class HomeController < ApplicationController
  def index
    @articles = policy_scope(Article).all
  end
end
