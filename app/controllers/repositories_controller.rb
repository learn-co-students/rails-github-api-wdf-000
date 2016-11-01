class RepositoriesController < ApplicationController
  def index
    # get current user using session[:token]
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @user = JSON.parse(resp.body)

    # get current user repos
    resp2 = Faraday.get(@user['repos_url'])

    @repos = JSON.parse(resp2.body)
  end

  def create
    repo = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Content-Type'] = "application/json"
      req.params['access_token'] = session[:token]
      req.body = {
        "name": "#{params[:name]}"
      }.to_json
    end
    redirect_to root_path
  end
end
