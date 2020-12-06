class PortfoliosController < ApplicationController
  def index
    matching_portfolios = Portfolio.all

    @list_of_portfolios = matching_portfolios.order({ :created_at => :desc })

    render({ :template => "portfolios/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_portfolios = Portfolio.where({ :id => the_id })

    @the_portfolio = matching_portfolios.at(0)

    render({ :template => "portfolios/show.html.erb" })
  end

  def create
    the_portfolio = Portfolio.new
    the_portfolio.user_id = params.fetch("query_user_id")
    the_portfolio.name = params.fetch("query_name")

    if the_portfolio.valid?
      the_portfolio.save
      redirect_to("/portfolios", { :notice => "Portfolio created successfully." })
    else
      redirect_to("/portfolios", { :notice => "Portfolio failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)

    the_portfolio.user_id = params.fetch("query_user_id")
    the_portfolio.name = params.fetch("query_name")

    if the_portfolio.valid?
      the_portfolio.save
      redirect_to("/portfolios/#{the_portfolio.id}", { :notice => "Portfolio updated successfully."} )
    else
      redirect_to("/portfolios/#{the_portfolio.id}", { :alert => "Portfolio failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)

    the_portfolio.destroy

    redirect_to("/portfolios", { :notice => "Portfolio deleted successfully."} )
  end
end
