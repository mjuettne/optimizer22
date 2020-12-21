class CmaInputsController < ApplicationController
  def index
    the_cma_id = params.fetch("cma_id")
    @the_cma = Cma.where({:id => the_cma_id})[0]
    @asset_class = AssetClass.all
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
    query_cma_id = params.fetch("query_cma_id")
    query_exp_ret = params.fetch("query_exp_ret")
    query_std_dev = params.fetch("query_std_dev")
    query_skew = params.fetch("query_skew")
    query_kurt = params.fetch("query_kurt")
    query_yield = params.fetch("query_yield")
    query_asset_class_id = params.fetch("query_asset_class_id")
    
    for i in 1...query_cma_id.length
    the_cma_input = CmaInput.new
    the_cma_input.cma_id = query_cma_id[i-1]
    the_cma_input.exp_ret = query_exp_ret[i-1]
    the_cma_input.std_dev = query_std_dev[i-1]
    the_cma_input.skew = query_skew[i-1]
    the_cma_input.kurt = query_kurt[i-1]
    the_cma_input.yield = query_yield[i-1]
    the_cma_input.asset_class_id = query_asset_class_id[i-1]
    the_cma_input.save
    end
    redirect_to("/cmas", { :notice => "Cma input created successfully." })
  end
  
  def update_all
    the_id = params.fetch("query_cma_input_id")
    
    query_cma_id = params.fetch("query_cma_id")
    query_exp_ret = params.fetch("query_exp_ret")
    query_std_dev = params.fetch("query_std_dev")
    query_skew = params.fetch("query_skew")
    query_kurt = params.fetch("query_kurt")
    query_yield = params.fetch("query_yield")
    query_asset_class_id = params.fetch("query_asset_class_id")

    length = query_cma_id.length.to_i
    length = length +1
    for i in 1...length
    the_cma_input = CmaInput.where({ :id => the_id[i-1] }).at(0)
    the_cma_input.cma_id = query_cma_id[i-1]
    the_cma_input.exp_ret = query_exp_ret[i-1]
    the_cma_input.std_dev = query_std_dev[i-1]
    the_cma_input.skew = query_skew[i-1]
    the_cma_input.kurt = query_kurt[i-1]
    the_cma_input.yield = query_yield[i-1]
    the_cma_input.asset_class_id = query_asset_class_id[i-1]
    the_cma_input.save
    end
      redirect_to("/cmas/#{query_cma_id[0]} ", { :notice => "CMAs Updated Successfully." })
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
