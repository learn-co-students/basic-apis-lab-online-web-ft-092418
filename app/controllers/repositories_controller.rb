class RepositoriesController < ApplicationController

  def search

  end

  def github_search

    client_id = ''
    client_secret = ''
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|

    req.params['client_id'] = client_id
    req.params['client_secret'] = client_secret

    req.params['q'] = params[:query]

  end
  #binding.pry
  body = JSON.parse(@resp.body)
  if @resp.success?
    @results = body["items"]
  else
    @error = 'ERROR occured.'
  end
  render 'search'
  end
end
