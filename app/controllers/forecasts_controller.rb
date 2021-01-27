class ForecastsController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    matching_forecasts = Forecast.all
    @cmas = Cma.all
    @correlations = Correlation.all
    @list_of_forecasts = matching_forecasts.order({ :created_at => :desc })



    # params = {
    #       :access_key => "ceea71fff913fdadde8f8117395cf453"
    #     }

     
    # uri = URI('https://api.marketstack.com/v1/exchanges/INDX/tickers')
    # uri.query = URI.encode_www_form(params)
    # json = Net::HTTP.get(uri)
    # @api_response = JSON.parse(json)

        # for stock_data in api_response['data']
        #       puts sprintf("Ticker %s has a day high of %s on %s",
        #         stock_data['symbol'],
        #         stock_data['high'],
        #         stock_data['date'])
              
        # end

    render({ :template => "forecasts/index.html.erb" })
  end

  def show
    

    the_id = params.fetch("path_id")

    matching_forecasts = Forecast.where({ :id => the_id })

    @the_forecast = matching_forecasts.at(0)





    render({ :template => "forecasts/show.html.erb" })
  end

  def create
    the_forecast = Forecast.new
    the_forecast.user_id = params.fetch("query_user_id")
    the_forecast.name = params.fetch("query_name")

    if the_forecast.valid?
      the_forecast.save
      redirect_to("/forecasts", { :notice => "Forecast created successfully." })
    else
      redirect_to("/forecasts", { :notice => "Forecast failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_forecast = Forecast.where({ :id => the_id }).at(0)

    the_forecast.user_id = params.fetch("query_user_id")
    the_forecast.name = params.fetch("query_name")

    if the_forecast.valid?
      the_forecast.save
      redirect_to("/forecasts/#{the_forecast.id}", { :notice => "Forecast updated successfully."} )
    else
      redirect_to("/forecasts/#{the_forecast.id}", { :alert => "Forecast failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_forecast = Forecast.where({ :id => the_id }).at(0)

    the_forecast.destroy

    redirect_to("/forecasts", { :notice => "Forecast deleted successfully."} )
  end
end
