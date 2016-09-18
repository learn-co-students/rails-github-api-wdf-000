class RepositoriesController < ApplicationController
  def index
    # response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    resp = Faraday.get("https://api.github.com/user?access_token=#{session[:token]}")
    if resp.success?
      @username = JSON.parse(resp.body)['login']
      repourl = JSON.parse(resp.body)['repos_url']
      @repos = JSON.parse(Faraday.get(repourl).body)
    end
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.params["access_token"] = session[:token]
      req.body = {name: params[:name]}.to_json
    end
    # response = Faraday.post('https://api.github.com/user/repos') do |req|
    #    req.body = {name: params[:name]}.to_json
    #    req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    #  end
    redirect_to root_path
  end
end
