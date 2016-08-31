class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers = {'Authorization'=>"token #{session[:token]}"}
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    response = Faraday.post('https://api.github.com/user/repos') do |req|
       req.body = {name: params[:name]}.to_json
       req.headers = {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
     end
    redirect_to '/'
  end

end
