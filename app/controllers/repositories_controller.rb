class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
      req.params['client_id'] = '4b3fdbe3e1e0a324ed3e'
      req.params['client_secret'] = 'dcbc887d95dccb38cc676479e28bfca700b3ab7c'
      req.params['q'] = params[:query]
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @repos = body["items"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
