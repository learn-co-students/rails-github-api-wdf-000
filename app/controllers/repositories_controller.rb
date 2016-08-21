class RepositoriesController < ApplicationController
  def index
    oauth_token = session[:token]
    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.params['access_token'] = oauth_token
    end
    if user_resp.success?
      @user = JSON.parse(user_resp.body) 
      repos_resp = Faraday.get("https://api.github.com/users/#{@user['login']}/repos") do |req|
	req.params['access_token'] = oauth_token
      end
      @repos = JSON.parse(repos_resp.body)
    end
    # byebug
  end

  def create
    oauth_token = session[:token]
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.params["access_token"] = oauth_token
      req.body = {name: params[:name]}.to_json
      # byebug
    end
    # byebug
    redirect_to root_path
  end
end
