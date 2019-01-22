
class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    begin
      @resp = Faraday.get 'https://api.github.com/search/repositories' do |req|
          req.params['client_id'] = "Iv1.a06303552f60ba46"
          req.params['client_secret'] = "99174f0c3582f92fd9de0b8ff88ecdc8b2e764a5"
          req.params['q'] = params["query"]
        end
        body = JSON.parse(@resp.body)
        if @resp.success?
          @repos = body["items"]
        else
          @error = "There was an error."
        end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
      render 'search'
    end
end
