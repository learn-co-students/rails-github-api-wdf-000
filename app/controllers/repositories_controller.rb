class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    # get github user info
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.params['access_token'] = session[:token]
    end
 
    body = JSON.parse(resp.body)
    @github_username = body["login"]

    #get repos
    resp = Faraday.get("https://api.github.com/users/#{@github_username}/repos") do |req|
      req.params['access_token'] = session[:token]
    end

    @repos = JSON.parse(resp.body)
  end

  def create
  end
end
