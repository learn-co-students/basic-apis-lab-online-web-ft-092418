class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
        req.params['q'] = params[:query]
        req.params['client_id'] = 'Iv1.3e261bf154a1d276'
        req.params['client_secret'] = 'd1425518dff2a5d1a768aefa9cba19dcbd6ce467'
      end

      @body = JSON.parse(@resp.body)
      if @resp.success?
        @repositories = @body["items"]
      else
        @error = "There was a problem. Please try again."
      end
      
    rescue Faraday::ConnectionFailed
      @error = "There was a Timeout. Please try again."
    end
    render 'search'
  end
end
