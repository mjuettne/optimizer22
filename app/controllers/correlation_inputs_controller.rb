class CorrelationInputsController < ApplicationController
  def index
    matching_correlation_inputs = CorrelationInput.all

    @list_of_correlation_inputs = matching_correlation_inputs.order({ :created_at => :desc })

    render({ :template => "correlation_inputs/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_correlation_inputs = CorrelationInput.where({ :id => the_id })

    @the_correlation_input = matching_correlation_inputs.at(0)

    render({ :template => "correlation_inputs/show.html.erb" })
  end

  def create
    the_correlation_input = CorrelationInput.new
    the_correlation_input.correlation_id = params.fetch("query_correlation_id")
    the_correlation_input.asset_class1_id = params.fetch("query_asset_class1_id")
    the_correlation_input.asset_class2_id = params.fetch("query_asset_class2_id")
    the_correlation_input.correl = params.fetch("query_correl")

    if the_correlation_input.valid?
      the_correlation_input.save
      redirect_to("/correlation_inputs", { :notice => "Correlation input created successfully." })
    else
      redirect_to("/correlation_inputs", { :notice => "Correlation input failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_correlation_input = CorrelationInput.where({ :id => the_id }).at(0)

    the_correlation_input.correlation_id = params.fetch("query_correlation_id")
    the_correlation_input.asset_class1_id = params.fetch("query_asset_class1_id")
    the_correlation_input.asset_class2_id = params.fetch("query_asset_class2_id")
    the_correlation_input.correl = params.fetch("query_correl")

    if the_correlation_input.valid?
      the_correlation_input.save
      redirect_to("/correlation_inputs/#{the_correlation_input.id}", { :notice => "Correlation input updated successfully."} )
    else
      redirect_to("/correlation_inputs/#{the_correlation_input.id}", { :alert => "Correlation input failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_correlation_input = CorrelationInput.where({ :id => the_id }).at(0)

    the_correlation_input.destroy

    redirect_to("/correlation_inputs", { :notice => "Correlation input deleted successfully."} )
  end
end
