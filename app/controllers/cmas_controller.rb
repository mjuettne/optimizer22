class CmasController < ApplicationController
  def index
    matching_cmas = Cma.all

    @list_of_cmas = matching_cmas.order({ :created_at => :desc })

    render({ :template => "cmas/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_cmas = Cma.where({ :id => the_id })

    @the_cma = matching_cmas.at(0)

    render({ :template => "cmas/show.html.erb" })
  end

  def create
    the_cma = Cma.new
    the_cma.name = params.fetch("query_name")

    if the_cma.valid?
      the_cma.save
      redirect_to("/cmas", { :notice => "Cma created successfully." })
    else
      redirect_to("/cmas", { :notice => "Cma failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_cma = Cma.where({ :id => the_id }).at(0)

    the_cma.name = params.fetch("query_name")

    if the_cma.valid?
      the_cma.save
      redirect_to("/cmas/#{the_cma.id}", { :notice => "Cma updated successfully."} )
    else
      redirect_to("/cmas/#{the_cma.id}", { :alert => "Cma failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_cma = Cma.where({ :id => the_id }).at(0)

    the_cma.destroy

    redirect_to("/cmas", { :notice => "Cma deleted successfully."} )
  end
end
