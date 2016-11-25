class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token#{session[:token]}"
    end
    user_info = JSON.parse(resp.body)
    # binding.pry
    @name = user_info['login']
    repos = Faraday.get(user_info['repos_url'])
    repos = JSON.parse(repos.body)
    @repos_array = repos.map { |repo| repo['name']}
  end

  def create
    post = Faraday.post("https://api.github.com/user/repos") do |req|
    req.params['access_token'] = session[:token]
    req.headers['Content-Type'] = 'application/json'
    req.body = {
      "name": "#{params[:name]}"
      }.to_json
      end
    redirect_to root_path
  end
end
