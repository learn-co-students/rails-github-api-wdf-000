class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

    def create
      # resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      #   req.params['client_id'] = ENV['GITHUB_CLIENT']
      #   req.params['client_secret'] = ENV['GITHUB_SECRET']
      #   req.params['code'] = params[:code]
      #   req.headers['Accept'] = 'application/json'
      # end
      resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
      # access_hash = JSON.parse(response.body)

      token = JSON.parse(resp.body)
      session[:token] = token["access_token"]


      user_j = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      # binding.pry
       user = JSON.parse(user_j.body)
       session[:name] = user["login"]

      redirect_to '/'
    end




end
