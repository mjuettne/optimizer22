class CorrelationsController < ApplicationController
  def index
    matching_correlations = Correlation.all

    @list_of_correlations = matching_correlations.order({ :created_at => :desc })

    render({ :template => "correlations/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_correlations = Correlation.where({ :id => the_id })

    @the_correlation = matching_correlations.at(0)

    render({ :template => "correlations/show.html.erb" })
  end

  def create
    the_correlation = Correlation.new
    the_correlation.name = params.fetch("query_name")

    if the_correlation.valid?
      the_correlation.save
      redirect_to("/correlations", { :notice => "Correlation created successfully." })
    else
      redirect_to("/correlations", { :notice => "Correlation failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_correlation = Correlation.where({ :id => the_id }).at(0)

    the_correlation.name = params.fetch("query_name")

    if the_correlation.valid?
      the_correlation.save
      redirect_to("/correlations/#{the_correlation.id}", { :notice => "Correlation updated successfully."} )
    else
      redirect_to("/correlations/#{the_correlation.id}", { :alert => "Correlation failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_correlation = Correlation.where({ :id => the_id }).at(0)

    the_correlation.destroy

    redirect_to("/correlations", { :notice => "Correlation deleted successfully."} )
  end
end
