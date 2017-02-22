class RepositoriesController < ApplicationController
  def index
    resp_user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    resp_repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @user = JSON.parse(resp_user.body)["login"]
    @repos = JSON.parse(resp_repos.body)
  end

  def create
    resp_repos = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
