class ForecastsController < ApplicationController
  def index
    matching_forecasts = Forecast.all

    @list_of_forecasts = matching_forecasts.order({ :created_at => :desc })

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
