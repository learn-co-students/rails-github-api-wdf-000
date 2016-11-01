class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get('https://api.github.com/user') do |req|
      req.params['access_token'] = session[:token]
    end
    body = JSON.parse(resp.body)
    @username = body['login']
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.params['access_token'] = session[:token]
      req.body = {
        "name" => "#{params[:name]}"
      }.to_json
    end
    binding.pry
    redirect_to root_path
  end
end
