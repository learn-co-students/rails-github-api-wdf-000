class RepositoriesController < ApplicationController
  def index
    response1 = Faraday.get("https://api.github.com/user") do |req|
         req.headers['Authorization'] = "token #{session[:token]}"
    end
    response2 = Faraday.get("https://api.github.com/user/repos") do |req|
         req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos_array = JSON.parse(response2.body)
    @username = JSON.parse(response1.body)["login"]
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
