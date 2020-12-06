class FrontierInputsController < ApplicationController
  def index
    matching_frontier_inputs = FrontierInput.all

    @list_of_frontier_inputs = matching_frontier_inputs.order({ :created_at => :desc })

    render({ :template => "frontier_inputs/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_frontier_inputs = FrontierInput.where({ :id => the_id })

    @the_frontier_input = matching_frontier_inputs.at(0)

    render({ :template => "frontier_inputs/show.html.erb" })
  end

  def create
    the_frontier_input = FrontierInput.new
    the_frontier_input.asset_class_id = params.fetch("query_asset_class_id")
    the_frontier_input.frontier_id = params.fetch("query_frontier_id")
    the_frontier_input.cma_id = params.fetch("query_cma_id")
    the_frontier_input.correlation_id = params.fetch("query_correlation_id")
    the_frontier_input.min = params.fetch("query_min")
    the_frontier_input.max = params.fetch("query_max")

    if the_frontier_input.valid?
      the_frontier_input.save
      redirect_to("/frontier_inputs", { :notice => "Frontier input created successfully." })
    else
      redirect_to("/frontier_inputs", { :notice => "Frontier input failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_frontier_input = FrontierInput.where({ :id => the_id }).at(0)

    the_frontier_input.asset_class_id = params.fetch("query_asset_class_id")
    the_frontier_input.frontier_id = params.fetch("query_frontier_id")
    the_frontier_input.cma_id = params.fetch("query_cma_id")
    the_frontier_input.correlation_id = params.fetch("query_correlation_id")
    the_frontier_input.min = params.fetch("query_min")
    the_frontier_input.max = params.fetch("query_max")

    if the_frontier_input.valid?
      the_frontier_input.save
      redirect_to("/frontier_inputs/#{the_frontier_input.id}", { :notice => "Frontier input updated successfully."} )
    else
      redirect_to("/frontier_inputs/#{the_frontier_input.id}", { :alert => "Frontier input failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_frontier_input = FrontierInput.where({ :id => the_id }).at(0)

    the_frontier_input.destroy

    redirect_to("/frontier_inputs", { :notice => "Frontier input deleted successfully."} )
  end
end
