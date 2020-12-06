class FrontiersController < ApplicationController
  def index
    matching_frontiers = Frontier.all

    @list_of_frontiers = matching_frontiers.order({ :created_at => :desc })

    render({ :template => "frontiers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_frontiers = Frontier.where({ :id => the_id })

    @the_frontier = matching_frontiers.at(0)

    render({ :template => "frontiers/show.html.erb" })
  end

  def create
    the_frontier = Frontier.new
    the_frontier.user_id = params.fetch("query_user_id")
    the_frontier.name = params.fetch("query_name")

    if the_frontier.valid?
      the_frontier.save
      redirect_to("/frontiers", { :notice => "Frontier created successfully." })
    else
      redirect_to("/frontiers", { :notice => "Frontier failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_frontier = Frontier.where({ :id => the_id }).at(0)

    the_frontier.user_id = params.fetch("query_user_id")
    the_frontier.name = params.fetch("query_name")

    if the_frontier.valid?
      the_frontier.save
      redirect_to("/frontiers/#{the_frontier.id}", { :notice => "Frontier updated successfully."} )
    else
      redirect_to("/frontiers/#{the_frontier.id}", { :alert => "Frontier failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_frontier = Frontier.where({ :id => the_id }).at(0)

    the_frontier.destroy

    redirect_to("/frontiers", { :notice => "Frontier deleted successfully."} )
  end
end
