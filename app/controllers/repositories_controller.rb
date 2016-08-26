# class RepositoriesController < ApplicationController
#   def index
#       resp = Faraday.get('https://api.github.com/user') do |req|
#       req.params['oauth_token'] = session[:token]
#       req.params['Accept'] = 'application/json'
#     end
#    @repos = JSON.parse(resp.body)
#    byebug
#   end

#   def create
#     resp = Faraday.post("https://api.github.com/user/repos") do |req|
#       req.params['oauth_token'] = session[:token]
#       # byebug
#       req.params['name'] = params[:name]
#       req.params['Accept'] = 'application/json'
#     end

#     redirect_to root_path
#   end
# end


class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(response.body)
  end

    # def index
    #   resp = Faraday.get('https://api.github.com/user/repos') do |req|
    #     req.params['oauth_token'] = session[:token]
    #     req.params['Accept'] = 'application/json'
    #   end
    #  @repos = JSON.parse(resp.body)

    # end

  # def create
  #   resp = Faraday.post("https://api.github.com/user/repos") do |req|
  #     req.params['oauth_token'] = session[:token]
  #     # byebug
  #     req.params['name'] = params[:name]
  #     req.params['Accept'] = 'application/json'
  #   end

  #   redirect_to root_path
  # end
  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end

