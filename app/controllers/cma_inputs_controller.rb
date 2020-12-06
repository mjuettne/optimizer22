class CmaInputsController < ApplicationController
  def index
    matching_cma_inputs = CmaInput.all

    @list_of_cma_inputs = matching_cma_inputs.order({ :created_at => :desc })

    render({ :template => "cma_inputs/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cma_inputs = CmaInput.where({ :id => the_id })

    @the_cma_input = matching_cma_inputs.at(0)

    render({ :template => "cma_inputs/show.html.erb" })
  end

  def create
    the_cma_input = CmaInput.new
    the_cma_input.cma_id = params.fetch("query_cma_id")
    the_cma_input.exp_ret = params.fetch("query_exp_ret")
    the_cma_input.std_dev = params.fetch("query_std_dev")
    the_cma_input.skew = params.fetch("query_skew")
    the_cma_input.kurt = params.fetch("query_kurt")
    the_cma_input.yield = params.fetch("query_yield")
    the_cma_input.asset_class_id = params.fetch("query_asset_class_id")

    if the_cma_input.valid?
      the_cma_input.save
      redirect_to("/cma_inputs", { :notice => "Cma input created successfully." })
    else
      redirect_to("/cma_inputs", { :notice => "Cma input failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cma_input = CmaInput.where({ :id => the_id }).at(0)

    the_cma_input.cma_id = params.fetch("query_cma_id")
    the_cma_input.exp_ret = params.fetch("query_exp_ret")
    the_cma_input.std_dev = params.fetch("query_std_dev")
    the_cma_input.skew = params.fetch("query_skew")
    the_cma_input.kurt = params.fetch("query_kurt")
    the_cma_input.yield = params.fetch("query_yield")
    the_cma_input.asset_class_id = params.fetch("query_asset_class_id")

    if the_cma_input.valid?
      the_cma_input.save
      redirect_to("/cma_inputs/#{the_cma_input.id}", { :notice => "Cma input updated successfully."} )
    else
      redirect_to("/cma_inputs/#{the_cma_input.id}", { :alert => "Cma input failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cma_input = CmaInput.where({ :id => the_id }).at(0)

    the_cma_input.destroy

    redirect_to("/cma_inputs", { :notice => "Cma input deleted successfully."} )
  end
end
