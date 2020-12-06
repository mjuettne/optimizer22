class WeightsController < ApplicationController
  def index
    matching_weights = Weight.all

    @list_of_weights = matching_weights.order({ :created_at => :desc })

    render({ :template => "weights/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_weights = Weight.where({ :id => the_id })

    @the_weight = matching_weights.at(0)

    render({ :template => "weights/show.html.erb" })
  end

  def create
    the_weight = Weight.new
    the_weight.portfolio_id = params.fetch("query_portfolio_id")
    the_weight.weight = params.fetch("query_weight")
    the_weight.asset_class_id = params.fetch("query_asset_class_id")

    if the_weight.valid?
      the_weight.save
      redirect_to("/weights", { :notice => "Weight created successfully." })
    else
      redirect_to("/weights", { :notice => "Weight failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_weight = Weight.where({ :id => the_id }).at(0)

    the_weight.portfolio_id = params.fetch("query_portfolio_id")
    the_weight.weight = params.fetch("query_weight")
    the_weight.asset_class_id = params.fetch("query_asset_class_id")

    if the_weight.valid?
      the_weight.save
      redirect_to("/weights/#{the_weight.id}", { :notice => "Weight updated successfully."} )
    else
      redirect_to("/weights/#{the_weight.id}", { :alert => "Weight failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_weight = Weight.where({ :id => the_id }).at(0)

    the_weight.destroy

    redirect_to("/weights", { :notice => "Weight deleted successfully."} )
  end
end
