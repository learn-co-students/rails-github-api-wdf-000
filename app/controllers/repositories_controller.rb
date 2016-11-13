class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    
    @user_name = JSON.parse(user_resp.body)["login"]

    repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repos = JSON.parse(repos_resp.body)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {name: params[:name]}.to_json 
    end
    # binding.pry
    redirect_to root_path
  end
end
