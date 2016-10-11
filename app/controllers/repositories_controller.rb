class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get 'https://api.github.com/user/repos' do |req|
        # req.params['client_id'] = ENV['GITHUB_ID']
        # req.params['client_secret'] = ENV['GITHUB_SECRET']
        req.params['v'] = 'application/vnd.github.v3+json'
        req.params['user'] = session[:username]
        req.params['access_token'] = session[:token]
        req.options.timeout = 5 ###This is in seconds, I think...
      end
      @repos  = JSON.parse(resp.body)

      # binding.pry
  end

  def create
    resp = Faraday.post('https://api.github.com/user/repos') do |req|
      req.body = { name: params[:name]}.to_json
      req.params['access_token'] = session[:token]
      req.params['v'] = 'application/vnd.github.v3+json'
   end
  #  binding.pry
   redirect_to root_path

  end
end
