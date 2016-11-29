class RepositoriesController < ApplicationController
  def index
    repo = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization'=>"token #{session[:token]}"}
    @repos = JSON.parse(repo.body)
  end

  def create
    # Faraday.post("https://api.github.com/user/repos") do |req|
    #   binding.pry
    # end
    # binding.pry
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
    # resp = Faraday.post "https://api.github.com/user/repos", {name: params[:name].to_json}, {'Authorization'=>"token #{session[:token]}", 'Accept' => 'application/json'}
    # redirect_to '/'
  end
end
