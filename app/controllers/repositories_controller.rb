class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @user_name = session[:username]
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Content-Type'] = "application/json"
      req.params['access_token'] = session[:token]
      req.body = {
        name: params[:name]
      }.to_json
    end

    redirect_to root_path
  end
end
