class AssetClassesController < ApplicationController
  def index
    matching_asset_classes = AssetClass.all

    @list_of_asset_classes = matching_asset_classes.order({ :created_at => :desc })

    render({ :template => "asset_classes/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_asset_classes = AssetClass.where({ :id => the_id })

    @the_asset_class = matching_asset_classes.at(0)

    render({ :template => "asset_classes/show.html.erb" })
  end

  def create
    the_asset_class = AssetClass.new
    the_asset_class.name = params.fetch("query_name")

    if the_asset_class.valid?
      the_asset_class.save
      redirect_to("/asset_classes", { :notice => "Asset class created successfully." })
    else
      redirect_to("/asset_classes", { :notice => "Asset class failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_asset_class = AssetClass.where({ :id => the_id }).at(0)

    the_asset_class.name = params.fetch("query_name")

    if the_asset_class.valid?
      the_asset_class.save
      redirect_to("/asset_classes/#{the_asset_class.id}", { :notice => "Asset class updated successfully."} )
    else
      redirect_to("/asset_classes/#{the_asset_class.id}", { :alert => "Asset class failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_asset_class = AssetClass.where({ :id => the_id }).at(0)

    the_asset_class.destroy

    redirect_to("/asset_classes", { :notice => "Asset class deleted successfully."} )
  end
end
