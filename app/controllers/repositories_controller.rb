class RepositoriesController < ApplicationController




  def search

  end


  def github_search
    begin
      puts params[:query]
      @resp = Faraday.get "https://api.github.com/search/repositories" do |req|
        req.params['client_id'] = #CLIENT ID HERE
        req.params['client_secret'] = #CLIENT SECRET HERE
        req.params['q'] = params[:query]
      end
      
      body = JSON.parse(@resp.body)
      if @resp.success?
        @repos = body['items']
        puts @repos
      else
        @error = body[:message]
      end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
    end

    render 'search'
  end
end
