class ForecastsController < ApplicationController
  def index
    require 'net/http'
    require 'json'
    matching_forecasts = Forecast.all
    @cmas = Cma.all
    @correlations = Correlation.all
    @portfolios = Portfolio.all
    @list_of_forecasts = matching_forecasts.order({ :created_at => :desc })


    render({ :template => "forecasts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_forecasts = Forecast.where({ :id => the_id })

    @the_forecast = matching_forecasts.at(0)

    @the_forecast_input = ForecastInput.all.where({:forecast_id => @the_forecast.id}).at(0)
    
    @cma1 = Cma.all.where({:id => @the_forecast_input.year1_cma_id}).at(0).name
    @portfolios = Portfolio.all
    @cmas = Cma.all
    @correlations = Correlation.all

    render({ :template => "forecasts/show.html.erb" })
  end

  def create
    the_forecast = Forecast.new
    the_forecast.user_id = params.fetch("query_user_id")
    the_forecast.name = params.fetch("query_name")
    the_forecast.save

    income = params.fetch("query_income").to_f
    expense = params.fetch("query_spend_value").to_f
    cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    correl_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    inflation = params.fetch("query_inflation").to_f

    forecasts = Forecast.all
    newest_forecast_id = forecasts.order({ :created_at => :desc }).at(0).id

    the_forecast_input = ForecastInput.new  
    the_forecast_input.forecast_id = newest_forecast_id
    the_forecast_input.cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    the_forecast_input.correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    if params.fetch("query_portfolio1").blank?
    else
      the_forecast_input.portfolio1_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio1")}).at(0).id
    end

    if params.fetch("query_portfolio2").blank?
    else
      the_forecast_input.portfolio2_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio2")}).at(0).id
    end

    if params.fetch("query_portfolio3").blank?
    else
      the_forecast_input.portfolio3_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio3")}).at(0).id
    end

    if params.fetch("query_portfolio4").blank?
    else
      the_forecast_input.portfolio4_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio4")}).at(0).id
    end
    
    if params.fetch("query_portfolio5").blank?
    else
      the_forecast_input.portfolio5_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio5")}).at(0).id
    end    
    the_forecast_input.inflation = inflation
    the_forecast_input.starting_value = params.fetch("query_starting_value")
    the_forecast_input.income = params.fetch("query_income")
    the_forecast_input.spend_value = params.fetch("query_spend_value")
    # the_forecast_input.weight_port1 = params.fetch("query_weight_port1")
    # the_forecast_input.weight_port2 = params.fetch("query_weight_port2")

    the_forecast_input.year1_cf = income
    the_forecast_input.year2_cf = income*(1+inflation/100)
    the_forecast_input.year3_cf = income*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year4_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year5_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year6_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year7_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year8_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year9_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year10_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year11_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year12_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year13_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year14_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year15_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year16_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year17_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year18_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year19_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year20_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year21_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year22_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year23_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year24_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year25_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year26_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year27_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year28_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year29_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year30_cf = income*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    

    the_forecast_input.year1_cma_id = cma_id
    the_forecast_input.year2_cma_id = cma_id
    the_forecast_input.year3_cma_id = cma_id
    the_forecast_input.year4_cma_id = cma_id
    the_forecast_input.year5_cma_id = cma_id
    the_forecast_input.year6_cma_id = cma_id
    the_forecast_input.year7_cma_id = cma_id
    the_forecast_input.year8_cma_id = cma_id
    the_forecast_input.year9_cma_id = cma_id
    the_forecast_input.year10_cma_id = cma_id
    the_forecast_input.year11_cma_id = cma_id
    the_forecast_input.year12_cma_id = cma_id
    the_forecast_input.year13_cma_id = cma_id
    the_forecast_input.year14_cma_id = cma_id
    the_forecast_input.year15_cma_id = cma_id
    the_forecast_input.year16_cma_id = cma_id
    the_forecast_input.year17_cma_id = cma_id
    the_forecast_input.year18_cma_id = cma_id
    the_forecast_input.year19_cma_id = cma_id
    the_forecast_input.year20_cma_id = cma_id
    the_forecast_input.year21_cma_id = cma_id
    the_forecast_input.year22_cma_id = cma_id
    the_forecast_input.year23_cma_id = cma_id
    the_forecast_input.year24_cma_id = cma_id
    the_forecast_input.year25_cma_id = cma_id
    the_forecast_input.year26_cma_id = cma_id
    the_forecast_input.year27_cma_id = cma_id
    the_forecast_input.year28_cma_id = cma_id
    the_forecast_input.year29_cma_id = cma_id
    the_forecast_input.year30_cma_id = cma_id
    
    the_forecast_input.year1_correl_id = correl_id
    the_forecast_input.year2_correl_id = correl_id
    the_forecast_input.year3_correl_id = correl_id
    the_forecast_input.year4_correl_id = correl_id
    the_forecast_input.year5_correl_id = correl_id
    the_forecast_input.year6_correl_id = correl_id
    the_forecast_input.year7_correl_id = correl_id
    the_forecast_input.year8_correl_id = correl_id
    the_forecast_input.year9_correl_id = correl_id
    the_forecast_input.year10_correl_id = correl_id
    the_forecast_input.year11_correl_id = correl_id
    the_forecast_input.year12_correl_id = correl_id
    the_forecast_input.year13_correl_id = correl_id
    the_forecast_input.year14_correl_id = correl_id
    the_forecast_input.year15_correl_id = correl_id
    the_forecast_input.year16_correl_id = correl_id
    the_forecast_input.year17_correl_id = correl_id
    the_forecast_input.year18_correl_id = correl_id
    the_forecast_input.year19_correl_id = correl_id
    the_forecast_input.year20_correl_id = correl_id
    the_forecast_input.year21_correl_id = correl_id
    the_forecast_input.year22_correl_id = correl_id
    the_forecast_input.year23_correl_id = correl_id
    the_forecast_input.year24_correl_id = correl_id
    the_forecast_input.year25_correl_id = correl_id
    the_forecast_input.year26_correl_id = correl_id
    the_forecast_input.year27_correl_id = correl_id
    the_forecast_input.year28_correl_id = correl_id
    the_forecast_input.year29_correl_id = correl_id
    the_forecast_input.year30_correl_id = correl_id

    the_forecast_input.year1_exp = expense
    the_forecast_input.year2_exp = expense*(1+inflation/100)
    the_forecast_input.year3_exp = expense*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year4_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year5_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year6_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year7_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year8_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year9_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year10_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year11_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year12_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year13_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year14_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year15_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year16_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year17_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year18_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year19_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year20_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year21_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year22_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year23_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year24_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year25_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year26_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year27_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year28_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year29_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    the_forecast_input.year30_exp = expense*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)*(1+inflation/100)
    
     if the_forecast_input.valid?
        the_forecast_input.save
        redirect_to("/forecasts", { :notice => "Forecast created successfully." })
     else
        redirect_to("/forecasts", { :alert => "Forecast failed to create successfully!" })
     end

  end

  def update
    the_id = params.fetch("path_id")
    the_forecast = Forecast.where({ :id => the_id }).at(0)

    the_forecast.user_id = params.fetch("query_user_id")
    the_forecast.name = params.fetch("query_name")

    if the_forecast.valid?
      the_forecast.save
      redirect_to("/forecasts/#{the_forecast.id}", { :notice => "Forecast updated successfully."} )
    else
      redirect_to("/forecasts/#{the_forecast.id}", { :alert => "Forecast failed to update successfully." })
    end
  end

  def update_settings
  the_id = params.fetch("path_id")
  the_forecast = Forecast.where({ :id => the_id }).at(0)
  the_forecast_input = ForecastInput.where({:forecast_id => the_id }).at(0)
  
  the_forecast_input.year1_cf = params.fetch("query_income_year1")
  the_forecast_input.year2_cf = params.fetch("query_income_year2")
  the_forecast_input.year3_cf = params.fetch("query_income_year3")
  the_forecast_input.year4_cf = params.fetch("query_income_year4")
  the_forecast_input.year5_cf = params.fetch("query_income_year5")
  the_forecast_input.year6_cf = params.fetch("query_income_year6")
  the_forecast_input.year7_cf = params.fetch("query_income_year7")
  the_forecast_input.year8_cf = params.fetch("query_income_year8")
  the_forecast_input.year9_cf = params.fetch("query_income_year9")
  the_forecast_input.year10_cf = params.fetch("query_income_year10")
  the_forecast_input.year11_cf = params.fetch("query_income_year11")
  the_forecast_input.year12_cf = params.fetch("query_income_year12")
  the_forecast_input.year13_cf = params.fetch("query_income_year13")
  the_forecast_input.year14_cf = params.fetch("query_income_year14")
  the_forecast_input.year15_cf = params.fetch("query_income_year15")
  the_forecast_input.year16_cf = params.fetch("query_income_year16")
  the_forecast_input.year17_cf = params.fetch("query_income_year17")
  the_forecast_input.year18_cf = params.fetch("query_income_year18")
  the_forecast_input.year19_cf = params.fetch("query_income_year19")
  the_forecast_input.year20_cf = params.fetch("query_income_year20") 
  the_forecast_input.year21_cf = params.fetch("query_income_year21")
  the_forecast_input.year22_cf = params.fetch("query_income_year22")
  the_forecast_input.year23_cf = params.fetch("query_income_year23")
  the_forecast_input.year24_cf = params.fetch("query_income_year24")
  the_forecast_input.year25_cf = params.fetch("query_income_year25")
  the_forecast_input.year26_cf = params.fetch("query_income_year26")
  the_forecast_input.year27_cf = params.fetch("query_income_year27")
  the_forecast_input.year28_cf = params.fetch("query_income_year28")
  the_forecast_input.year29_cf = params.fetch("query_income_year29")
  the_forecast_input.year30_cf = params.fetch("query_income_year30")
  
  the_forecast_input.year1_exp = params.fetch("query_expense_year1")
  the_forecast_input.year2_exp = params.fetch("query_expense_year2")
  the_forecast_input.year3_exp = params.fetch("query_expense_year3")
  the_forecast_input.year4_exp = params.fetch("query_expense_year4")
  the_forecast_input.year5_exp = params.fetch("query_expense_year5")
  the_forecast_input.year6_exp = params.fetch("query_expense_year6")
  the_forecast_input.year7_exp = params.fetch("query_expense_year7")
  the_forecast_input.year8_exp = params.fetch("query_expense_year8")
  the_forecast_input.year9_exp = params.fetch("query_expense_year9")
  the_forecast_input.year10_exp = params.fetch("query_expense_year10")
  the_forecast_input.year11_exp = params.fetch("query_expense_year11")
  the_forecast_input.year12_exp = params.fetch("query_expense_year12")
  the_forecast_input.year13_exp = params.fetch("query_expense_year13")
  the_forecast_input.year14_exp = params.fetch("query_expense_year14")
  the_forecast_input.year15_exp = params.fetch("query_expense_year15")
  the_forecast_input.year16_exp = params.fetch("query_expense_year16")
  the_forecast_input.year17_exp = params.fetch("query_expense_year17")
  the_forecast_input.year18_exp = params.fetch("query_expense_year18")
  the_forecast_input.year19_exp = params.fetch("query_expense_year19")
  the_forecast_input.year20_exp = params.fetch("query_expense_year20")  
  the_forecast_input.year21_exp = params.fetch("query_expense_year21")
  the_forecast_input.year22_exp = params.fetch("query_expense_year22")
  the_forecast_input.year23_exp = params.fetch("query_expense_year23")
  the_forecast_input.year24_exp = params.fetch("query_expense_year24")
  the_forecast_input.year25_exp = params.fetch("query_expense_year25")
  the_forecast_input.year26_exp = params.fetch("query_expense_year26")
  the_forecast_input.year27_exp = params.fetch("query_expense_year27")
  the_forecast_input.year28_exp = params.fetch("query_expense_year28")
  the_forecast_input.year29_exp = params.fetch("query_expense_year29")
  the_forecast_input.year30_exp = params.fetch("query_expense_year30")    

  the_forecast_input.year1_cma_id = Cma.all.where({:name => params.fetch("query_cma_year1")}).at(0).id
  the_forecast_input.year2_cma_id = Cma.all.where({:name => params.fetch("query_cma_year2")}).at(0).id
  the_forecast_input.year3_cma_id = Cma.all.where({:name => params.fetch("query_cma_year3")}).at(0).id
  the_forecast_input.year4_cma_id = Cma.all.where({:name => params.fetch("query_cma_year4")}).at(0).id
  the_forecast_input.year5_cma_id = Cma.all.where({:name => params.fetch("query_cma_year5")}).at(0).id
  the_forecast_input.year6_cma_id = Cma.all.where({:name => params.fetch("query_cma_year6")}).at(0).id
  the_forecast_input.year7_cma_id = Cma.all.where({:name => params.fetch("query_cma_year7")}).at(0).id
  the_forecast_input.year8_cma_id = Cma.all.where({:name => params.fetch("query_cma_year8")}).at(0).id
  the_forecast_input.year9_cma_id = Cma.all.where({:name => params.fetch("query_cma_year9")}).at(0).id
  the_forecast_input.year10_cma_id = Cma.all.where({:name => params.fetch("query_cma_year10")}).at(0).id
  the_forecast_input.year11_cma_id = Cma.all.where({:name => params.fetch("query_cma_year11")}).at(0).id
  the_forecast_input.year12_cma_id = Cma.all.where({:name => params.fetch("query_cma_year12")}).at(0).id
  the_forecast_input.year13_cma_id = Cma.all.where({:name => params.fetch("query_cma_year13")}).at(0).id
  the_forecast_input.year14_cma_id = Cma.all.where({:name => params.fetch("query_cma_year14")}).at(0).id
  the_forecast_input.year15_cma_id = Cma.all.where({:name => params.fetch("query_cma_year15")}).at(0).id
  the_forecast_input.year16_cma_id = Cma.all.where({:name => params.fetch("query_cma_year16")}).at(0).id
  the_forecast_input.year17_cma_id = Cma.all.where({:name => params.fetch("query_cma_year17")}).at(0).id
  the_forecast_input.year18_cma_id = Cma.all.where({:name => params.fetch("query_cma_year18")}).at(0).id
  the_forecast_input.year19_cma_id = Cma.all.where({:name => params.fetch("query_cma_year19")}).at(0).id
  the_forecast_input.year20_cma_id = Cma.all.where({:name => params.fetch("query_cma_year20")}).at(0).id
  the_forecast_input.year21_cma_id = Cma.all.where({:name => params.fetch("query_cma_year21")}).at(0).id
  the_forecast_input.year22_cma_id = Cma.all.where({:name => params.fetch("query_cma_year22")}).at(0).id
  the_forecast_input.year23_cma_id = Cma.all.where({:name => params.fetch("query_cma_year23")}).at(0).id
  the_forecast_input.year24_cma_id = Cma.all.where({:name => params.fetch("query_cma_year24")}).at(0).id
  the_forecast_input.year25_cma_id = Cma.all.where({:name => params.fetch("query_cma_year25")}).at(0).id
  the_forecast_input.year26_cma_id = Cma.all.where({:name => params.fetch("query_cma_year26")}).at(0).id
  the_forecast_input.year27_cma_id = Cma.all.where({:name => params.fetch("query_cma_year27")}).at(0).id
  the_forecast_input.year28_cma_id = Cma.all.where({:name => params.fetch("query_cma_year28")}).at(0).id
  the_forecast_input.year29_cma_id = Cma.all.where({:name => params.fetch("query_cma_year29")}).at(0).id
  the_forecast_input.year30_cma_id = Cma.all.where({:name => params.fetch("query_cma_year30")}).at(0).id

  the_forecast_input.year1_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year1")}).at(0).id
  the_forecast_input.year2_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year2")}).at(0).id
  the_forecast_input.year3_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year3")}).at(0).id
  the_forecast_input.year4_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year4")}).at(0).id
  the_forecast_input.year5_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year5")}).at(0).id
  the_forecast_input.year6_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year6")}).at(0).id
  the_forecast_input.year7_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year7")}).at(0).id
  the_forecast_input.year8_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year8")}).at(0).id
  the_forecast_input.year9_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year9")}).at(0).id
  the_forecast_input.year10_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year10")}).at(0).id
  the_forecast_input.year11_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year11")}).at(0).id
  the_forecast_input.year12_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year12")}).at(0).id
  the_forecast_input.year13_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year13")}).at(0).id
  the_forecast_input.year14_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year14")}).at(0).id
  the_forecast_input.year15_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year15")}).at(0).id
  the_forecast_input.year16_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year16")}).at(0).id
  the_forecast_input.year17_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year17")}).at(0).id
  the_forecast_input.year18_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year18")}).at(0).id
  the_forecast_input.year19_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year19")}).at(0).id
  the_forecast_input.year20_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year20")}).at(0).id
  the_forecast_input.year21_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year21")}).at(0).id
  the_forecast_input.year22_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year22")}).at(0).id
  the_forecast_input.year23_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year23")}).at(0).id
  the_forecast_input.year24_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year24")}).at(0).id
  the_forecast_input.year25_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year25")}).at(0).id
  the_forecast_input.year26_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year26")}).at(0).id
  the_forecast_input.year27_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year27")}).at(0).id
  the_forecast_input.year28_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year28")}).at(0).id
  the_forecast_input.year29_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year29")}).at(0).id
  the_forecast_input.year30_correl_id = Correlation.all.where({:name => params.fetch("query_correlation_year30")}).at(0).id


  the_forecast_input.save
  redirect_to("/forecasts/#{the_forecast.id}", { :notice => "Forecast updated successfully."} )  
  end

  def destroy
    the_id = params.fetch("path_id")
    the_forecast = Forecast.where({ :id => the_id }).at(0)

    the_forecast.destroy

    redirect_to("/forecasts", { :notice => "Forecast deleted successfully."} )
  end

  def calculate
    require 'json'
    require 'matrix'
    the_id = params.fetch("path_id")
    matching_forecasts = Forecast.where({ :id => the_id })
    @the_forecast = matching_forecasts.at(0)
    @the_forecast_input = ForecastInput.all.where({:forecast_id => @the_forecast.id}).at(0)
    @portfolios = Portfolio.all
    ################################
    ######## PORTFOLIO 1 ###########
    ################################
    portfolio1 = Weight.all.where({:portfolio_id => @the_forecast_input.portfolio1_id}).where({:inclusion => "yes"})
    length_port1 = portfolio1.length

    asset_class_port1 = Array.new(length_port1)
    for i in 0...length_port1
      asset_class_port1[i] = portfolio1[i].asset_class_id
    end

    @weights_port1 = Array.new(length_port1)
    for i in 0...length_port1
      @weights_port1[i] = portfolio1[i].weight.to_f/100
    end

    ################################
    ######## PORTFOLIO 2 ###########
    ################################
    portfolio2 = Weight.all.where({:portfolio_id => @the_forecast_input.portfolio2_id}).where({:inclusion => "yes"})
    length_port2 = portfolio2.length

    asset_class_port2 = Array.new(length_port2)
    for i in 0...length_port2
      asset_class_port2[i] = portfolio2[i].asset_class_id
    end

    @weights_port2 = Array.new(length_port2)
    for i in 0...length_port2
      @weights_port2[i] = portfolio2[i].weight.to_f/100
    end

    ################################
    ######## PORTFOLIO 3 ###########
    ################################
    portfolio3 = Weight.all.where({:portfolio_id => @the_forecast_input.portfolio3_id}).where({:inclusion => "yes"})
    length_port3 = portfolio3.length

    asset_class_port3 = Array.new(length_port3)
    for i in 0...length_port3
      asset_class_port3[i] = portfolio3[i].asset_class_id
    end

    @weights_port3 = Array.new(length_port3)
    for i in 0...length_port3
      @weights_port3[i] = portfolio3[i].weight.to_f/100
    end

    ################################
    ######## PORTFOLIO 4 ###########
    ################################
    portfolio4 = Weight.all.where({:portfolio_id => @the_forecast_input.portfolio4_id}).where({:inclusion => "yes"})
    length_port4 = portfolio4.length

    asset_class_port4 = Array.new(length_port4)
    for i in 0...length_port4
      asset_class_port4[i] = portfolio4[i].asset_class_id
    end

    @weights_port4 = Array.new(length_port4)
    for i in 0...length_port4
      @weights_port4[i] = portfolio4[i].weight.to_f/100
    end

    # ################################
    # ######## PORTFOLIO 5 ###########
    # ################################
    # portfolio5 = Weight.all.where({:portfolio_id => @the_forecast_input.portfolio4_id}).where({:inclusion => "yes"})
    # length_port5 = portfolio4.length

    # asset_class_port5 = Array.new(length_port5)
    # for i in 0...length_port5
    #   asset_class_port5[i] = portfolio5[i].asset_class_id
    # end

    # @weights_port5 = Array.new(length_port5)
    # for i in 0...length_port5
    #   @weights_port5[i] = portfolio5[i].weight.to_f/100
    # end


    ################################
    ######## CORRELATIONS ###########
    ################################
    
    correlation_id_year1 = @the_forecast_input.year1_correl_id
    correlation_id_year2 = @the_forecast_input.year2_correl_id
    correlation_id_year3 = @the_forecast_input.year3_correl_id
    correlation_id_year4 = @the_forecast_input.year4_correl_id
    correlation_id_year5 = @the_forecast_input.year5_correl_id
    correlation_id_year6 = @the_forecast_input.year6_correl_id
    correlation_id_year7 = @the_forecast_input.year7_correl_id
    correlation_id_year8 = @the_forecast_input.year8_correl_id
    correlation_id_year9 = @the_forecast_input.year9_correl_id
    correlation_id_year10 = @the_forecast_input.year10_correl_id
    correlation_id_year11 = @the_forecast_input.year11_correl_id
    correlation_id_year12 = @the_forecast_input.year12_correl_id
    correlation_id_year13 = @the_forecast_input.year13_correl_id
    correlation_id_year14 = @the_forecast_input.year14_correl_id
    correlation_id_year15 = @the_forecast_input.year15_correl_id
    correlation_id_year16 = @the_forecast_input.year16_correl_id
    correlation_id_year17 = @the_forecast_input.year17_correl_id
    correlation_id_year18 = @the_forecast_input.year18_correl_id
    correlation_id_year19 = @the_forecast_input.year19_correl_id
    correlation_id_year20 = @the_forecast_input.year20_correl_id
    correlation_id_year21 = @the_forecast_input.year21_correl_id
    correlation_id_year22 = @the_forecast_input.year22_correl_id
    correlation_id_year23 = @the_forecast_input.year23_correl_id
    correlation_id_year24 = @the_forecast_input.year24_correl_id
    correlation_id_year25 = @the_forecast_input.year25_correl_id
    correlation_id_year26 = @the_forecast_input.year26_correl_id
    correlation_id_year27 = @the_forecast_input.year27_correl_id
    correlation_id_year28 = @the_forecast_input.year28_correl_id
    correlation_id_year29 = @the_forecast_input.year29_correl_id
    correlation_id_year30 = @the_forecast_input.year30_correl_id    


    ######## YEAR 1 (PORT 1) ###########
    
    correlation_inputs_port1_year1 = CorrelationInput.all.where({:correlation_id => correlation_id_year1 })
    @mean_port1_year1 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year1 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year1 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year1 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    @correlation_port1_year1 = Matrix.build(length_port1) {1}
    for i in 0...length_port1
      for j in 0...i
        @correlation_port1_year1[i,j] = correlation_inputs_port1_year1.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
        @correlation_port1_year1[j,i] = correlation_inputs_port1_year1.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
      end
    end

    @yields_port1_year1 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

     @correlation_port1_year2 = @correlation_port1_year1
     @correlation_port1_year3 = @correlation_port1_year1
     @correlation_port1_year4 = @correlation_port1_year1
     @correlation_port1_year5 = @correlation_port1_year1
     @correlation_port1_year6 = @correlation_port1_year1
     @correlation_port1_year7 = @correlation_port1_year1
     @correlation_port1_year8 = @correlation_port1_year1
     @correlation_port1_year9 = @correlation_port1_year1
     @correlation_port1_year10 = @correlation_port1_year1
     @correlation_port1_year11 = @correlation_port1_year1
     @correlation_port1_year12 = @correlation_port1_year1
     @correlation_port1_year13 = @correlation_port1_year1
     @correlation_port1_year14 = @correlation_port1_year1
     @correlation_port1_year15 = @correlation_port1_year1
     @correlation_port1_year16 = @correlation_port1_year1
     @correlation_port1_year17 = @correlation_port1_year1
     @correlation_port1_year18 = @correlation_port1_year1
     @correlation_port1_year19 = @correlation_port1_year1
     @correlation_port1_year20 = @correlation_port1_year1
     @correlation_port1_year21 = @correlation_port1_year1
     @correlation_port1_year22 = @correlation_port1_year1
     @correlation_port1_year23 = @correlation_port1_year1
     @correlation_port1_year24 = @correlation_port1_year1
     @correlation_port1_year25 = @correlation_port1_year1
     @correlation_port1_year26 = @correlation_port1_year1
     @correlation_port1_year27 = @correlation_port1_year1
     @correlation_port1_year28 = @correlation_port1_year1
     @correlation_port1_year29 = @correlation_port1_year1
     @correlation_port1_year30 = @correlation_port1_year1
     
       
    ######## YEAR 2 (PORT 1) ###########
    correlation_inputs_port1_year2 = CorrelationInput.all.where({:correlation_id => correlation_id_year2 })
    @mean_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year2 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year2[i,j] = correlation_inputs_port1_year2.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year2[j,i] = correlation_inputs_port1_year2.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 3 (PORT 1) ###########
    

    correlation_inputs_port1_year3 = CorrelationInput.all.where({:correlation_id => correlation_id_year3 })
    @mean_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year3 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year3[i,j] = correlation_inputs_port1_year3.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year3[j,i] = correlation_inputs_port1_year3.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 4 (PORT 1) ###########
    

    correlation_inputs_port1_year4 = CorrelationInput.all.where({:correlation_id => correlation_id_year4 })
    @mean_port1_year4 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year4 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year4 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year4 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year4 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year4[i,j] = correlation_inputs_port1_year4.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year4[j,i] = correlation_inputs_port1_year4.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year4 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 5 (PORT 1) ###########
    

    correlation_inputs_port1_year5 = CorrelationInput.all.where({:correlation_id => correlation_id_year5 })
    @mean_port1_year5 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year5 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year5 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year5 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year5 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year5[i,j] = correlation_inputs_port1_year5.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year5[j,i] = correlation_inputs_port1_year5.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year5 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 6 (PORT 1) ###########
    

    correlation_inputs_port1_year6 = CorrelationInput.all.where({:correlation_id => correlation_id_year6 })
    @mean_port1_year6 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year6 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year6 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year6 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year6 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year6[i,j] = correlation_inputs_port1_year6.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year6[j,i] = correlation_inputs_port1_year6.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year6 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 7 (PORT 1) ###########
    

    correlation_inputs_port1_year7 = CorrelationInput.all.where({:correlation_id => correlation_id_year7 })
    @mean_port1_year7 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year7 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year7 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year7 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year7 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year7[i,j] = correlation_inputs_port1_year7.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year7[j,i] = correlation_inputs_port1_year7.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year7 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 8 (PORT 1) ###########
    

    correlation_inputs_port1_year8 = CorrelationInput.all.where({:correlation_id => correlation_id_year8 })
    @mean_port1_year8 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year8 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year8 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year8 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year8 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year8[i,j] = correlation_inputs_port1_year8.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year8[j,i] = correlation_inputs_port1_year8.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year8 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 9 (PORT 1) ###########
    

    correlation_inputs_port1_year9 = CorrelationInput.all.where({:correlation_id => correlation_id_year9 })
    @mean_port1_year9 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year9 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year9 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year9 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year9 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year9[i,j] = correlation_inputs_port1_year9.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year9[j,i] = correlation_inputs_port1_year9.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year9 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 10 (PORT 1) ###########
    

    correlation_inputs_port1_year10 = CorrelationInput.all.where({:correlation_id => correlation_id_year10 })
    @mean_port1_year10 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year10 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year10 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year10 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year10 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year10[i,j] = correlation_inputs_port1_year10.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year10[j,i] = correlation_inputs_port1_year10.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year10 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 11 (PORT 1) ###########
    

    correlation_inputs_port1_year11 = CorrelationInput.all.where({:correlation_id => correlation_id_year11 })
    @mean_port1_year11 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year11 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year11 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year11 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year11 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year11[i,j] = correlation_inputs_port1_year11.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year11[j,i] = correlation_inputs_port1_year11.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year11 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 12 (PORT 1) ###########
    

    correlation_inputs_port1_year12 = CorrelationInput.all.where({:correlation_id => correlation_id_year12 })
    @mean_port1_year12 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year12 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year12 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year12 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year12 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year12[i,j] = correlation_inputs_port1_year12.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year12[j,i] = correlation_inputs_port1_year12.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year12 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 13 (PORT 1) ###########
    

    correlation_inputs_port1_year13 = CorrelationInput.all.where({:correlation_id => correlation_id_year13 })
    @mean_port1_year13 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year13 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year13 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year13 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year13 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year13[i,j] = correlation_inputs_port1_year13.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year13[j,i] = correlation_inputs_port1_year13.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year13 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 14 (PORT 1) ###########
    

    correlation_inputs_port1_year14 = CorrelationInput.all.where({:correlation_id => correlation_id_year14 })
    @mean_port1_year14 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year14 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year14 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year14 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year14 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year14[i,j] = correlation_inputs_port1_year14.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year14[j,i] = correlation_inputs_port1_year14.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year14 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 15 (PORT 1) ###########
    

    correlation_inputs_port1_year15 = CorrelationInput.all.where({:correlation_id => correlation_id_year15 })
    @mean_port1_year15 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year15 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year15 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year15 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year15 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year15[i,j] = correlation_inputs_port1_year15.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year15[j,i] = correlation_inputs_port1_year15.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year15 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 16 (PORT 1) ###########
    

    correlation_inputs_port1_year16 = CorrelationInput.all.where({:correlation_id => correlation_id_year16 })
    @mean_port1_year16 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year16 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year16 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year16 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year16 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year16[i,j] = correlation_inputs_port1_year16.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year16[j,i] = correlation_inputs_port1_year16.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year16 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 17 (PORT 1) ###########
    

    correlation_inputs_port1_year17 = CorrelationInput.all.where({:correlation_id => correlation_id_year17 })
    @mean_port1_year17 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year17 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year17 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year17 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year17 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year17[i,j] = correlation_inputs_port1_year17.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year17[j,i] = correlation_inputs_port1_year17.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year17 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 18 (PORT 1) ###########
    

    correlation_inputs_port1_year18 = CorrelationInput.all.where({:correlation_id => correlation_id_year18 })
    @mean_port1_year18 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year18 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year18 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year18 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year18 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year18[i,j] = correlation_inputs_port1_year18.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year18[j,i] = correlation_inputs_port1_year18.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year18 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 19 (PORT 1) ###########
    

    correlation_inputs_port1_year19 = CorrelationInput.all.where({:correlation_id => correlation_id_year19 })
    @mean_port1_year19 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year19 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year19 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year19 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year19 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year19[i,j] = correlation_inputs_port1_year19.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year19[j,i] = correlation_inputs_port1_year19.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year19 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 20 (PORT 1) ###########
    

    correlation_inputs_port1_year20 = CorrelationInput.all.where({:correlation_id => correlation_id_year20 })
    @mean_port1_year20 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year20 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year20 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year20 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year20 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year20[i,j] = correlation_inputs_port1_year20.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year20[j,i] = correlation_inputs_port1_year20.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year20 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 21 (PORT 1) ###########
    

    correlation_inputs_port1_year21 = CorrelationInput.all.where({:correlation_id => correlation_id_year21 })
    @mean_port1_year21 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year21 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year21 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year21 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year21 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year21[i,j] = correlation_inputs_port1_year21.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year21[j,i] = correlation_inputs_port1_year21.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year21 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 22 (PORT 1) ###########
    

    correlation_inputs_port1_year22 = CorrelationInput.all.where({:correlation_id => correlation_id_year22 })
    @mean_port1_year22 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year22 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year22 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year22 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year22 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year22[i,j] = correlation_inputs_port1_year22.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year22[j,i] = correlation_inputs_port1_year22.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year22 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 23 (PORT 1) ###########
    

    correlation_inputs_port1_year23 = CorrelationInput.all.where({:correlation_id => correlation_id_year23 })
    @mean_port1_year23 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year23 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year23 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year23 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year23 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year23[i,j] = correlation_inputs_port1_year23.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year23[j,i] = correlation_inputs_port1_year23.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year23 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 24 (PORT 1) ###########
    

    correlation_inputs_port1_year24 = CorrelationInput.all.where({:correlation_id => correlation_id_year24 })
    @mean_port1_year24 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year24 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year24 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year24 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    @correlation_port1_year24 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year24[i,j] = correlation_inputs_port1_year24.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year24[j,i] = correlation_inputs_port1_year24.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year24 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 25 (PORT 1) ###########
    

    correlation_inputs_port1_year25 = CorrelationInput.all.where({:correlation_id => correlation_id_year25 })
    @mean_port1_year25 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year25 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year25 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year25 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year25 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year25[i,j] = correlation_inputs_port1_year25.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year25[j,i] = correlation_inputs_port1_year25.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year25 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 26 (PORT 1) ###########
    

    correlation_inputs_port1_year26 = CorrelationInput.all.where({:correlation_id => correlation_id_year26 })
    @mean_port1_year26 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year26 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year26 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year26 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year26 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year26[i,j] = correlation_inputs_port1_year26.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year26[j,i] = correlation_inputs_port1_year26.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year26 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 27 (PORT 1) ###########
    

    correlation_inputs_port1_year27 = CorrelationInput.all.where({:correlation_id => correlation_id_year27 })
    @mean_port1_year27 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year27 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year27 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year27 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year27 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year27[i,j] = correlation_inputs_port1_year27.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year27[j,i] = correlation_inputs_port1_year27.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year27 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 28 (PORT 1) ###########
    

    correlation_inputs_port1_year28 = CorrelationInput.all.where({:correlation_id => correlation_id_year28 })
    @mean_port1_year28 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year28 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year28 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year28 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year28 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year28[i,j] = correlation_inputs_port1_year28.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year28[j,i] = correlation_inputs_port1_year28.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year28 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 29 (PORT 1) ###########
    

    correlation_inputs_port1_year29 = CorrelationInput.all.where({:correlation_id => correlation_id_year29 })
    @mean_port1_year29 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year29 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year29 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year29 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year29 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year29[i,j] = correlation_inputs_port1_year29.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year29[j,i] = correlation_inputs_port1_year29.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year29 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 30 (PORT 1) ###########
    

    correlation_inputs_port1_year30 = CorrelationInput.all.where({:correlation_id => correlation_id_year30 })
    @mean_port1_year30 = Array.new(length_port1)
    for i in 0...length_port1
      @mean_port1_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).exp_ret
    end
    @std_dev_port1_year30 = Array.new(length_port1)
    for i in 0...length_port1
      @std_dev_port1_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).std_dev
    end
    @skew_port1_year30 = Array.new(length_port1)
    for i in 0...length_port1
      @skew_port1_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).skew
    end
    @kurt_port1_year30 = Array.new(length_port1)
    for i in 0...length_port1
      @kurt_port1_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).kurt
    end    
    # @correlation_port1_year30 = Matrix.build(length_port1) {1}
    # for i in 0...length_port1
    #   for j in 0...i
    #     @correlation_port1_year30[i,j] = correlation_inputs_port1_year30.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #     @correlation_port1_year30[j,i] = correlation_inputs_port1_year30.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
    #   end
    # end
    @yields_port1_year30 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end
    

  ######## YEAR 1 (PORT 2) ###########
    
    correlation_inputs_port2_year1 = CorrelationInput.all.where({:correlation_id => correlation_id_year1 })
    @mean_port2_year1 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year1 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year1 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year1 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    @correlation_port2_year1 = Matrix.build(length_port2) {1}
    for i in 0...length_port2
      for j in 0...i
        @correlation_port2_year1[i,j] = correlation_inputs_port2_year1.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
        @correlation_port2_year1[j,i] = correlation_inputs_port2_year1.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
      end
    end
    @yields_port2_year1 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

     @correlation_port2_year2 = @correlation_port2_year1
     @correlation_port2_year3 = @correlation_port2_year1
     @correlation_port2_year4 = @correlation_port2_year1
     @correlation_port2_year5 = @correlation_port2_year1
     @correlation_port2_year6 = @correlation_port2_year1
     @correlation_port2_year7 = @correlation_port2_year1
     @correlation_port2_year8 = @correlation_port2_year1
     @correlation_port2_year9 = @correlation_port2_year1
     @correlation_port2_year10 = @correlation_port2_year1
     @correlation_port2_year11 = @correlation_port2_year1
     @correlation_port2_year12 = @correlation_port2_year1
     @correlation_port2_year13 = @correlation_port2_year1
     @correlation_port2_year14 = @correlation_port2_year1
     @correlation_port2_year15 = @correlation_port2_year1
     @correlation_port2_year16 = @correlation_port2_year1
     @correlation_port2_year17 = @correlation_port2_year1
     @correlation_port2_year18 = @correlation_port2_year1
     @correlation_port2_year19 = @correlation_port2_year1
     @correlation_port2_year20 = @correlation_port2_year1
     @correlation_port2_year21 = @correlation_port2_year1
     @correlation_port2_year22 = @correlation_port2_year1
     @correlation_port2_year23 = @correlation_port2_year1
     @correlation_port2_year24 = @correlation_port2_year1
     @correlation_port2_year25 = @correlation_port2_year1
     @correlation_port2_year26 = @correlation_port2_year1
     @correlation_port2_year27 = @correlation_port2_year1
     @correlation_port2_year28 = @correlation_port2_year1
     @correlation_port2_year29 = @correlation_port2_year1
     @correlation_port2_year30 = @correlation_port2_year1

    
    ######## YEAR 2 (PORT 2) ###########
    

    correlation_inputs_port2_year2 = CorrelationInput.all.where({:correlation_id => correlation_id_year2 })
    @mean_port2_year2 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year2 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year2 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year2 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year2 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year2[i,j] = correlation_inputs_port2_year2.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year2[j,i] = correlation_inputs_port2_year2.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year2 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 3 (PORT 2) ###########
    

    correlation_inputs_port2_year3 = CorrelationInput.all.where({:correlation_id => correlation_id_year3 })
    @mean_port2_year3 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year3 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year3 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year3 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year3 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year3[i,j] = correlation_inputs_port2_year3.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year3[j,i] = correlation_inputs_port2_year3.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year3 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 4 (PORT 2) ###########
    

    correlation_inputs_port2_year4 = CorrelationInput.all.where({:correlation_id => correlation_id_year4 })
    @mean_port2_year4 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year4 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year4 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year4 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year4 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year4[i,j] = correlation_inputs_port2_year4.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year4[j,i] = correlation_inputs_port2_year4.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year4 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 5 (PORT 2) ###########
    

    correlation_inputs_port2_year5 = CorrelationInput.all.where({:correlation_id => correlation_id_year5 })
    @mean_port2_year5 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year5 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year5 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year5 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year5 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year5[i,j] = correlation_inputs_port2_year5.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year5[j,i] = correlation_inputs_port2_year5.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year5 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 6 (PORT 2) ###########
    

    correlation_inputs_port2_year6 = CorrelationInput.all.where({:correlation_id => correlation_id_year6 })
    @mean_port2_year6 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year6 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year6 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year6 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year6 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year6[i,j] = correlation_inputs_port2_year6.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year6[j,i] = correlation_inputs_port2_year6.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year6 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 7 (PORT 2) ###########
    

    correlation_inputs_port2_year7 = CorrelationInput.all.where({:correlation_id => correlation_id_year7 })
    @mean_port2_year7 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year7 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year7 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year7 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year7 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year7[i,j] = correlation_inputs_port2_year7.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year7[j,i] = correlation_inputs_port2_year7.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year7 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 8 (PORT 2) ###########
    

    correlation_inputs_port2_year8 = CorrelationInput.all.where({:correlation_id => correlation_id_year8 })
    @mean_port2_year8 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year8 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year8 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year8 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year8 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year8[i,j] = correlation_inputs_port2_year8.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year8[j,i] = correlation_inputs_port2_year8.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year8 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 9 (PORT 2) ###########
    

    correlation_inputs_port2_year9 = CorrelationInput.all.where({:correlation_id => correlation_id_year9 })
    @mean_port2_year9 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year9 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year9 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year9 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year9 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year9[i,j] = correlation_inputs_port2_year9.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year9[j,i] = correlation_inputs_port2_year9.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year9 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 10 (PORT 2) ###########
    

    correlation_inputs_port2_year10 = CorrelationInput.all.where({:correlation_id => correlation_id_year10 })
    @mean_port2_year10 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year10 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year10 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year10 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year10 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year10[i,j] = correlation_inputs_port2_year10.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year10[j,i] = correlation_inputs_port2_year10.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year10 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 11 (PORT 2) ###########
    

    correlation_inputs_port2_year11 = CorrelationInput.all.where({:correlation_id => correlation_id_year11 })
    @mean_port2_year11 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year11 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year11 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year11 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year11 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year11[i,j] = correlation_inputs_port2_year11.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year11[j,i] = correlation_inputs_port2_year11.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year11 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 12 (PORT 2) ###########
    

    correlation_inputs_port2_year12 = CorrelationInput.all.where({:correlation_id => correlation_id_year12 })
    @mean_port2_year12 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year12 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year12 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year12 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year12 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year12[i,j] = correlation_inputs_port2_year12.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year12[j,i] = correlation_inputs_port2_year12.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year12 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 13 (PORT 2) ###########
    
    correlation_inputs_port2_year13 = CorrelationInput.all.where({:correlation_id => correlation_id_year13 })
    @mean_port2_year13 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year13 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year13 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year13 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year13 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year13[i,j] = correlation_inputs_port2_year13.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year13[j,i] = correlation_inputs_port2_year13.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year13 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 14 (PORT 2) ###########
    
    correlation_inputs_port2_year14 = CorrelationInput.all.where({:correlation_id => correlation_id_year14 })
    @mean_port2_year14 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year14 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year14 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year14 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year14 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year14[i,j] = correlation_inputs_port2_year14.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year14[j,i] = correlation_inputs_port2_year14.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year14 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 15 (PORT 2) ###########
    
    correlation_inputs_port2_year15 = CorrelationInput.all.where({:correlation_id => correlation_id_year15 })
    @mean_port2_year15 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year15 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year15 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year15 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year15 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year15[i,j] = correlation_inputs_port2_year15.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year15[j,i] = correlation_inputs_port2_year15.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year15 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 16 (PORT 2) ###########
    
    correlation_inputs_port2_year16 = CorrelationInput.all.where({:correlation_id => correlation_id_year16 })
    @mean_port2_year16 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year16 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year16 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year16 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year16 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year16[i,j] = correlation_inputs_port2_year16.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year16[j,i] = correlation_inputs_port2_year16.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year16 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 17 (PORT 2) ###########
    
    correlation_inputs_port2_year17 = CorrelationInput.all.where({:correlation_id => correlation_id_year17 })
    @mean_port2_year17 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year17 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year17 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year17 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year17 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year17[i,j] = correlation_inputs_port2_year17.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year17[j,i] = correlation_inputs_port2_year17.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year17 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 18 (PORT 2) ###########
    
    correlation_inputs_port2_year18 = CorrelationInput.all.where({:correlation_id => correlation_id_year18 })
    @mean_port2_year18 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year18 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year18 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year18 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year18 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year18[i,j] = correlation_inputs_port2_year18.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year18[j,i] = correlation_inputs_port2_year18.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year18 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 19 (PORT 2) ###########
    
    correlation_inputs_port2_year19 = CorrelationInput.all.where({:correlation_id => correlation_id_year19 })
    @mean_port2_year19 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year19 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year19 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year19 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year19 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year19[i,j] = correlation_inputs_port2_year19.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year19[j,i] = correlation_inputs_port2_year19.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year19 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 20 (PORT 2) ###########
    
    correlation_inputs_port2_year20 = CorrelationInput.all.where({:correlation_id => correlation_id_year20 })
    @mean_port2_year20 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year20 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year20 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year20 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year20 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year20[i,j] = correlation_inputs_port2_year20.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year20[j,i] = correlation_inputs_port2_year20.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year20 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 21 (PORT 2) ###########
    
    correlation_inputs_port2_year21 = CorrelationInput.all.where({:correlation_id => correlation_id_year21 })
    @mean_port2_year21 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year21 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year21 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year21 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year21 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year21[i,j] = correlation_inputs_port2_year21.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year21[j,i] = correlation_inputs_port2_year21.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year21 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 22 (PORT 2) ###########
    
    correlation_inputs_port2_year22 = CorrelationInput.all.where({:correlation_id => correlation_id_year22 })
    @mean_port2_year22 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year22 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year22 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year22 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year22 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year22[i,j] = correlation_inputs_port2_year22.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year22[j,i] = correlation_inputs_port2_year22.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year22 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 23 (PORT 2) ###########
    
    correlation_inputs_port2_year23 = CorrelationInput.all.where({:correlation_id => correlation_id_year23 })
    @mean_port2_year23 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year23 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year23 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year23 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year23 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year23[i,j] = correlation_inputs_port2_year23.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year23[j,i] = correlation_inputs_port2_year23.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year23 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 24 (PORT 2) ###########
    
    correlation_inputs_port2_year24 = CorrelationInput.all.where({:correlation_id => correlation_id_year24 })
    @mean_port2_year24 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year24 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year24 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year24 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year24 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year24[i,j] = correlation_inputs_port2_year24.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year24[j,i] = correlation_inputs_port2_year24.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year24 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 25 (PORT 2) ###########
    
    correlation_inputs_port2_year25 = CorrelationInput.all.where({:correlation_id => correlation_id_year25 })
    @mean_port2_year25 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year25 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year25 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year25 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year25 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year25[i,j] = correlation_inputs_port2_year25.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year25[j,i] = correlation_inputs_port2_year25.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year25 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 26 (PORT 2) ###########
    
    correlation_inputs_port2_year26 = CorrelationInput.all.where({:correlation_id => correlation_id_year26 })
    @mean_port2_year26 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year26 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year26 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year26 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year26 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year26[i,j] = correlation_inputs_port2_year26.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year26[j,i] = correlation_inputs_port2_year26.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year26 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 27 (PORT 2) ###########
    
    correlation_inputs_port2_year27 = CorrelationInput.all.where({:correlation_id => correlation_id_year27 })
    @mean_port2_year27 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year27 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year27 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year27 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year27 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year27[i,j] = correlation_inputs_port2_year27.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year27[j,i] = correlation_inputs_port2_year27.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year27 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 28 (PORT 2) ###########
    
    correlation_inputs_port2_year28 = CorrelationInput.all.where({:correlation_id => correlation_id_year28 })
    @mean_port2_year28 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year28 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year28 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year28 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year28 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year28[i,j] = correlation_inputs_port2_year28.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year28[j,i] = correlation_inputs_port2_year28.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year28 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 29 (PORT 2) ###########
    
    correlation_inputs_port2_year29 = CorrelationInput.all.where({:correlation_id => correlation_id_year29 })
    @mean_port2_year29 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year29 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year29 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year29 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year29 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year29[i,j] = correlation_inputs_port2_year29.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year29[j,i] = correlation_inputs_port2_year29.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year29 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 30 (PORT 2) ###########
    
    correlation_inputs_port2_year30 = CorrelationInput.all.where({:correlation_id => correlation_id_year30 })
    @mean_port2_year30 = Array.new(length_port2)
    for i in 0...length_port2
      @mean_port2_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).exp_ret
    end
    @std_dev_port2_year30 = Array.new(length_port2)
    for i in 0...length_port2
      @std_dev_port2_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).std_dev
    end
    @skew_port2_year30 = Array.new(length_port2)
    for i in 0...length_port2
      @skew_port2_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).skew
    end
    @kurt_port2_year30 = Array.new(length_port2)
    for i in 0...length_port2
      @kurt_port2_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).kurt
    end    
    # @correlation_port2_year30 = Matrix.build(length_port2) {1}
    # for i in 0...length_port2
    #   for j in 0...i
    #     @correlation_port2_year30[i,j] = correlation_inputs_port2_year30.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #     @correlation_port2_year30[j,i] = correlation_inputs_port2_year30.where(:asset_class1 => asset_class_port2[i]).where(:asset_class2 => asset_class_port2[j])[0].correl
    #   end
    # end
    @yields_port2_year30 = Array.new(length_port2)
    for i in 0...length_port2
      @yields_port2_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port2[i] }).at(0).yield.to_f/100
    end
    
  ######## YEAR 1 (PORT 3) ###########
    
    correlation_inputs_port3_year1 = CorrelationInput.all.where({:correlation_id => correlation_id_year1 })
    @mean_port3_year1 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year1 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year1 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year1 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    @correlation_port3_year1 = Matrix.build(length_port3) {1}
    for i in 0...length_port3
      for j in 0...i
        @correlation_port3_year1[i,j] = correlation_inputs_port3_year1.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
        @correlation_port3_year1[j,i] = correlation_inputs_port3_year1.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
      end
    end
    @yields_port3_year1 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end
    
     @correlation_port3_year2 = @correlation_port3_year1
     @correlation_port3_year3 = @correlation_port3_year1
     @correlation_port3_year4 = @correlation_port3_year1
     @correlation_port3_year5 = @correlation_port3_year1
     @correlation_port3_year6 = @correlation_port3_year1
     @correlation_port3_year7 = @correlation_port3_year1
     @correlation_port3_year8 = @correlation_port3_year1
     @correlation_port3_year9 = @correlation_port3_year1
     @correlation_port3_year10 = @correlation_port3_year1
     @correlation_port3_year11 = @correlation_port3_year1
     @correlation_port3_year12 = @correlation_port3_year1
     @correlation_port3_year13 = @correlation_port3_year1
     @correlation_port3_year14 = @correlation_port3_year1
     @correlation_port3_year15 = @correlation_port3_year1
     @correlation_port3_year16 = @correlation_port3_year1
     @correlation_port3_year17 = @correlation_port3_year1
     @correlation_port3_year18 = @correlation_port3_year1
     @correlation_port3_year19 = @correlation_port3_year1
     @correlation_port3_year20 = @correlation_port3_year1
     @correlation_port3_year21 = @correlation_port3_year1
     @correlation_port3_year22 = @correlation_port3_year1
     @correlation_port3_year23 = @correlation_port3_year1
     @correlation_port3_year24 = @correlation_port3_year1
     @correlation_port3_year25 = @correlation_port3_year1
     @correlation_port3_year26 = @correlation_port3_year1
     @correlation_port3_year27 = @correlation_port3_year1
     @correlation_port3_year28 = @correlation_port3_year1
     @correlation_port3_year29 = @correlation_port3_year1
     @correlation_port3_year30 = @correlation_port3_year1

    ######## YEAR 2 (PORT 3) ###########
    
    correlation_inputs_port3_year2 = CorrelationInput.all.where({:correlation_id => correlation_id_year2 })
    @mean_port3_year2 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year2 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year2 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year2 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year2 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year2[i,j] = correlation_inputs_port3_year2.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year2[j,i] = correlation_inputs_port3_year2.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year2 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 3 (PORT 3) ###########
    
    correlation_inputs_port3_year3 = CorrelationInput.all.where({:correlation_id => correlation_id_year3 })
    @mean_port3_year3 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year3 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year3 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year3 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year3 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year3[i,j] = correlation_inputs_port3_year3.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year3[j,i] = correlation_inputs_port3_year3.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year3 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 4 (PORT 3) ###########
    
    correlation_inputs_port3_year4 = CorrelationInput.all.where({:correlation_id => correlation_id_year4 })
    @mean_port3_year4 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year4 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year4 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year4 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year4 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year4[i,j] = correlation_inputs_port3_year4.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year4[j,i] = correlation_inputs_port3_year4.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year4 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 5 (PORT 3) ###########
    
    correlation_inputs_port3_year5 = CorrelationInput.all.where({:correlation_id => correlation_id_year5 })
    @mean_port3_year5 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year5 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year5 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year5 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year5 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year5[i,j] = correlation_inputs_port3_year5.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year5[j,i] = correlation_inputs_port3_year5.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year5 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 6 (PORT 3) ###########
    
    correlation_inputs_port3_year6 = CorrelationInput.all.where({:correlation_id => correlation_id_year6 })
    @mean_port3_year6 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year6 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year6 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year6 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year6 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year6[i,j] = correlation_inputs_port3_year6.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year6[j,i] = correlation_inputs_port3_year6.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year6 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 7 (PORT 3) ###########
    
    correlation_inputs_port3_year7 = CorrelationInput.all.where({:correlation_id => correlation_id_year7 })
    @mean_port3_year7 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year7 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year7 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year7 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year7 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year7[i,j] = correlation_inputs_port3_year7.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year7[j,i] = correlation_inputs_port3_year7.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year7 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 8 (PORT 3) ###########
    
    correlation_inputs_port3_year8 = CorrelationInput.all.where({:correlation_id => correlation_id_year8 })
    @mean_port3_year8 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year8 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year8 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year8 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year8 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year8[i,j] = correlation_inputs_port3_year8.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year8[j,i] = correlation_inputs_port3_year8.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year8 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 9 (PORT 3) ###########
    
    correlation_inputs_port3_year9 = CorrelationInput.all.where({:correlation_id => correlation_id_year9 })
    @mean_port3_year9 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year9 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year9 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year9 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year9 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year9[i,j] = correlation_inputs_port3_year9.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year9[j,i] = correlation_inputs_port3_year9.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year9 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 10 (PORT 3) ###########
    
    correlation_inputs_port3_year10 = CorrelationInput.all.where({:correlation_id => correlation_id_year10 })
    @mean_port3_year10 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year10 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year10 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year10 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year10 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year10[i,j] = correlation_inputs_port3_year10.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year10[j,i] = correlation_inputs_port3_year10.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year10 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 11 (PORT 3) ###########
    
    correlation_inputs_port3_year11 = CorrelationInput.all.where({:correlation_id => correlation_id_year11 })
    @mean_port3_year11 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year11 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year11 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year11 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year11 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year11[i,j] = correlation_inputs_port3_year11.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year11[j,i] = correlation_inputs_port3_year11.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year11 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 12 (PORT 3) ###########
    
    correlation_inputs_port3_year12 = CorrelationInput.all.where({:correlation_id => correlation_id_year12 })
    @mean_port3_year12 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year12 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year12 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year12 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year12 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year12[i,j] = correlation_inputs_port3_year12.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year12[j,i] = correlation_inputs_port3_year12.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year12 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 13 (PORT 3) ###########
    
    correlation_inputs_port3_year13 = CorrelationInput.all.where({:correlation_id => correlation_id_year13 })
    @mean_port3_year13 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year13 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year13 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year13 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year13 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year13[i,j] = correlation_inputs_port3_year13.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year13[j,i] = correlation_inputs_port3_year13.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year13 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 14 (PORT 3) ###########
    
    correlation_inputs_port3_year14 = CorrelationInput.all.where({:correlation_id => correlation_id_year14 })
    @mean_port3_year14 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year14 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year14 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year14 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year14 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year14[i,j] = correlation_inputs_port3_year14.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year14[j,i] = correlation_inputs_port3_year14.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year14 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 15 (PORT 3) ###########
    
    correlation_inputs_port3_year15 = CorrelationInput.all.where({:correlation_id => correlation_id_year15 })
    @mean_port3_year15 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year15 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year15 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year15 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year15 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year15[i,j] = correlation_inputs_port3_year15.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year15[j,i] = correlation_inputs_port3_year15.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year15 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 16 (PORT 3) ###########
    
    correlation_inputs_port3_year16 = CorrelationInput.all.where({:correlation_id => correlation_id_year16 })
    @mean_port3_year16 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year16 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year16 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year16 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year16 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year16[i,j] = correlation_inputs_port3_year16.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year16[j,i] = correlation_inputs_port3_year16.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year16 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 17 (PORT 3) ###########
    
    correlation_inputs_port3_year17 = CorrelationInput.all.where({:correlation_id => correlation_id_year17 })
    @mean_port3_year17 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year17 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year17 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year17 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year17 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year17[i,j] = correlation_inputs_port3_year17.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year17[j,i] = correlation_inputs_port3_year17.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year17 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 18 (PORT 3) ###########
    
    correlation_inputs_port3_year18 = CorrelationInput.all.where({:correlation_id => correlation_id_year18 })
    @mean_port3_year18 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year18 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year18 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year18 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year18 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year18[i,j] = correlation_inputs_port3_year18.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year18[j,i] = correlation_inputs_port3_year18.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year18 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 19 (PORT 3) ###########
    
    correlation_inputs_port3_year19 = CorrelationInput.all.where({:correlation_id => correlation_id_year19 })
    @mean_port3_year19 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year19 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year19 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year19 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year19 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year19[i,j] = correlation_inputs_port3_year19.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year19[j,i] = correlation_inputs_port3_year19.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year19 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 20 (PORT 3) ###########
    
    correlation_inputs_port3_year20 = CorrelationInput.all.where({:correlation_id => correlation_id_year20 })
    @mean_port3_year20 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year20 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year20 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year20 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year20 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year20[i,j] = correlation_inputs_port3_year20.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year20[j,i] = correlation_inputs_port3_year20.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year20 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 21 (PORT 3) ###########
    
    correlation_inputs_port3_year21 = CorrelationInput.all.where({:correlation_id => correlation_id_year21 })
    @mean_port3_year21 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year21 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year21 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year21 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year21 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year21[i,j] = correlation_inputs_port3_year21.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year21[j,i] = correlation_inputs_port3_year21.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year21 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 22 (PORT 3) ###########
    
    correlation_inputs_port3_year22 = CorrelationInput.all.where({:correlation_id => correlation_id_year22 })
    @mean_port3_year22 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year22 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year22 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year22 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year22 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year22[i,j] = correlation_inputs_port3_year22.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year22[j,i] = correlation_inputs_port3_year22.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year22 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 23 (PORT 3) ###########
    
    correlation_inputs_port3_year23 = CorrelationInput.all.where({:correlation_id => correlation_id_year23 })
    @mean_port3_year23 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year23 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year23 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year23 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year23 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year23[i,j] = correlation_inputs_port3_year23.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year23[j,i] = correlation_inputs_port3_year23.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year23 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 24 (PORT 3) ###########
    
    correlation_inputs_port3_year24 = CorrelationInput.all.where({:correlation_id => correlation_id_year24 })
    @mean_port3_year24 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year24 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year24 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year24 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year24 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year24[i,j] = correlation_inputs_port3_year24.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year24[j,i] = correlation_inputs_port3_year24.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year24 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 25 (PORT 3) ###########
    
    correlation_inputs_port3_year25 = CorrelationInput.all.where({:correlation_id => correlation_id_year25 })
    @mean_port3_year25 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year25 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year25 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year25 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year25 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year25[i,j] = correlation_inputs_port3_year25.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year25[j,i] = correlation_inputs_port3_year25.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year25 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 26 (PORT 3) ###########
    
    correlation_inputs_port3_year26 = CorrelationInput.all.where({:correlation_id => correlation_id_year26 })
    @mean_port3_year26 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year26 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year26 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year26 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year26 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year26[i,j] = correlation_inputs_port3_year26.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year26[j,i] = correlation_inputs_port3_year26.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year26 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 27 (PORT 3) ###########
    
    correlation_inputs_port3_year27 = CorrelationInput.all.where({:correlation_id => correlation_id_year27 })
    @mean_port3_year27 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year27 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year27 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year27 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year27 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year27[i,j] = correlation_inputs_port3_year27.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year27[j,i] = correlation_inputs_port3_year27.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year27 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 28 (PORT 3) ###########
    
    correlation_inputs_port3_year28 = CorrelationInput.all.where({:correlation_id => correlation_id_year28 })
    @mean_port3_year28 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year28 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year28 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year28 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year28 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year28[i,j] = correlation_inputs_port3_year28.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year28[j,i] = correlation_inputs_port3_year28.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year28 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 29 (PORT 3) ###########
    
    correlation_inputs_port3_year29 = CorrelationInput.all.where({:correlation_id => correlation_id_year29 })
    @mean_port3_year29 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year29 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year29 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year29 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year29 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year29[i,j] = correlation_inputs_port3_year29.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year29[j,i] = correlation_inputs_port3_year29.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year29 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 30 (PORT 3) ###########
    
    correlation_inputs_port3_year30 = CorrelationInput.all.where({:correlation_id => correlation_id_year30 })
    @mean_port3_year30 = Array.new(length_port3)
    for i in 0...length_port3
      @mean_port3_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).exp_ret
    end
    @std_dev_port3_year30 = Array.new(length_port3)
    for i in 0...length_port3
      @std_dev_port3_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).std_dev
    end
    @skew_port3_year30 = Array.new(length_port3)
    for i in 0...length_port3
      @skew_port3_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).skew
    end
    @kurt_port3_year30 = Array.new(length_port3)
    for i in 0...length_port3
      @kurt_port3_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).kurt
    end    
    # @correlation_port3_year30 = Matrix.build(length_port3) {1}
    # for i in 0...length_port3
    #   for j in 0...i
    #     @correlation_port3_year30[i,j] = correlation_inputs_port3_year30.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #     @correlation_port3_year30[j,i] = correlation_inputs_port3_year30.where(:asset_class1 => asset_class_port3[i]).where(:asset_class2 => asset_class_port3[j])[0].correl
    #   end
    # end
    @yields_port3_year30 = Array.new(length_port3)
    for i in 0...length_port3
      @yields_port3_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port3[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 1 (PORT 4) ###########
    
    correlation_inputs_port4_year1 = CorrelationInput.all.where({:correlation_id => correlation_id_year1 })
    @mean_port4_year1 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year1 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year1 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year1 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    @correlation_port4_year1 = Matrix.build(length_port4) {1}
    for i in 0...length_port4
      for j in 0...i
        @correlation_port4_year1[i,j] = correlation_inputs_port4_year1.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
        @correlation_port4_year1[j,i] = correlation_inputs_port4_year1.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
      end
    end
    @yields_port4_year1 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year1[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year1_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

     @correlation_port4_year2 = @correlation_port4_year1
     @correlation_port4_year3 = @correlation_port4_year1
     @correlation_port4_year4 = @correlation_port4_year1
     @correlation_port4_year5 = @correlation_port4_year1
     @correlation_port4_year6 = @correlation_port4_year1
     @correlation_port4_year7 = @correlation_port4_year1
     @correlation_port4_year8 = @correlation_port4_year1
     @correlation_port4_year9 = @correlation_port4_year1
     @correlation_port4_year10 = @correlation_port4_year1
     @correlation_port4_year11 = @correlation_port4_year1
     @correlation_port4_year12 = @correlation_port4_year1
     @correlation_port4_year13 = @correlation_port4_year1
     @correlation_port4_year14 = @correlation_port4_year1
     @correlation_port4_year15 = @correlation_port4_year1
     @correlation_port4_year16 = @correlation_port4_year1
     @correlation_port4_year17 = @correlation_port4_year1
     @correlation_port4_year18 = @correlation_port4_year1
     @correlation_port4_year19 = @correlation_port4_year1
     @correlation_port4_year20 = @correlation_port4_year1
     @correlation_port4_year21 = @correlation_port4_year1
     @correlation_port4_year22 = @correlation_port4_year1
     @correlation_port4_year23 = @correlation_port4_year1
     @correlation_port4_year24 = @correlation_port4_year1
     @correlation_port4_year25 = @correlation_port4_year1
     @correlation_port4_year26 = @correlation_port4_year1
     @correlation_port4_year27 = @correlation_port4_year1
     @correlation_port4_year28 = @correlation_port4_year1
     @correlation_port4_year29 = @correlation_port4_year1
     @correlation_port4_year30 = @correlation_port4_year1
    
    ######## YEAR 2 (PORT 4) ###########
    
    correlation_inputs_port4_year2 = CorrelationInput.all.where({:correlation_id => correlation_id_year2 })
    @mean_port4_year2 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year2 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year2 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year2 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year2 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year2[i,j] = correlation_inputs_port4_year2.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year2[j,i] = correlation_inputs_port4_year2.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year2 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 3 (PORT 4) ###########
    
    correlation_inputs_port4_year3 = CorrelationInput.all.where({:correlation_id => correlation_id_year3 })
    @mean_port4_year3 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year3 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year3 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year3 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year3 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year3[i,j] = correlation_inputs_port4_year3.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year3[j,i] = correlation_inputs_port4_year3.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year3 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 4 (PORT 4) ###########
    
    correlation_inputs_port4_year4 = CorrelationInput.all.where({:correlation_id => correlation_id_year4 })
    @mean_port4_year4 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year4 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year4 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year4 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year4 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year4[i,j] = correlation_inputs_port4_year4.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year4[j,i] = correlation_inputs_port4_year4.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year4 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year4[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year4_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 5 (PORT 4) ###########
    
    correlation_inputs_port4_year5 = CorrelationInput.all.where({:correlation_id => correlation_id_year5 })
    @mean_port4_year5 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year5 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year5 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year5 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year5 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year5[i,j] = correlation_inputs_port4_year5.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year5[j,i] = correlation_inputs_port4_year5.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year5 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year5[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year5_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 6 (PORT 4) ###########
    
    correlation_inputs_port4_year6 = CorrelationInput.all.where({:correlation_id => correlation_id_year6 })
    @mean_port4_year6 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year6 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year6 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year6 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year6 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year6[i,j] = correlation_inputs_port4_year6.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year6[j,i] = correlation_inputs_port4_year6.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year6 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year6[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year6_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 7 (PORT 4) ###########
    
    correlation_inputs_port4_year7 = CorrelationInput.all.where({:correlation_id => correlation_id_year7 })
    @mean_port4_year7 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year7 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year7 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year7 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year7 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year7[i,j] = correlation_inputs_port4_year7.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year7[j,i] = correlation_inputs_port4_year7.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year7 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year7[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year7_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 8 (PORT 4) ###########
    
    correlation_inputs_port4_year8 = CorrelationInput.all.where({:correlation_id => correlation_id_year8 })
    @mean_port4_year8 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year8 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year8 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year8 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year8 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year8[i,j] = correlation_inputs_port4_year8.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year8[j,i] = correlation_inputs_port4_year8.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year8 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year8[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year8_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 9 (PORT 4) ###########
    
    correlation_inputs_port4_year9 = CorrelationInput.all.where({:correlation_id => correlation_id_year9 })
    @mean_port4_year9 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year9 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year9 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year9 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year9 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year9[i,j] = correlation_inputs_port4_year9.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year9[j,i] = correlation_inputs_port4_year9.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year9 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year9[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year9_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 10 (PORT 4) ###########
    
    correlation_inputs_port4_year10 = CorrelationInput.all.where({:correlation_id => correlation_id_year10 })
    @mean_port4_year10 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year10 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year10 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year10 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year10 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year10[i,j] = correlation_inputs_port4_year10.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year10[j,i] = correlation_inputs_port4_year10.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year10 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year10[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year10_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 11 (PORT 4) ###########
    
    correlation_inputs_port4_year11 = CorrelationInput.all.where({:correlation_id => correlation_id_year11 })
    @mean_port4_year11 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year11 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year11 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year11 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year11 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year11[i,j] = correlation_inputs_port4_year11.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year11[j,i] = correlation_inputs_port4_year11.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year11 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year11[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year11_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 12 (PORT 4) ###########
    
    correlation_inputs_port4_year12 = CorrelationInput.all.where({:correlation_id => correlation_id_year12 })
    @mean_port4_year12 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year12 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year12 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year12 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year12 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year12[i,j] = correlation_inputs_port4_year12.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year12[j,i] = correlation_inputs_port4_year12.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year12 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year12[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year12_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 13 (PORT 4) ###########
    
    correlation_inputs_port4_year13 = CorrelationInput.all.where({:correlation_id => correlation_id_year13 })
    @mean_port4_year13 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year13 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year13 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year13 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year13 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year13[i,j] = correlation_inputs_port4_year13.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year13[j,i] = correlation_inputs_port4_year13.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year13 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year13[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year13_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 14 (PORT 4) ###########
    
    correlation_inputs_port4_year14 = CorrelationInput.all.where({:correlation_id => correlation_id_year14 })
    @mean_port4_year14 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year14 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year14 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year14 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year14 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year14[i,j] = correlation_inputs_port4_year14.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year14[j,i] = correlation_inputs_port4_year14.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year14 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year14[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year14_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 15 (PORT 4) ###########
    
    correlation_inputs_port4_year15 = CorrelationInput.all.where({:correlation_id => correlation_id_year15 })
    @mean_port4_year15 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year15 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year15 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year15 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year15 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year15[i,j] = correlation_inputs_port4_year15.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year15[j,i] = correlation_inputs_port4_year15.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year15 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year15[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year15_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 16 (PORT 4) ###########
    
    correlation_inputs_port4_year16 = CorrelationInput.all.where({:correlation_id => correlation_id_year16 })
    @mean_port4_year16 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year16 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year16 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year16 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year16 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year16[i,j] = correlation_inputs_port4_year16.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year16[j,i] = correlation_inputs_port4_year16.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year16 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year16[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year16_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 17 (PORT 4) ###########
    
    correlation_inputs_port4_year17 = CorrelationInput.all.where({:correlation_id => correlation_id_year17 })
    @mean_port4_year17 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year17 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year17 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year17 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year17 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year17[i,j] = correlation_inputs_port4_year17.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year17[j,i] = correlation_inputs_port4_year17.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year17 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year17[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year17_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 18 (PORT 4) ###########
    
    correlation_inputs_port4_year18 = CorrelationInput.all.where({:correlation_id => correlation_id_year18 })
    @mean_port4_year18 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year18 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year18 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year18 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year18 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year18[i,j] = correlation_inputs_port4_year18.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year18[j,i] = correlation_inputs_port4_year18.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year18 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year18[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year18_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 19 (PORT 4) ###########
    
    correlation_inputs_port4_year19 = CorrelationInput.all.where({:correlation_id => correlation_id_year19 })
    @mean_port4_year19 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year19 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year19 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year19 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year19 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year19[i,j] = correlation_inputs_port4_year19.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year19[j,i] = correlation_inputs_port4_year19.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year19 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year19[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year19_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 20 (PORT 4) ###########
    
    correlation_inputs_port4_year20 = CorrelationInput.all.where({:correlation_id => correlation_id_year20 })
    @mean_port4_year20 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year20 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year20 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year20 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year20 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year20[i,j] = correlation_inputs_port4_year20.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year20[j,i] = correlation_inputs_port4_year20.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year20 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year20[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year20_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 21 (PORT 4) ###########
    
    correlation_inputs_port4_year21 = CorrelationInput.all.where({:correlation_id => correlation_id_year21 })
    @mean_port4_year21 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year21 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year21 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year21 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year21 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year21[i,j] = correlation_inputs_port4_year21.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year21[j,i] = correlation_inputs_port4_year21.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year21 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year21[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year21_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end
    
    ######## YEAR 22 (PORT 4) ###########
    
    correlation_inputs_port4_year22 = CorrelationInput.all.where({:correlation_id => correlation_id_year22 })
    @mean_port4_year22 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year22 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year22 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year22 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year22 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year22[i,j] = correlation_inputs_port4_year22.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year22[j,i] = correlation_inputs_port4_year22.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year22 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year22[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year22_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 23 (PORT 4) ###########
    
    correlation_inputs_port4_year23 = CorrelationInput.all.where({:correlation_id => correlation_id_year23 })
    @mean_port4_year23 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year23 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year23 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year23 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year23 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year23[i,j] = correlation_inputs_port4_year23.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year23[j,i] = correlation_inputs_port4_year23.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year23 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year23[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year23_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 24 (PORT 4) ###########
    
    correlation_inputs_port4_year24 = CorrelationInput.all.where({:correlation_id => correlation_id_year24 })
    @mean_port4_year24 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year24 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year24 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year24 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year24 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year24[i,j] = correlation_inputs_port4_year24.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year24[j,i] = correlation_inputs_port4_year24.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year24 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year24[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year24_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 25 (PORT 4) ###########
    
    correlation_inputs_port4_year25 = CorrelationInput.all.where({:correlation_id => correlation_id_year25 })
    @mean_port4_year25 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year25 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year25 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year25 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year25 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year25[i,j] = correlation_inputs_port4_year25.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year25[j,i] = correlation_inputs_port4_year25.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year25 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year25[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year25_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 26 (PORT 4) ###########
    
    correlation_inputs_port4_year26 = CorrelationInput.all.where({:correlation_id => correlation_id_year26 })
    @mean_port4_year26 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year26 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year26 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year26 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year26 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year26[i,j] = correlation_inputs_port4_year26.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year26[j,i] = correlation_inputs_port4_year26.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year26 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year26[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year26_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 27 (PORT 4) ###########
    
    correlation_inputs_port4_year27 = CorrelationInput.all.where({:correlation_id => correlation_id_year27 })
    @mean_port4_year27 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year27 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year27 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year27 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year27 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year27[i,j] = correlation_inputs_port4_year27.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year27[j,i] = correlation_inputs_port4_year27.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year27 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year27[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year27_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 28 (PORT 4) ###########
    
    correlation_inputs_port4_year28 = CorrelationInput.all.where({:correlation_id => correlation_id_year28 })
    @mean_port4_year28 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year28 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year28 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year28 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year28 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year28[i,j] = correlation_inputs_port4_year28.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year28[j,i] = correlation_inputs_port4_year28.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year28 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year28[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year28_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 29 (PORT 4) ###########
    
    correlation_inputs_port4_year29 = CorrelationInput.all.where({:correlation_id => correlation_id_year29 })
    @mean_port4_year29 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year29 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year29 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year29 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year29 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year29[i,j] = correlation_inputs_port4_year29.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year29[j,i] = correlation_inputs_port4_year29.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year29 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year29[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year29_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 30 (PORT 4) ###########
    
    correlation_inputs_port4_year30 = CorrelationInput.all.where({:correlation_id => correlation_id_year30 })
    @mean_port4_year30 = Array.new(length_port4)
    for i in 0...length_port4
      @mean_port4_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).exp_ret
    end
    @std_dev_port4_year30 = Array.new(length_port4)
    for i in 0...length_port4
      @std_dev_port4_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).std_dev
    end
    @skew_port4_year30 = Array.new(length_port4)
    for i in 0...length_port4
      @skew_port4_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).skew
    end
    @kurt_port4_year30 = Array.new(length_port4)
    for i in 0...length_port4
      @kurt_port4_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).kurt
    end    
    # @correlation_port4_year30 = Matrix.build(length_port4) {1}
    # for i in 0...length_port4
    #   for j in 0...i
    #     @correlation_port4_year30[i,j] = correlation_inputs_port4_year30.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #     @correlation_port4_year30[j,i] = correlation_inputs_port4_year30.where(:asset_class1 => asset_class_port4[i]).where(:asset_class2 => asset_class_port4[j])[0].correl
    #   end
    # end
    @yields_port4_year30 = Array.new(length_port4)
    for i in 0...length_port4
      @yields_port4_year30[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year30_cma_id }).where({:asset_class_id => asset_class_port4[i] }).at(0).yield.to_f/100
    end

  
    @starting_value = @the_forecast_input.starting_value
    @income = [@the_forecast_input.year1_cf , @the_forecast_input.year2_cf , @the_forecast_input.year3_cf , @the_forecast_input.year4_cf , @the_forecast_input.year5_cf , @the_forecast_input.year6_cf , @the_forecast_input.year7_cf , @the_forecast_input.year8_cf , @the_forecast_input.year9_cf ,  @the_forecast_input.year10_cf, 
                @the_forecast_input.year11_cf , @the_forecast_input.year12_cf , @the_forecast_input.year13_cf , @the_forecast_input.year14_cf , @the_forecast_input.year15_cf , @the_forecast_input.year16_cf , @the_forecast_input.year17_cf , @the_forecast_input.year18_cf , @the_forecast_input.year19_cf ,  @the_forecast_input.year20_cf,
                @the_forecast_input.year21_cf , @the_forecast_input.year22_cf , @the_forecast_input.year23_cf , @the_forecast_input.year24_cf , @the_forecast_input.year25_cf , @the_forecast_input.year26_cf , @the_forecast_input.year27_cf , @the_forecast_input.year28_cf , @the_forecast_input.year29_cf ,  @the_forecast_input.year30_cf]

    @expense = [@the_forecast_input.year1_exp , @the_forecast_input.year2_exp , @the_forecast_input.year3_exp , @the_forecast_input.year4_exp , @the_forecast_input.year5_exp , @the_forecast_input.year6_exp , @the_forecast_input.year7_exp , @the_forecast_input.year8_exp , @the_forecast_input.year9_exp ,  @the_forecast_input.year10_exp, 
                @the_forecast_input.year11_exp , @the_forecast_input.year12_exp , @the_forecast_input.year13_exp , @the_forecast_input.year14_exp , @the_forecast_input.year15_exp , @the_forecast_input.year16_exp , @the_forecast_input.year17_exp , @the_forecast_input.year18_exp , @the_forecast_input.year19_exp ,  @the_forecast_input.year20_exp,
                @the_forecast_input.year21_exp , @the_forecast_input.year22_exp , @the_forecast_input.year23_exp , @the_forecast_input.year24_exp , @the_forecast_input.year25_exp , @the_forecast_input.year26_exp , @the_forecast_input.year27_exp , @the_forecast_input.year28_exp , @the_forecast_input.year29_exp ,  @the_forecast_input.year30_exp]
 
    
    @starting_value = @starting_value.to_json
    @income = @income.to_json
    @expense = @expense.to_json   

    @weights_port1 = @weights_port1.to_json
    @weights_port2 = @weights_port2.to_json
    @weights_port3 = @weights_port3.to_json
    @weights_port4 = @weights_port4.to_json
    # @weights_port5 = @weights_port5.to_json
   

#### PORT 1 ####
    @mean_port1_year1 = @mean_port1_year1.to_json
    @std_dev_port1_year1 = @std_dev_port1_year1.to_json
    @skew_port1_year1 = @skew_port1_year1.to_json
    @kurt_port1_year1 = @kurt_port1_year1.to_json
    @correlation_port1_year1 = @correlation_port1_year1.to_json
    @yields_port1_year1 = @yields_port1_year1.to_json

    @mean_port1_year2 = @mean_port1_year2.to_json
    @std_dev_port1_year2 = @std_dev_port1_year2.to_json
    @skew_port1_year2 = @skew_port1_year2.to_json
    @kurt_port1_year2 = @kurt_port1_year2.to_json
    @correlation_port1_year2 = @correlation_port1_year2.to_json
    @yields_port1_year2 = @yields_port1_year2.to_json

    @mean_port1_year3 = @mean_port1_year3.to_json
    @std_dev_port1_year3 = @std_dev_port1_year3.to_json
    @skew_port1_year3 = @skew_port1_year3.to_json
    @kurt_port1_year3 = @kurt_port1_year3.to_json
    @correlation_port1_year3 = @correlation_port1_year3.to_json
    @yields_port1_year3 = @yields_port1_year3.to_json
    
    @mean_port1_year4 = @mean_port1_year4.to_json
    @std_dev_port1_year4 = @std_dev_port1_year4.to_json
    @skew_port1_year4 = @skew_port1_year4.to_json
    @kurt_port1_year4 = @kurt_port1_year4.to_json
    @correlation_port1_year4 = @correlation_port1_year4.to_json
    @yields_port1_year4 = @yields_port1_year4.to_json
    
    @mean_port1_year5 = @mean_port1_year5.to_json
    @std_dev_port1_year5 = @std_dev_port1_year5.to_json
    @skew_port1_year5 = @skew_port1_year5.to_json
    @kurt_port1_year5 = @kurt_port1_year5.to_json
    @correlation_port1_year5 = @correlation_port1_year5.to_json
    @yields_port1_year5 = @yields_port1_year5.to_json
    
    @mean_port1_year6 = @mean_port1_year6.to_json
    @std_dev_port1_year6 = @std_dev_port1_year6.to_json
    @skew_port1_year6 = @skew_port1_year6.to_json
    @kurt_port1_year6 = @kurt_port1_year6.to_json
    @correlation_port1_year6 = @correlation_port1_year6.to_json
    @yields_port1_year6 = @yields_port1_year6.to_json
    
    @mean_port1_year7 = @mean_port1_year7.to_json
    @std_dev_port1_year7 = @std_dev_port1_year7.to_json
    @skew_port1_year7 = @skew_port1_year7.to_json
    @kurt_port1_year7 = @kurt_port1_year7.to_json
    @correlation_port1_year7 = @correlation_port1_year7.to_json
    @yields_port1_year7 = @yields_port1_year7.to_json
    
    @mean_port1_year8 = @mean_port1_year8.to_json
    @std_dev_port1_year8 = @std_dev_port1_year8.to_json
    @skew_port1_year8 = @skew_port1_year8.to_json
    @kurt_port1_year8 = @kurt_port1_year8.to_json
    @correlation_port1_year8 = @correlation_port1_year8.to_json
    @yields_port1_year8 = @yields_port1_year8.to_json
    
    @mean_port1_year9 = @mean_port1_year9.to_json
    @std_dev_port1_year9 = @std_dev_port1_year9.to_json
    @skew_port1_year9 = @skew_port1_year9.to_json
    @kurt_port1_year9 = @kurt_port1_year9.to_json
    @correlation_port1_year9 = @correlation_port1_year9.to_json
    @yields_port1_year9 = @yields_port1_year9.to_json
    
    @mean_port1_year10 = @mean_port1_year10.to_json
    @std_dev_port1_year10 = @std_dev_port1_year10.to_json
    @skew_port1_year10 = @skew_port1_year10.to_json
    @kurt_port1_year10 = @kurt_port1_year10.to_json
    @correlation_port1_year10 = @correlation_port1_year10.to_json
    @yields_port1_year10 = @yields_port1_year10.to_json
    
    
    @mean_port1_year11 = @mean_port1_year11.to_json
    @std_dev_port1_year11 = @std_dev_port1_year11.to_json
    @skew_port1_year11 = @skew_port1_year11.to_json
    @kurt_port1_year11 = @kurt_port1_year11.to_json
    @correlation_port1_year11 = @correlation_port1_year11.to_json
    @yields_port1_year11 = @yields_port1_year11.to_json

    @mean_port1_year12 = @mean_port1_year12.to_json
    @std_dev_port1_year12 = @std_dev_port1_year12.to_json
    @skew_port1_year12 = @skew_port1_year12.to_json
    @kurt_port1_year12 = @kurt_port1_year12.to_json
    @correlation_port1_year12 = @correlation_port1_year12.to_json
    @yields_port1_year12 = @yields_port1_year12.to_json

    @mean_port1_year13 = @mean_port1_year13.to_json
    @std_dev_port1_year13 = @std_dev_port1_year13.to_json
    @skew_port1_year13 = @skew_port1_year13.to_json
    @kurt_port1_year13 = @kurt_port1_year13.to_json
    @correlation_port1_year13 = @correlation_port1_year13.to_json
    @yields_port1_year13 = @yields_port1_year13.to_json
    
    @mean_port1_year14 = @mean_port1_year14.to_json
    @std_dev_port1_year14 = @std_dev_port1_year14.to_json
    @skew_port1_year14 = @skew_port1_year14.to_json
    @kurt_port1_year14 = @kurt_port1_year14.to_json
    @correlation_port1_year14 = @correlation_port1_year14.to_json
    @yields_port1_year14 = @yields_port1_year14.to_json
    
    @mean_port1_year15 = @mean_port1_year15.to_json
    @std_dev_port1_year15 = @std_dev_port1_year15.to_json
    @skew_port1_year15 = @skew_port1_year15.to_json
    @kurt_port1_year15 = @kurt_port1_year15.to_json
    @correlation_port1_year15 = @correlation_port1_year15.to_json
    @yields_port1_year15 = @yields_port1_year15.to_json
    
    @mean_port1_year16 = @mean_port1_year16.to_json
    @std_dev_port1_year16 = @std_dev_port1_year16.to_json
    @skew_port1_year16 = @skew_port1_year16.to_json
    @kurt_port1_year16 = @kurt_port1_year16.to_json
    @correlation_port1_year16 = @correlation_port1_year16.to_json
    @yields_port1_year16 = @yields_port1_year16.to_json
    
    @mean_port1_year17 = @mean_port1_year17.to_json
    @std_dev_port1_year17 = @std_dev_port1_year17.to_json
    @skew_port1_year17 = @skew_port1_year17.to_json
    @kurt_port1_year17 = @kurt_port1_year17.to_json
    @correlation_port1_year17 = @correlation_port1_year17.to_json
    @yields_port1_year17 = @yields_port1_year17.to_json
    
    @mean_port1_year18 = @mean_port1_year18.to_json
    @std_dev_port1_year18 = @std_dev_port1_year18.to_json
    @skew_port1_year18 = @skew_port1_year18.to_json
    @kurt_port1_year18 = @kurt_port1_year18.to_json
    @correlation_port1_year18 = @correlation_port1_year18.to_json
    @yields_port1_year18 = @yields_port1_year18.to_json
    
    @mean_port1_year19 = @mean_port1_year19.to_json
    @std_dev_port1_year19 = @std_dev_port1_year19.to_json
    @skew_port1_year19 = @skew_port1_year19.to_json
    @kurt_port1_year19 = @kurt_port1_year19.to_json
    @correlation_port1_year19 = @correlation_port1_year19.to_json
    @yields_port1_year19 = @yields_port1_year19.to_json
    
    @mean_port1_year20 = @mean_port1_year20.to_json
    @std_dev_port1_year20 = @std_dev_port1_year20.to_json
    @skew_port1_year20 = @skew_port1_year20.to_json
    @kurt_port1_year20 = @kurt_port1_year20.to_json
    @correlation_port1_year20 = @correlation_port1_year20.to_json
    @yields_port1_year20 = @yields_port1_year20.to_json
    
    @mean_port1_year21 = @mean_port1_year21.to_json
    @std_dev_port1_year21 = @std_dev_port1_year21.to_json
    @skew_port1_year21 = @skew_port1_year21.to_json
    @kurt_port1_year21 = @kurt_port1_year21.to_json
    @correlation_port1_year21 = @correlation_port1_year21.to_json
    @yields_port1_year21 = @yields_port1_year21.to_json

    @mean_port1_year22 = @mean_port1_year22.to_json
    @std_dev_port1_year22 = @std_dev_port1_year22.to_json
    @skew_port1_year22 = @skew_port1_year22.to_json
    @kurt_port1_year22 = @kurt_port1_year22.to_json
    @correlation_port1_year22 = @correlation_port1_year22.to_json
    @yields_port1_year22 = @yields_port1_year22.to_json

    @mean_port1_year23 = @mean_port1_year23.to_json
    @std_dev_port1_year23 = @std_dev_port1_year23.to_json
    @skew_port1_year23 = @skew_port1_year23.to_json
    @kurt_port1_year23 = @kurt_port1_year23.to_json
    @correlation_port1_year23 = @correlation_port1_year23.to_json
    @yields_port1_year23 = @yields_port1_year23.to_json
    
    @mean_port1_year24 = @mean_port1_year24.to_json
    @std_dev_port1_year24 = @std_dev_port1_year24.to_json
    @skew_port1_year24 = @skew_port1_year24.to_json
    @kurt_port1_year24 = @kurt_port1_year24.to_json
    @correlation_port1_year24 = @correlation_port1_year24.to_json
    @yields_port1_year24 = @yields_port1_year24.to_json
    
    @mean_port1_year25 = @mean_port1_year25.to_json
    @std_dev_port1_year25 = @std_dev_port1_year25.to_json
    @skew_port1_year25 = @skew_port1_year25.to_json
    @kurt_port1_year25 = @kurt_port1_year25.to_json
    @correlation_port1_year25 = @correlation_port1_year25.to_json
    @yields_port1_year25 = @yields_port1_year25.to_json
    
    @mean_port1_year26 = @mean_port1_year26.to_json
    @std_dev_port1_year26 = @std_dev_port1_year26.to_json
    @skew_port1_year26 = @skew_port1_year26.to_json
    @kurt_port1_year26 = @kurt_port1_year26.to_json
    @correlation_port1_year26 = @correlation_port1_year26.to_json
    @yields_port1_year26 = @yields_port1_year26.to_json
    
    @mean_port1_year27 = @mean_port1_year27.to_json
    @std_dev_port1_year27 = @std_dev_port1_year27.to_json
    @skew_port1_year27 = @skew_port1_year27.to_json
    @kurt_port1_year27 = @kurt_port1_year27.to_json
    @correlation_port1_year27 = @correlation_port1_year27.to_json
    @yields_port1_year27 = @yields_port1_year27.to_json
    
    @mean_port1_year28 = @mean_port1_year28.to_json
    @std_dev_port1_year28 = @std_dev_port1_year28.to_json
    @skew_port1_year28 = @skew_port1_year28.to_json
    @kurt_port1_year28 = @kurt_port1_year28.to_json
    @correlation_port1_year28 = @correlation_port1_year28.to_json
    @yields_port1_year28 = @yields_port1_year28.to_json
    
    @mean_port1_year29 = @mean_port1_year29.to_json
    @std_dev_port1_year29 = @std_dev_port1_year29.to_json
    @skew_port1_year29 = @skew_port1_year29.to_json
    @kurt_port1_year29 = @kurt_port1_year29.to_json
    @correlation_port1_year29 = @correlation_port1_year29.to_json
    @yields_port1_year29 = @yields_port1_year29.to_json
    
    @mean_port1_year30 = @mean_port1_year30.to_json
    @std_dev_port1_year30 = @std_dev_port1_year30.to_json
    @skew_port1_year30 = @skew_port1_year30.to_json
    @kurt_port1_year30 = @kurt_port1_year30.to_json
    @correlation_port1_year30 = @correlation_port1_year30.to_json
    @yields_port1_year30 = @yields_port1_year30.to_json

#### PORT 2 ####
    @mean_port2_year1 = @mean_port2_year1.to_json
    @std_dev_port2_year1 = @std_dev_port2_year1.to_json
    @skew_port2_year1 = @skew_port2_year1.to_json
    @kurt_port2_year1 = @kurt_port2_year1.to_json
    @correlation_port2_year1 = @correlation_port2_year1.to_json
    @yields_port2_year1 = @yields_port2_year1.to_json

    @mean_port2_year2 = @mean_port2_year2.to_json
    @std_dev_port2_year2 = @std_dev_port2_year2.to_json
    @skew_port2_year2 = @skew_port2_year2.to_json
    @kurt_port2_year2 = @kurt_port2_year2.to_json
    @correlation_port2_year2 = @correlation_port2_year2.to_json
    @yields_port2_year2 = @yields_port2_year2.to_json

    @mean_port2_year3 = @mean_port2_year3.to_json
    @std_dev_port2_year3 = @std_dev_port2_year3.to_json
    @skew_port2_year3 = @skew_port2_year3.to_json
    @kurt_port2_year3 = @kurt_port2_year3.to_json
    @correlation_port2_year3 = @correlation_port2_year3.to_json
    @yields_port2_year3 = @yields_port2_year3.to_json
    
    @mean_port2_year4 = @mean_port2_year4.to_json
    @std_dev_port2_year4 = @std_dev_port2_year4.to_json
    @skew_port2_year4 = @skew_port2_year4.to_json
    @kurt_port2_year4 = @kurt_port2_year4.to_json
    @correlation_port2_year4 = @correlation_port2_year4.to_json
    @yields_port2_year4 = @yields_port2_year4.to_json
    
    @mean_port2_year5 = @mean_port2_year5.to_json
    @std_dev_port2_year5 = @std_dev_port2_year5.to_json
    @skew_port2_year5 = @skew_port2_year5.to_json
    @kurt_port2_year5 = @kurt_port2_year5.to_json
    @correlation_port2_year5 = @correlation_port2_year5.to_json
    @yields_port2_year5 = @yields_port2_year5.to_json
    
    @mean_port2_year6 = @mean_port2_year6.to_json
    @std_dev_port2_year6 = @std_dev_port2_year6.to_json
    @skew_port2_year6 = @skew_port2_year6.to_json
    @kurt_port2_year6 = @kurt_port2_year6.to_json
    @correlation_port2_year6 = @correlation_port2_year6.to_json
    @yields_port2_year6 = @yields_port2_year6.to_json
    
    @mean_port2_year7 = @mean_port2_year7.to_json
    @std_dev_port2_year7 = @std_dev_port2_year7.to_json
    @skew_port2_year7 = @skew_port2_year7.to_json
    @kurt_port2_year7 = @kurt_port2_year7.to_json
    @correlation_port2_year7 = @correlation_port2_year7.to_json
    @yields_port2_year7 = @yields_port2_year7.to_json
    
    @mean_port2_year8 = @mean_port2_year8.to_json
    @std_dev_port2_year8 = @std_dev_port2_year8.to_json
    @skew_port2_year8 = @skew_port2_year8.to_json
    @kurt_port2_year8 = @kurt_port2_year8.to_json
    @correlation_port2_year8 = @correlation_port2_year8.to_json
    @yields_port2_year8 = @yields_port2_year8.to_json
    
    @mean_port2_year9 = @mean_port2_year9.to_json
    @std_dev_port2_year9 = @std_dev_port2_year9.to_json
    @skew_port2_year9 = @skew_port2_year9.to_json
    @kurt_port2_year9 = @kurt_port2_year9.to_json
    @correlation_port2_year9 = @correlation_port2_year9.to_json
    @yields_port2_year9 = @yields_port2_year9.to_json
    
    @mean_port2_year10 = @mean_port2_year10.to_json
    @std_dev_port2_year10 = @std_dev_port2_year10.to_json
    @skew_port2_year10 = @skew_port2_year10.to_json
    @kurt_port2_year10 = @kurt_port2_year10.to_json
    @correlation_port2_year10 = @correlation_port2_year10.to_json
    @yields_port2_year10 = @yields_port2_year10.to_json
    
    
    @mean_port2_year11 = @mean_port2_year11.to_json
    @std_dev_port2_year11 = @std_dev_port2_year11.to_json
    @skew_port2_year11 = @skew_port2_year11.to_json
    @kurt_port2_year11 = @kurt_port2_year11.to_json
    @correlation_port2_year11 = @correlation_port2_year11.to_json
    @yields_port2_year11 = @yields_port2_year11.to_json

    @mean_port2_year12 = @mean_port2_year12.to_json
    @std_dev_port2_year12 = @std_dev_port2_year12.to_json
    @skew_port2_year12 = @skew_port2_year12.to_json
    @kurt_port2_year12 = @kurt_port2_year12.to_json
    @correlation_port2_year12 = @correlation_port2_year12.to_json
    @yields_port2_year12 = @yields_port2_year12.to_json

    @mean_port2_year13 = @mean_port2_year13.to_json
    @std_dev_port2_year13 = @std_dev_port2_year13.to_json
    @skew_port2_year13 = @skew_port2_year13.to_json
    @kurt_port2_year13 = @kurt_port2_year13.to_json
    @correlation_port2_year13 = @correlation_port2_year13.to_json
    @yields_port2_year13 = @yields_port2_year13.to_json
    
    @mean_port2_year14 = @mean_port2_year14.to_json
    @std_dev_port2_year14 = @std_dev_port2_year14.to_json
    @skew_port2_year14 = @skew_port2_year14.to_json
    @kurt_port2_year14 = @kurt_port2_year14.to_json
    @correlation_port2_year14 = @correlation_port2_year14.to_json
    @yields_port2_year14 = @yields_port2_year14.to_json
    
    @mean_port2_year15 = @mean_port2_year15.to_json
    @std_dev_port2_year15 = @std_dev_port2_year15.to_json
    @skew_port2_year15 = @skew_port2_year15.to_json
    @kurt_port2_year15 = @kurt_port2_year15.to_json
    @correlation_port2_year15 = @correlation_port2_year15.to_json
    @yields_port2_year15 = @yields_port2_year15.to_json
    
    @mean_port2_year16 = @mean_port2_year16.to_json
    @std_dev_port2_year16 = @std_dev_port2_year16.to_json
    @skew_port2_year16 = @skew_port2_year16.to_json
    @kurt_port2_year16 = @kurt_port2_year16.to_json
    @correlation_port2_year16 = @correlation_port2_year16.to_json
    @yields_port2_year16 = @yields_port2_year16.to_json
    
    @mean_port2_year17 = @mean_port2_year17.to_json
    @std_dev_port2_year17 = @std_dev_port2_year17.to_json
    @skew_port2_year17 = @skew_port2_year17.to_json
    @kurt_port2_year17 = @kurt_port2_year17.to_json
    @correlation_port2_year17 = @correlation_port2_year17.to_json
    @yields_port2_year17 = @yields_port2_year17.to_json
    
    @mean_port2_year18 = @mean_port2_year18.to_json
    @std_dev_port2_year18 = @std_dev_port2_year18.to_json
    @skew_port2_year18 = @skew_port2_year18.to_json
    @kurt_port2_year18 = @kurt_port2_year18.to_json
    @correlation_port2_year18 = @correlation_port2_year18.to_json
    @yields_port2_year18 = @yields_port2_year18.to_json
    
    @mean_port2_year19 = @mean_port2_year19.to_json
    @std_dev_port2_year19 = @std_dev_port2_year19.to_json
    @skew_port2_year19 = @skew_port2_year19.to_json
    @kurt_port2_year19 = @kurt_port2_year19.to_json
    @correlation_port2_year19 = @correlation_port2_year19.to_json
    @yields_port2_year19 = @yields_port2_year19.to_json
    
    @mean_port2_year20 = @mean_port2_year20.to_json
    @std_dev_port2_year20 = @std_dev_port2_year20.to_json
    @skew_port2_year20 = @skew_port2_year20.to_json
    @kurt_port2_year20 = @kurt_port2_year20.to_json
    @correlation_port2_year20 = @correlation_port2_year20.to_json
    @yields_port2_year20 = @yields_port2_year20.to_json
    
    @mean_port2_year21 = @mean_port2_year21.to_json
    @std_dev_port2_year21 = @std_dev_port2_year21.to_json
    @skew_port2_year21 = @skew_port2_year21.to_json
    @kurt_port2_year21 = @kurt_port2_year21.to_json
    @correlation_port2_year21 = @correlation_port2_year21.to_json
    @yields_port2_year21 = @yields_port2_year21.to_json

    @mean_port2_year22 = @mean_port2_year22.to_json
    @std_dev_port2_year22 = @std_dev_port2_year22.to_json
    @skew_port2_year22 = @skew_port2_year22.to_json
    @kurt_port2_year22 = @kurt_port2_year22.to_json
    @correlation_port2_year22 = @correlation_port2_year22.to_json
    @yields_port2_year22 = @yields_port2_year22.to_json

    @mean_port2_year23 = @mean_port2_year23.to_json
    @std_dev_port2_year23 = @std_dev_port2_year23.to_json
    @skew_port2_year23 = @skew_port2_year23.to_json
    @kurt_port2_year23 = @kurt_port2_year23.to_json
    @correlation_port2_year23 = @correlation_port2_year23.to_json
    @yields_port2_year23 = @yields_port2_year23.to_json
    
    @mean_port2_year24 = @mean_port2_year24.to_json
    @std_dev_port2_year24 = @std_dev_port2_year24.to_json
    @skew_port2_year24 = @skew_port2_year24.to_json
    @kurt_port2_year24 = @kurt_port2_year24.to_json
    @correlation_port2_year24 = @correlation_port2_year24.to_json
    @yields_port2_year24 = @yields_port2_year24.to_json
    
    @mean_port2_year25 = @mean_port2_year25.to_json
    @std_dev_port2_year25 = @std_dev_port2_year25.to_json
    @skew_port2_year25 = @skew_port2_year25.to_json
    @kurt_port2_year25 = @kurt_port2_year25.to_json
    @correlation_port2_year25 = @correlation_port2_year25.to_json
    @yields_port2_year25 = @yields_port2_year25.to_json
    
    @mean_port2_year26 = @mean_port2_year26.to_json
    @std_dev_port2_year26 = @std_dev_port2_year26.to_json
    @skew_port2_year26 = @skew_port2_year26.to_json
    @kurt_port2_year26 = @kurt_port2_year26.to_json
    @correlation_port2_year26 = @correlation_port2_year26.to_json
    @yields_port2_year26 = @yields_port2_year26.to_json
    
    @mean_port2_year27 = @mean_port2_year27.to_json
    @std_dev_port2_year27 = @std_dev_port2_year27.to_json
    @skew_port2_year27 = @skew_port2_year27.to_json
    @kurt_port2_year27 = @kurt_port2_year27.to_json
    @correlation_port2_year27 = @correlation_port2_year27.to_json
    @yields_port2_year27 = @yields_port2_year27.to_json
    
    @mean_port2_year28 = @mean_port2_year28.to_json
    @std_dev_port2_year28 = @std_dev_port2_year28.to_json
    @skew_port2_year28 = @skew_port2_year28.to_json
    @kurt_port2_year28 = @kurt_port2_year28.to_json
    @correlation_port2_year28 = @correlation_port2_year28.to_json
    @yields_port2_year28 = @yields_port2_year28.to_json
    
    @mean_port2_year29 = @mean_port2_year29.to_json
    @std_dev_port2_year29 = @std_dev_port2_year29.to_json
    @skew_port2_year29 = @skew_port2_year29.to_json
    @kurt_port2_year29 = @kurt_port2_year29.to_json
    @correlation_port2_year29 = @correlation_port2_year29.to_json
    @yields_port2_year29 = @yields_port2_year29.to_json
    
    @mean_port2_year30 = @mean_port2_year30.to_json
    @std_dev_port2_year30 = @std_dev_port2_year30.to_json
    @skew_port2_year30 = @skew_port2_year30.to_json
    @kurt_port2_year30 = @kurt_port2_year30.to_json
    @correlation_port2_year30 = @correlation_port2_year30.to_json
    @yields_port2_year30 = @yields_port2_year30.to_json

  #### PORT 3 ####
    @mean_port3_year1 = @mean_port3_year1.to_json
    @std_dev_port3_year1 = @std_dev_port3_year1.to_json
    @skew_port3_year1 = @skew_port3_year1.to_json
    @kurt_port3_year1 = @kurt_port3_year1.to_json
    @correlation_port3_year1 = @correlation_port3_year1.to_json
    @yields_port3_year1 = @yields_port3_year1.to_json

    @mean_port3_year2 = @mean_port3_year2.to_json
    @std_dev_port3_year2 = @std_dev_port3_year2.to_json
    @skew_port3_year2 = @skew_port3_year2.to_json
    @kurt_port3_year2 = @kurt_port3_year2.to_json
    @correlation_port3_year2 = @correlation_port3_year2.to_json
    @yields_port3_year2 = @yields_port3_year2.to_json

    @mean_port3_year3 = @mean_port3_year3.to_json
    @std_dev_port3_year3 = @std_dev_port3_year3.to_json
    @skew_port3_year3 = @skew_port3_year3.to_json
    @kurt_port3_year3 = @kurt_port3_year3.to_json
    @correlation_port3_year3 = @correlation_port3_year3.to_json
    @yields_port3_year3 = @yields_port3_year3.to_json
    
    @mean_port3_year4 = @mean_port3_year4.to_json
    @std_dev_port3_year4 = @std_dev_port3_year4.to_json
    @skew_port3_year4 = @skew_port3_year4.to_json
    @kurt_port3_year4 = @kurt_port3_year4.to_json
    @correlation_port3_year4 = @correlation_port3_year4.to_json
    @yields_port3_year4 = @yields_port3_year4.to_json
    
    @mean_port3_year5 = @mean_port3_year5.to_json
    @std_dev_port3_year5 = @std_dev_port3_year5.to_json
    @skew_port3_year5 = @skew_port3_year5.to_json
    @kurt_port3_year5 = @kurt_port3_year5.to_json
    @correlation_port3_year5 = @correlation_port3_year5.to_json
    @yields_port3_year5 = @yields_port3_year5.to_json
    
    @mean_port3_year6 = @mean_port3_year6.to_json
    @std_dev_port3_year6 = @std_dev_port3_year6.to_json
    @skew_port3_year6 = @skew_port3_year6.to_json
    @kurt_port3_year6 = @kurt_port3_year6.to_json
    @correlation_port3_year6 = @correlation_port3_year6.to_json
    @yields_port3_year6 = @yields_port3_year6.to_json
    
    @mean_port3_year7 = @mean_port3_year7.to_json
    @std_dev_port3_year7 = @std_dev_port3_year7.to_json
    @skew_port3_year7 = @skew_port3_year7.to_json
    @kurt_port3_year7 = @kurt_port3_year7.to_json
    @correlation_port3_year7 = @correlation_port3_year7.to_json
    @yields_port3_year7 = @yields_port3_year7.to_json
    
    @mean_port3_year8 = @mean_port3_year8.to_json
    @std_dev_port3_year8 = @std_dev_port3_year8.to_json
    @skew_port3_year8 = @skew_port3_year8.to_json
    @kurt_port3_year8 = @kurt_port3_year8.to_json
    @correlation_port3_year8 = @correlation_port3_year8.to_json
    @yields_port3_year8 = @yields_port3_year8.to_json
    
    @mean_port3_year9 = @mean_port3_year9.to_json
    @std_dev_port3_year9 = @std_dev_port3_year9.to_json
    @skew_port3_year9 = @skew_port3_year9.to_json
    @kurt_port3_year9 = @kurt_port3_year9.to_json
    @correlation_port3_year9 = @correlation_port3_year9.to_json
    @yields_port3_year9 = @yields_port3_year9.to_json
    
    @mean_port3_year10 = @mean_port3_year10.to_json
    @std_dev_port3_year10 = @std_dev_port3_year10.to_json
    @skew_port3_year10 = @skew_port3_year10.to_json
    @kurt_port3_year10 = @kurt_port3_year10.to_json
    @correlation_port3_year10 = @correlation_port3_year10.to_json
    @yields_port3_year10 = @yields_port3_year10.to_json
    
    
    @mean_port3_year11 = @mean_port3_year11.to_json
    @std_dev_port3_year11 = @std_dev_port3_year11.to_json
    @skew_port3_year11 = @skew_port3_year11.to_json
    @kurt_port3_year11 = @kurt_port3_year11.to_json
    @correlation_port3_year11 = @correlation_port3_year11.to_json
    @yields_port3_year11 = @yields_port3_year11.to_json

    @mean_port3_year12 = @mean_port3_year12.to_json
    @std_dev_port3_year12 = @std_dev_port3_year12.to_json
    @skew_port3_year12 = @skew_port3_year12.to_json
    @kurt_port3_year12 = @kurt_port3_year12.to_json
    @correlation_port3_year12 = @correlation_port3_year12.to_json
    @yields_port3_year12 = @yields_port3_year12.to_json

    @mean_port3_year13 = @mean_port3_year13.to_json
    @std_dev_port3_year13 = @std_dev_port3_year13.to_json
    @skew_port3_year13 = @skew_port3_year13.to_json
    @kurt_port3_year13 = @kurt_port3_year13.to_json
    @correlation_port3_year13 = @correlation_port3_year13.to_json
    @yields_port3_year13 = @yields_port3_year13.to_json
    
    @mean_port3_year14 = @mean_port3_year14.to_json
    @std_dev_port3_year14 = @std_dev_port3_year14.to_json
    @skew_port3_year14 = @skew_port3_year14.to_json
    @kurt_port3_year14 = @kurt_port3_year14.to_json
    @correlation_port3_year14 = @correlation_port3_year14.to_json
    @yields_port3_year14 = @yields_port3_year14.to_json
    
    @mean_port3_year15 = @mean_port3_year15.to_json
    @std_dev_port3_year15 = @std_dev_port3_year15.to_json
    @skew_port3_year15 = @skew_port3_year15.to_json
    @kurt_port3_year15 = @kurt_port3_year15.to_json
    @correlation_port3_year15 = @correlation_port3_year15.to_json
    @yields_port3_year15 = @yields_port3_year15.to_json
    
    @mean_port3_year16 = @mean_port3_year16.to_json
    @std_dev_port3_year16 = @std_dev_port3_year16.to_json
    @skew_port3_year16 = @skew_port3_year16.to_json
    @kurt_port3_year16 = @kurt_port3_year16.to_json
    @correlation_port3_year16 = @correlation_port3_year16.to_json
    @yields_port3_year16 = @yields_port3_year16.to_json
    
    @mean_port3_year17 = @mean_port3_year17.to_json
    @std_dev_port3_year17 = @std_dev_port3_year17.to_json
    @skew_port3_year17 = @skew_port3_year17.to_json
    @kurt_port3_year17 = @kurt_port3_year17.to_json
    @correlation_port3_year17 = @correlation_port3_year17.to_json
    @yields_port3_year17 = @yields_port3_year17.to_json
    
    @mean_port3_year18 = @mean_port3_year18.to_json
    @std_dev_port3_year18 = @std_dev_port3_year18.to_json
    @skew_port3_year18 = @skew_port3_year18.to_json
    @kurt_port3_year18 = @kurt_port3_year18.to_json
    @correlation_port3_year18 = @correlation_port3_year18.to_json
    @yields_port3_year18 = @yields_port3_year18.to_json
    
    @mean_port3_year19 = @mean_port3_year19.to_json
    @std_dev_port3_year19 = @std_dev_port3_year19.to_json
    @skew_port3_year19 = @skew_port3_year19.to_json
    @kurt_port3_year19 = @kurt_port3_year19.to_json
    @correlation_port3_year19 = @correlation_port3_year19.to_json
    @yields_port3_year19 = @yields_port3_year19.to_json
    
    @mean_port3_year20 = @mean_port3_year20.to_json
    @std_dev_port3_year20 = @std_dev_port3_year20.to_json
    @skew_port3_year20 = @skew_port3_year20.to_json
    @kurt_port3_year20 = @kurt_port3_year20.to_json
    @correlation_port3_year20 = @correlation_port3_year20.to_json
    @yields_port3_year20 = @yields_port3_year20.to_json
    
    @mean_port3_year21 = @mean_port3_year21.to_json
    @std_dev_port3_year21 = @std_dev_port3_year21.to_json
    @skew_port3_year21 = @skew_port3_year21.to_json
    @kurt_port3_year21 = @kurt_port3_year21.to_json
    @correlation_port3_year21 = @correlation_port3_year21.to_json
    @yields_port3_year21 = @yields_port3_year21.to_json

    @mean_port3_year22 = @mean_port3_year22.to_json
    @std_dev_port3_year22 = @std_dev_port3_year22.to_json
    @skew_port3_year22 = @skew_port3_year22.to_json
    @kurt_port3_year22 = @kurt_port3_year22.to_json
    @correlation_port3_year22 = @correlation_port3_year22.to_json
    @yields_port3_year22 = @yields_port3_year22.to_json

    @mean_port3_year23 = @mean_port3_year23.to_json
    @std_dev_port3_year23 = @std_dev_port3_year23.to_json
    @skew_port3_year23 = @skew_port3_year23.to_json
    @kurt_port3_year23 = @kurt_port3_year23.to_json
    @correlation_port3_year23 = @correlation_port3_year23.to_json
    @yields_port3_year23 = @yields_port3_year23.to_json
    
    @mean_port3_year24 = @mean_port3_year24.to_json
    @std_dev_port3_year24 = @std_dev_port3_year24.to_json
    @skew_port3_year24 = @skew_port3_year24.to_json
    @kurt_port3_year24 = @kurt_port3_year24.to_json
    @correlation_port3_year24 = @correlation_port3_year24.to_json
    @yields_port3_year24 = @yields_port3_year24.to_json
    
    @mean_port3_year25 = @mean_port3_year25.to_json
    @std_dev_port3_year25 = @std_dev_port3_year25.to_json
    @skew_port3_year25 = @skew_port3_year25.to_json
    @kurt_port3_year25 = @kurt_port3_year25.to_json
    @correlation_port3_year25 = @correlation_port3_year25.to_json
    @yields_port3_year25 = @yields_port3_year25.to_json
    
    @mean_port3_year26 = @mean_port3_year26.to_json
    @std_dev_port3_year26 = @std_dev_port3_year26.to_json
    @skew_port3_year26 = @skew_port3_year26.to_json
    @kurt_port3_year26 = @kurt_port3_year26.to_json
    @correlation_port3_year26 = @correlation_port3_year26.to_json
    @yields_port3_year26 = @yields_port3_year26.to_json
    
    @mean_port3_year27 = @mean_port3_year27.to_json
    @std_dev_port3_year27 = @std_dev_port3_year27.to_json
    @skew_port3_year27 = @skew_port3_year27.to_json
    @kurt_port3_year27 = @kurt_port3_year27.to_json
    @correlation_port3_year27 = @correlation_port3_year27.to_json
    @yields_port3_year27 = @yields_port3_year27.to_json
    
    @mean_port3_year28 = @mean_port3_year28.to_json
    @std_dev_port3_year28 = @std_dev_port3_year28.to_json
    @skew_port3_year28 = @skew_port3_year28.to_json
    @kurt_port3_year28 = @kurt_port3_year28.to_json
    @correlation_port3_year28 = @correlation_port3_year28.to_json
    @yields_port3_year28 = @yields_port3_year28.to_json
    
    @mean_port3_year29 = @mean_port3_year29.to_json
    @std_dev_port3_year29 = @std_dev_port3_year29.to_json
    @skew_port3_year29 = @skew_port3_year29.to_json
    @kurt_port3_year29 = @kurt_port3_year29.to_json
    @correlation_port3_year29 = @correlation_port3_year29.to_json
    @yields_port3_year29 = @yields_port3_year29.to_json
    
    @mean_port3_year30 = @mean_port3_year30.to_json
    @std_dev_port3_year30 = @std_dev_port3_year30.to_json
    @skew_port3_year30 = @skew_port3_year30.to_json
    @kurt_port3_year30 = @kurt_port3_year30.to_json
    @correlation_port3_year30 = @correlation_port3_year30.to_json
    @yields_port3_year30 = @yields_port3_year30.to_json

  #### PORT 4 ####
    @mean_port4_year1 = @mean_port4_year1.to_json
    @std_dev_port4_year1 = @std_dev_port4_year1.to_json
    @skew_port4_year1 = @skew_port4_year1.to_json
    @kurt_port4_year1 = @kurt_port4_year1.to_json
    @correlation_port4_year1 = @correlation_port4_year1.to_json
    @yields_port4_year1 = @yields_port4_year1.to_json

    @mean_port4_year2 = @mean_port4_year2.to_json
    @std_dev_port4_year2 = @std_dev_port4_year2.to_json
    @skew_port4_year2 = @skew_port4_year2.to_json
    @kurt_port4_year2 = @kurt_port4_year2.to_json
    @correlation_port4_year2 = @correlation_port4_year2.to_json
    @yields_port4_year2 = @yields_port4_year2.to_json

    @mean_port4_year3 = @mean_port4_year3.to_json
    @std_dev_port4_year3 = @std_dev_port4_year3.to_json
    @skew_port4_year3 = @skew_port4_year3.to_json
    @kurt_port4_year3 = @kurt_port4_year3.to_json
    @correlation_port4_year3 = @correlation_port4_year3.to_json
    @yields_port4_year3 = @yields_port4_year3.to_json
    
    @mean_port4_year4 = @mean_port4_year4.to_json
    @std_dev_port4_year4 = @std_dev_port4_year4.to_json
    @skew_port4_year4 = @skew_port4_year4.to_json
    @kurt_port4_year4 = @kurt_port4_year4.to_json
    @correlation_port4_year4 = @correlation_port4_year4.to_json
    @yields_port4_year4 = @yields_port4_year4.to_json
    
    @mean_port4_year5 = @mean_port4_year5.to_json
    @std_dev_port4_year5 = @std_dev_port4_year5.to_json
    @skew_port4_year5 = @skew_port4_year5.to_json
    @kurt_port4_year5 = @kurt_port4_year5.to_json
    @correlation_port4_year5 = @correlation_port4_year5.to_json
    @yields_port4_year5 = @yields_port4_year5.to_json
    
    @mean_port4_year6 = @mean_port4_year6.to_json
    @std_dev_port4_year6 = @std_dev_port4_year6.to_json
    @skew_port4_year6 = @skew_port4_year6.to_json
    @kurt_port4_year6 = @kurt_port4_year6.to_json
    @correlation_port4_year6 = @correlation_port4_year6.to_json
    @yields_port4_year6 = @yields_port4_year6.to_json
    
    @mean_port4_year7 = @mean_port4_year7.to_json
    @std_dev_port4_year7 = @std_dev_port4_year7.to_json
    @skew_port4_year7 = @skew_port4_year7.to_json
    @kurt_port4_year7 = @kurt_port4_year7.to_json
    @correlation_port4_year7 = @correlation_port4_year7.to_json
    @yields_port4_year7 = @yields_port4_year7.to_json
    
    @mean_port4_year8 = @mean_port4_year8.to_json
    @std_dev_port4_year8 = @std_dev_port4_year8.to_json
    @skew_port4_year8 = @skew_port4_year8.to_json
    @kurt_port4_year8 = @kurt_port4_year8.to_json
    @correlation_port4_year8 = @correlation_port4_year8.to_json
    @yields_port4_year8 = @yields_port4_year8.to_json
    
    @mean_port4_year9 = @mean_port4_year9.to_json
    @std_dev_port4_year9 = @std_dev_port4_year9.to_json
    @skew_port4_year9 = @skew_port4_year9.to_json
    @kurt_port4_year9 = @kurt_port4_year9.to_json
    @correlation_port4_year9 = @correlation_port4_year9.to_json
    @yields_port4_year9 = @yields_port4_year9.to_json
    
    @mean_port4_year10 = @mean_port4_year10.to_json
    @std_dev_port4_year10 = @std_dev_port4_year10.to_json
    @skew_port4_year10 = @skew_port4_year10.to_json
    @kurt_port4_year10 = @kurt_port4_year10.to_json
    @correlation_port4_year10 = @correlation_port4_year10.to_json
    @yields_port4_year10 = @yields_port4_year10.to_json
    
    
    @mean_port4_year11 = @mean_port4_year11.to_json
    @std_dev_port4_year11 = @std_dev_port4_year11.to_json
    @skew_port4_year11 = @skew_port4_year11.to_json
    @kurt_port4_year11 = @kurt_port4_year11.to_json
    @correlation_port4_year11 = @correlation_port4_year11.to_json
    @yields_port4_year11 = @yields_port4_year11.to_json

    @mean_port4_year12 = @mean_port4_year12.to_json
    @std_dev_port4_year12 = @std_dev_port4_year12.to_json
    @skew_port4_year12 = @skew_port4_year12.to_json
    @kurt_port4_year12 = @kurt_port4_year12.to_json
    @correlation_port4_year12 = @correlation_port4_year12.to_json
    @yields_port4_year12 = @yields_port4_year12.to_json

    @mean_port4_year13 = @mean_port4_year13.to_json
    @std_dev_port4_year13 = @std_dev_port4_year13.to_json
    @skew_port4_year13 = @skew_port4_year13.to_json
    @kurt_port4_year13 = @kurt_port4_year13.to_json
    @correlation_port4_year13 = @correlation_port4_year13.to_json
    @yields_port4_year13 = @yields_port4_year13.to_json
    
    @mean_port4_year14 = @mean_port4_year14.to_json
    @std_dev_port4_year14 = @std_dev_port4_year14.to_json
    @skew_port4_year14 = @skew_port4_year14.to_json
    @kurt_port4_year14 = @kurt_port4_year14.to_json
    @correlation_port4_year14 = @correlation_port4_year14.to_json
    @yields_port4_year14 = @yields_port4_year14.to_json
    
    @mean_port4_year15 = @mean_port4_year15.to_json
    @std_dev_port4_year15 = @std_dev_port4_year15.to_json
    @skew_port4_year15 = @skew_port4_year15.to_json
    @kurt_port4_year15 = @kurt_port4_year15.to_json
    @correlation_port4_year15 = @correlation_port4_year15.to_json
    @yields_port4_year15 = @yields_port4_year15.to_json
    
    @mean_port4_year16 = @mean_port4_year16.to_json
    @std_dev_port4_year16 = @std_dev_port4_year16.to_json
    @skew_port4_year16 = @skew_port4_year16.to_json
    @kurt_port4_year16 = @kurt_port4_year16.to_json
    @correlation_port4_year16 = @correlation_port4_year16.to_json
    @yields_port4_year16 = @yields_port4_year16.to_json
    
    @mean_port4_year17 = @mean_port4_year17.to_json
    @std_dev_port4_year17 = @std_dev_port4_year17.to_json
    @skew_port4_year17 = @skew_port4_year17.to_json
    @kurt_port4_year17 = @kurt_port4_year17.to_json
    @correlation_port4_year17 = @correlation_port4_year17.to_json
    @yields_port4_year17 = @yields_port4_year17.to_json
    
    @mean_port4_year18 = @mean_port4_year18.to_json
    @std_dev_port4_year18 = @std_dev_port4_year18.to_json
    @skew_port4_year18 = @skew_port4_year18.to_json
    @kurt_port4_year18 = @kurt_port4_year18.to_json
    @correlation_port4_year18 = @correlation_port4_year18.to_json
    @yields_port4_year18 = @yields_port4_year18.to_json
    
    @mean_port4_year19 = @mean_port4_year19.to_json
    @std_dev_port4_year19 = @std_dev_port4_year19.to_json
    @skew_port4_year19 = @skew_port4_year19.to_json
    @kurt_port4_year19 = @kurt_port4_year19.to_json
    @correlation_port4_year19 = @correlation_port4_year19.to_json
    @yields_port4_year19 = @yields_port4_year19.to_json
    
    @mean_port4_year20 = @mean_port4_year20.to_json
    @std_dev_port4_year20 = @std_dev_port4_year20.to_json
    @skew_port4_year20 = @skew_port4_year20.to_json
    @kurt_port4_year20 = @kurt_port4_year20.to_json
    @correlation_port4_year20 = @correlation_port4_year20.to_json
    @yields_port4_year20 = @yields_port4_year20.to_json
    
    @mean_port4_year21 = @mean_port4_year21.to_json
    @std_dev_port4_year21 = @std_dev_port4_year21.to_json
    @skew_port4_year21 = @skew_port4_year21.to_json
    @kurt_port4_year21 = @kurt_port4_year21.to_json
    @correlation_port4_year21 = @correlation_port4_year21.to_json
    @yields_port4_year21 = @yields_port4_year21.to_json

    @mean_port4_year22 = @mean_port4_year22.to_json
    @std_dev_port4_year22 = @std_dev_port4_year22.to_json
    @skew_port4_year22 = @skew_port4_year22.to_json
    @kurt_port4_year22 = @kurt_port4_year22.to_json
    @correlation_port4_year22 = @correlation_port4_year22.to_json
    @yields_port4_year22 = @yields_port4_year22.to_json

    @mean_port4_year23 = @mean_port4_year23.to_json
    @std_dev_port4_year23 = @std_dev_port4_year23.to_json
    @skew_port4_year23 = @skew_port4_year23.to_json
    @kurt_port4_year23 = @kurt_port4_year23.to_json
    @correlation_port4_year23 = @correlation_port4_year23.to_json
    @yields_port4_year23 = @yields_port4_year23.to_json
    
    @mean_port4_year24 = @mean_port4_year24.to_json
    @std_dev_port4_year24 = @std_dev_port4_year24.to_json
    @skew_port4_year24 = @skew_port4_year24.to_json
    @kurt_port4_year24 = @kurt_port4_year24.to_json
    @correlation_port4_year24 = @correlation_port4_year24.to_json
    @yields_port4_year24 = @yields_port4_year24.to_json
    
    @mean_port4_year25 = @mean_port4_year25.to_json
    @std_dev_port4_year25 = @std_dev_port4_year25.to_json
    @skew_port4_year25 = @skew_port4_year25.to_json
    @kurt_port4_year25 = @kurt_port4_year25.to_json
    @correlation_port4_year25 = @correlation_port4_year25.to_json
    @yields_port4_year25 = @yields_port4_year25.to_json
    
    @mean_port4_year26 = @mean_port4_year26.to_json
    @std_dev_port4_year26 = @std_dev_port4_year26.to_json
    @skew_port4_year26 = @skew_port4_year26.to_json
    @kurt_port4_year26 = @kurt_port4_year26.to_json
    @correlation_port4_year26 = @correlation_port4_year26.to_json
    @yields_port4_year26 = @yields_port4_year26.to_json
    
    @mean_port4_year27 = @mean_port4_year27.to_json
    @std_dev_port4_year27 = @std_dev_port4_year27.to_json
    @skew_port4_year27 = @skew_port4_year27.to_json
    @kurt_port4_year27 = @kurt_port4_year27.to_json
    @correlation_port4_year27 = @correlation_port4_year27.to_json
    @yields_port4_year27 = @yields_port4_year27.to_json
    
    @mean_port4_year28 = @mean_port4_year28.to_json
    @std_dev_port4_year28 = @std_dev_port4_year28.to_json
    @skew_port4_year28 = @skew_port4_year28.to_json
    @kurt_port4_year28 = @kurt_port4_year28.to_json
    @correlation_port4_year28 = @correlation_port4_year28.to_json
    @yields_port4_year28 = @yields_port4_year28.to_json
    
    @mean_port4_year29 = @mean_port4_year29.to_json
    @std_dev_port4_year29 = @std_dev_port4_year29.to_json
    @skew_port4_year29 = @skew_port4_year29.to_json
    @kurt_port4_year29 = @kurt_port4_year29.to_json
    @correlation_port4_year29 = @correlation_port4_year29.to_json
    @yields_port4_year29 = @yields_port4_year29.to_json
    
    @mean_port4_year30 = @mean_port4_year30.to_json
    @std_dev_port4_year30 = @std_dev_port4_year30.to_json
    @skew_port4_year30 = @skew_port4_year30.to_json
    @kurt_port4_year30 = @kurt_port4_year30.to_json
    @correlation_port4_year30 = @correlation_port4_year30.to_json
    @yields_port4_year30 = @yields_port4_year30.to_json

    
    if @the_forecast_input.portfolio1_id.blank?
      @python_forecat_port1 = 0
    else
      # @python_forecat_port1 = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port1}" "#{@mean_port1_year1}" "#{@std_dev_port1_year1}" "#{@skew_port1_year1}" "#{@kurt_port1_year1}" "#{@correlation_port1_year1}" "#{@yields_port1_year1}" "#{@mean_port1_year2}" "#{@std_dev_port1_year2}" "#{@skew_port1_year2}" "#{@kurt_port1_year2}" "#{@correlation_port1_year2}" "#{@yields_port1_year2}" "#{@mean_port1_year3}" "#{@std_dev_port1_year3}" "#{@skew_port1_year3}" "#{@kurt_port1_year3}" "#{@correlation_port1_year3}" "#{@yields_port1_year3}" "#{@mean_port1_year4}" "#{@std_dev_port1_year4}" "#{@skew_port1_year4}" "#{@kurt_port1_year4}" "#{@correlation_port1_year4}" "#{@yields_port1_year4}" "#{@mean_port1_year5}" "#{@std_dev_port1_year5}" "#{@skew_port1_year5}" "#{@kurt_port1_year5}" "#{@correlation_port1_year5}" "#{@yields_port1_year5}" "#{@mean_port1_year6}" "#{@std_dev_port1_year6}" "#{@skew_port1_year6}" "#{@kurt_port1_year6}" "#{@correlation_port1_year6}" "#{@yields_port1_year6}" "#{@mean_port1_year7}" "#{@std_dev_port1_year7}" "#{@skew_port1_year7}" "#{@kurt_port1_year7}" "#{@correlation_port1_year7}" "#{@yields_port1_year7}" "#{@mean_port1_year8}" "#{@std_dev_port1_year8}" "#{@skew_port1_year8}" "#{@kurt_port1_year8}" "#{@correlation_port1_year8}" "#{@yields_port1_year8}" "#{@mean_port1_year9}" "#{@std_dev_port1_year9}" "#{@skew_port1_year9}" "#{@kurt_port1_year9}" "#{@correlation_port1_year9}" "#{@yields_port1_year9}" "#{@mean_port1_year10}" "#{@std_dev_port1_year10}" "#{@skew_port1_year10}" "#{@kurt_port1_year10}" "#{@correlation_port1_year10}" "#{@yields_port1_year10}" "#{@mean_port1_year11}" "#{@std_dev_port1_year11}" "#{@skew_port1_year11}" "#{@kurt_port1_year11}" "#{@correlation_port1_year11}" "#{@yields_port1_year11}" "#{@mean_port1_year12}" "#{@std_dev_port1_year12}" "#{@skew_port1_year12}" "#{@kurt_port1_year12}" "#{@correlation_port1_year12}" "#{@yields_port1_year12}" "#{@mean_port1_year13}" "#{@std_dev_port1_year13}" "#{@skew_port1_year13}" "#{@kurt_port1_year13}" "#{@correlation_port1_year13}" "#{@yields_port1_year13}" "#{@mean_port1_year14}" "#{@std_dev_port1_year14}" "#{@skew_port1_year14}" "#{@kurt_port1_year14}" "#{@correlation_port1_year14}" "#{@yields_port1_year14}" "#{@mean_port1_year15}" "#{@std_dev_port1_year15}" "#{@skew_port1_year15}" "#{@kurt_port1_year15}" "#{@correlation_port1_year15}" "#{@yields_port1_year15}" "#{@mean_port1_year16}" "#{@std_dev_port1_year16}" "#{@skew_port1_year16}" "#{@kurt_port1_year16}" "#{@correlation_port1_year16}" "#{@yields_port1_year16}" "#{@mean_port1_year17}" "#{@std_dev_port1_year17}" "#{@skew_port1_year17}" "#{@kurt_port1_year17}" "#{@correlation_port1_year17}" "#{@yields_port1_year17}" "#{@mean_port1_year18}" "#{@std_dev_port1_year18}" "#{@skew_port1_year18}" "#{@kurt_port1_year18}" "#{@correlation_port1_year18}" "#{@yields_port1_year18}" "#{@mean_port1_year19}" "#{@std_dev_port1_year19}" "#{@skew_port1_year19}" "#{@kurt_port1_year19}" "#{@correlation_port1_year19}" "#{@yields_port1_year19}" "#{@mean_port1_year20}" "#{@std_dev_port1_year20}" "#{@skew_port1_year20}" "#{@kurt_port1_year20}" "#{@correlation_port1_year20}" "#{@yields_port1_year20}" "#{@mean_port1_year21}" "#{@std_dev_port1_year21}" "#{@skew_port1_year21}" "#{@kurt_port1_year21}" "#{@correlation_port1_year21}" "#{@yields_port1_year21}" "#{@mean_port1_year22}" "#{@std_dev_port1_year22}" "#{@skew_port1_year22}" "#{@kurt_port1_year22}" "#{@correlation_port1_year22}" "#{@yields_port1_year22}" "#{@mean_port1_year23}" "#{@std_dev_port1_year23}" "#{@skew_port1_year23}" "#{@kurt_port1_year23}" "#{@correlation_port1_year23}" "#{@yields_port1_year23}" "#{@mean_port1_year24}" "#{@std_dev_port1_year24}" "#{@skew_port1_year24}" "#{@kurt_port1_year24}" "#{@correlation_port1_year24}" "#{@yields_port1_year24}" "#{@mean_port1_year25}" "#{@std_dev_port1_year25}" "#{@skew_port1_year25}" "#{@kurt_port1_year25}" "#{@correlation_port1_year25}" "#{@yields_port1_year25}" "#{@mean_port1_year26}" "#{@std_dev_port1_year26}" "#{@skew_port1_year26}" "#{@kurt_port1_year26}" "#{@correlation_port1_year26}" "#{@yields_port1_year26}" "#{@mean_port1_year27}" "#{@std_dev_port1_year27}" "#{@skew_port1_year27}" "#{@kurt_port1_year27}" "#{@correlation_port1_year27}" "#{@yields_port1_year27}" "#{@mean_port1_year28}" "#{@std_dev_port1_year28}" "#{@skew_port1_year28}" "#{@kurt_port1_year28}" "#{@correlation_port1_year28}" "#{@yields_port1_year28}" "#{@mean_port1_year29}" "#{@std_dev_port1_year29}" "#{@skew_port1_year29}" "#{@kurt_port1_year29}" "#{@correlation_port1_year29}" "#{@yields_port1_year29}" "#{@mean_port1_year30}" "#{@std_dev_port1_year30}" "#{@skew_port1_year30}" "#{@kurt_port1_year30}" "#{@correlation_port1_year30}" "#{@yields_port1_year30}"`)
      
      @python_forecat_port1 = FirstJob.perform_now(@starting_value, @income, @expense, @weights_port1, @mean_port1_year1, @std_dev_port1_year1, @skew_port1_year1, @kurt_port1_year1, @correlation_port1_year1, @yields_port1_year1, @mean_port1_year2, @std_dev_port1_year2, @skew_port1_year2, @kurt_port1_year2, @correlation_port1_year2, @yields_port1_year2, @mean_port1_year3, @std_dev_port1_year3, @skew_port1_year3, @kurt_port1_year3, @correlation_port1_year3, @yields_port1_year3, @mean_port1_year4, @std_dev_port1_year4, @skew_port1_year4, @kurt_port1_year4, @correlation_port1_year4, @yields_port1_year4, @mean_port1_year5, @std_dev_port1_year5, @skew_port1_year5, @kurt_port1_year5, @correlation_port1_year5, @yields_port1_year5, @mean_port1_year6, @std_dev_port1_year6, @skew_port1_year6, @kurt_port1_year6, @correlation_port1_year6, @yields_port1_year6, @mean_port1_year7, @std_dev_port1_year7, @skew_port1_year7, @kurt_port1_year7, @correlation_port1_year7, @yields_port1_year7, @mean_port1_year8, @std_dev_port1_year8, @skew_port1_year8, @kurt_port1_year8, @correlation_port1_year8, @yields_port1_year8, @mean_port1_year9, @std_dev_port1_year9, @skew_port1_year9, @kurt_port1_year9, @correlation_port1_year9, @yields_port1_year9, @mean_port1_year10, @std_dev_port1_year10, @skew_port1_year10, @kurt_port1_year10, @correlation_port1_year10, @yields_port1_year10, @mean_port1_year11, @std_dev_port1_year11, @skew_port1_year11, @kurt_port1_year11, @correlation_port1_year11, @yields_port1_year11, @mean_port1_year12, @std_dev_port1_year12, @skew_port1_year12, @kurt_port1_year12, @correlation_port1_year12, @yields_port1_year12, @mean_port1_year13, @std_dev_port1_year13, @skew_port1_year13, @kurt_port1_year13, @correlation_port1_year13, @yields_port1_year13, @mean_port1_year14, @std_dev_port1_year14, @skew_port1_year14, @kurt_port1_year14, @correlation_port1_year14, @yields_port1_year14, @mean_port1_year15, @std_dev_port1_year15, @skew_port1_year15, @kurt_port1_year15, @correlation_port1_year15, @yields_port1_year15, @mean_port1_year16, @std_dev_port1_year16, @skew_port1_year16, @kurt_port1_year16, @correlation_port1_year16, @yields_port1_year16, @mean_port1_year17, @std_dev_port1_year17, @skew_port1_year17, @kurt_port1_year17, @correlation_port1_year17, @yields_port1_year17, @mean_port1_year18, @std_dev_port1_year18, @skew_port1_year18, @kurt_port1_year18, @correlation_port1_year18, @yields_port1_year18, @mean_port1_year19, @std_dev_port1_year19, @skew_port1_year19, @kurt_port1_year19, @correlation_port1_year19, @yields_port1_year19, @mean_port1_year20, @std_dev_port1_year20, @skew_port1_year20, @kurt_port1_year20, @correlation_port1_year20, @yields_port1_year20, @mean_port1_year21, @std_dev_port1_year21, @skew_port1_year21, @kurt_port1_year21, @correlation_port1_year21, @yields_port1_year21, @mean_port1_year22, @std_dev_port1_year22, @skew_port1_year22, @kurt_port1_year22, @correlation_port1_year22, @yields_port1_year22, @mean_port1_year23, @std_dev_port1_year23, @skew_port1_year23, @kurt_port1_year23, @correlation_port1_year23, @yields_port1_year23, @mean_port1_year24, @std_dev_port1_year24, @skew_port1_year24, @kurt_port1_year24, @correlation_port1_year24, @yields_port1_year24, @mean_port1_year25, @std_dev_port1_year25, @skew_port1_year25, @kurt_port1_year25, @correlation_port1_year25, @yields_port1_year25, @mean_port1_year26, @std_dev_port1_year26, @skew_port1_year26, @kurt_port1_year26, @correlation_port1_year26, @yields_port1_year26, @mean_port1_year27, @std_dev_port1_year27, @skew_port1_year27, @kurt_port1_year27, @correlation_port1_year27, @yields_port1_year27, @mean_port1_year28, @std_dev_port1_year28, @skew_port1_year28, @kurt_port1_year28, @correlation_port1_year28, @yields_port1_year28, @mean_port1_year29, @std_dev_port1_year29, @skew_port1_year29, @kurt_port1_year29, @correlation_port1_year29, @yields_port1_year29, @mean_port1_year30, @std_dev_port1_year30, @skew_port1_year30, @kurt_port1_year30, @correlation_port1_year30, @yields_port1_year30)
    end
    if @the_forecast_input.portfolio2_id.blank?
      @python_forecat_port2 = 0
    else
      # @python_forecat_port2 = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port2}" "#{@mean_port2_year1}" "#{@std_dev_port2_year1}" "#{@skew_port2_year1}" "#{@kurt_port2_year1}" "#{@correlation_port2_year1}" "#{@yields_port2_year1}" "#{@mean_port2_year2}" "#{@std_dev_port2_year2}" "#{@skew_port2_year2}" "#{@kurt_port2_year2}" "#{@correlation_port2_year2}" "#{@yields_port2_year2}" "#{@mean_port2_year3}" "#{@std_dev_port2_year3}" "#{@skew_port2_year3}" "#{@kurt_port2_year3}" "#{@correlation_port2_year3}" "#{@yields_port2_year3}" "#{@mean_port2_year4}" "#{@std_dev_port2_year4}" "#{@skew_port2_year4}" "#{@kurt_port2_year4}" "#{@correlation_port2_year4}" "#{@yields_port2_year4}" "#{@mean_port2_year5}" "#{@std_dev_port2_year5}" "#{@skew_port2_year5}" "#{@kurt_port2_year5}" "#{@correlation_port2_year5}" "#{@yields_port2_year5}" "#{@mean_port2_year6}" "#{@std_dev_port2_year6}" "#{@skew_port2_year6}" "#{@kurt_port2_year6}" "#{@correlation_port2_year6}" "#{@yields_port2_year6}" "#{@mean_port2_year7}" "#{@std_dev_port2_year7}" "#{@skew_port2_year7}" "#{@kurt_port2_year7}" "#{@correlation_port2_year7}" "#{@yields_port2_year7}" "#{@mean_port2_year8}" "#{@std_dev_port2_year8}" "#{@skew_port2_year8}" "#{@kurt_port2_year8}" "#{@correlation_port2_year8}" "#{@yields_port2_year8}" "#{@mean_port2_year9}" "#{@std_dev_port2_year9}" "#{@skew_port2_year9}" "#{@kurt_port2_year9}" "#{@correlation_port2_year9}" "#{@yields_port2_year9}" "#{@mean_port2_year10}" "#{@std_dev_port2_year10}" "#{@skew_port2_year10}" "#{@kurt_port2_year10}" "#{@correlation_port2_year10}" "#{@yields_port2_year10}" "#{@mean_port2_year11}" "#{@std_dev_port2_year11}" "#{@skew_port2_year11}" "#{@kurt_port2_year11}" "#{@correlation_port2_year11}" "#{@yields_port2_year11}" "#{@mean_port2_year12}" "#{@std_dev_port2_year12}" "#{@skew_port2_year12}" "#{@kurt_port2_year12}" "#{@correlation_port2_year12}" "#{@yields_port2_year12}" "#{@mean_port2_year13}" "#{@std_dev_port2_year13}" "#{@skew_port2_year13}" "#{@kurt_port2_year13}" "#{@correlation_port2_year13}" "#{@yields_port2_year13}" "#{@mean_port2_year14}" "#{@std_dev_port2_year14}" "#{@skew_port2_year14}" "#{@kurt_port2_year14}" "#{@correlation_port2_year14}" "#{@yields_port2_year14}" "#{@mean_port2_year15}" "#{@std_dev_port2_year15}" "#{@skew_port2_year15}" "#{@kurt_port2_year15}" "#{@correlation_port2_year15}" "#{@yields_port2_year15}" "#{@mean_port2_year16}" "#{@std_dev_port2_year16}" "#{@skew_port2_year16}" "#{@kurt_port2_year16}" "#{@correlation_port2_year16}" "#{@yields_port2_year16}" "#{@mean_port2_year17}" "#{@std_dev_port2_year17}" "#{@skew_port2_year17}" "#{@kurt_port2_year17}" "#{@correlation_port2_year17}" "#{@yields_port2_year17}" "#{@mean_port2_year18}" "#{@std_dev_port2_year18}" "#{@skew_port2_year18}" "#{@kurt_port2_year18}" "#{@correlation_port2_year18}" "#{@yields_port2_year18}" "#{@mean_port2_year19}" "#{@std_dev_port2_year19}" "#{@skew_port2_year19}" "#{@kurt_port2_year19}" "#{@correlation_port2_year19}" "#{@yields_port2_year19}" "#{@mean_port2_year20}" "#{@std_dev_port2_year20}" "#{@skew_port2_year20}" "#{@kurt_port2_year20}" "#{@correlation_port2_year20}" "#{@yields_port2_year20}" "#{@mean_port2_year21}" "#{@std_dev_port2_year21}" "#{@skew_port2_year21}" "#{@kurt_port2_year21}" "#{@correlation_port2_year21}" "#{@yields_port2_year21}" "#{@mean_port2_year22}" "#{@std_dev_port2_year22}" "#{@skew_port2_year22}" "#{@kurt_port2_year22}" "#{@correlation_port2_year22}" "#{@yields_port2_year22}" "#{@mean_port2_year23}" "#{@std_dev_port2_year23}" "#{@skew_port2_year23}" "#{@kurt_port2_year23}" "#{@correlation_port2_year23}" "#{@yields_port2_year23}" "#{@mean_port2_year24}" "#{@std_dev_port2_year24}" "#{@skew_port2_year24}" "#{@kurt_port2_year24}" "#{@correlation_port2_year24}" "#{@yields_port2_year24}" "#{@mean_port2_year25}" "#{@std_dev_port2_year25}" "#{@skew_port2_year25}" "#{@kurt_port2_year25}" "#{@correlation_port2_year25}" "#{@yields_port2_year25}" "#{@mean_port2_year26}" "#{@std_dev_port2_year26}" "#{@skew_port2_year26}" "#{@kurt_port2_year26}" "#{@correlation_port2_year26}" "#{@yields_port2_year26}" "#{@mean_port2_year27}" "#{@std_dev_port2_year27}" "#{@skew_port2_year27}" "#{@kurt_port2_year27}" "#{@correlation_port2_year27}" "#{@yields_port2_year27}" "#{@mean_port2_year28}" "#{@std_dev_port2_year28}" "#{@skew_port2_year28}" "#{@kurt_port2_year28}" "#{@correlation_port2_year28}" "#{@yields_port2_year28}" "#{@mean_port2_year29}" "#{@std_dev_port2_year29}" "#{@skew_port2_year29}" "#{@kurt_port2_year29}" "#{@correlation_port2_year29}" "#{@yields_port2_year29}" "#{@mean_port2_year30}" "#{@std_dev_port2_year30}" "#{@skew_port2_year30}" "#{@kurt_port2_year30}" "#{@correlation_port2_year30}" "#{@yields_port2_year30}"`)
      @python_forecat_port2 = SecondJob.perform_now(@starting_value, @income, @expense, @weights_port2, @mean_port2_year1, @std_dev_port2_year1, @skew_port2_year1, @kurt_port2_year1, @correlation_port2_year1, @yields_port2_year1, @mean_port2_year2, @std_dev_port2_year2, @skew_port2_year2, @kurt_port2_year2, @correlation_port2_year2, @yields_port2_year2, @mean_port2_year3, @std_dev_port2_year3, @skew_port2_year3, @kurt_port2_year3, @correlation_port2_year3, @yields_port2_year3, @mean_port2_year4, @std_dev_port2_year4, @skew_port2_year4, @kurt_port2_year4, @correlation_port2_year4, @yields_port2_year4, @mean_port2_year5, @std_dev_port2_year5, @skew_port2_year5, @kurt_port2_year5, @correlation_port2_year5, @yields_port2_year5, @mean_port2_year6, @std_dev_port2_year6, @skew_port2_year6, @kurt_port2_year6, @correlation_port2_year6, @yields_port2_year6, @mean_port2_year7, @std_dev_port2_year7, @skew_port2_year7, @kurt_port2_year7, @correlation_port2_year7, @yields_port2_year7, @mean_port2_year8, @std_dev_port2_year8, @skew_port2_year8, @kurt_port2_year8, @correlation_port2_year8, @yields_port2_year8, @mean_port2_year9, @std_dev_port2_year9, @skew_port2_year9, @kurt_port2_year9, @correlation_port2_year9, @yields_port2_year9, @mean_port2_year10, @std_dev_port2_year10, @skew_port2_year10, @kurt_port2_year10, @correlation_port2_year10, @yields_port2_year10, @mean_port2_year11, @std_dev_port2_year11, @skew_port2_year11, @kurt_port2_year11, @correlation_port2_year11, @yields_port2_year11, @mean_port2_year12, @std_dev_port2_year12, @skew_port2_year12, @kurt_port2_year12, @correlation_port2_year12, @yields_port2_year12, @mean_port2_year13, @std_dev_port2_year13, @skew_port2_year13, @kurt_port2_year13, @correlation_port2_year13, @yields_port2_year13, @mean_port2_year14, @std_dev_port2_year14, @skew_port2_year14, @kurt_port2_year14, @correlation_port2_year14, @yields_port2_year14, @mean_port2_year15, @std_dev_port2_year15, @skew_port2_year15, @kurt_port2_year15, @correlation_port2_year15, @yields_port2_year15, @mean_port2_year16, @std_dev_port2_year16, @skew_port2_year16, @kurt_port2_year16, @correlation_port2_year16, @yields_port2_year16, @mean_port2_year17, @std_dev_port2_year17, @skew_port2_year17, @kurt_port2_year17, @correlation_port2_year17, @yields_port2_year17, @mean_port2_year18, @std_dev_port2_year18, @skew_port2_year18, @kurt_port2_year18, @correlation_port2_year18, @yields_port2_year18, @mean_port2_year19, @std_dev_port2_year19, @skew_port2_year19, @kurt_port2_year19, @correlation_port2_year19, @yields_port2_year19, @mean_port2_year20, @std_dev_port2_year20, @skew_port2_year20, @kurt_port2_year20, @correlation_port2_year20, @yields_port2_year20, @mean_port2_year21, @std_dev_port2_year21, @skew_port2_year21, @kurt_port2_year21, @correlation_port2_year21, @yields_port2_year21, @mean_port2_year22, @std_dev_port2_year22, @skew_port2_year22, @kurt_port2_year22, @correlation_port2_year22, @yields_port2_year22, @mean_port2_year23, @std_dev_port2_year23, @skew_port2_year23, @kurt_port2_year23, @correlation_port2_year23, @yields_port2_year23, @mean_port2_year24, @std_dev_port2_year24, @skew_port2_year24, @kurt_port2_year24, @correlation_port2_year24, @yields_port2_year24, @mean_port2_year25, @std_dev_port2_year25, @skew_port2_year25, @kurt_port2_year25, @correlation_port2_year25, @yields_port2_year25, @mean_port2_year26, @std_dev_port2_year26, @skew_port2_year26, @kurt_port2_year26, @correlation_port2_year26, @yields_port2_year26, @mean_port2_year27, @std_dev_port2_year27, @skew_port2_year27, @kurt_port2_year27, @correlation_port2_year27, @yields_port2_year27, @mean_port2_year28, @std_dev_port2_year28, @skew_port2_year28, @kurt_port2_year28, @correlation_port2_year28, @yields_port2_year28, @mean_port2_year29, @std_dev_port2_year29, @skew_port2_year29, @kurt_port2_year29, @correlation_port2_year29, @yields_port2_year29, @mean_port2_year30, @std_dev_port2_year30, @skew_port2_year30, @kurt_port2_year30, @correlation_port2_year30, @yields_port2_year30)
    end
    if @the_forecast_input.portfolio3_id.blank?
      @python_forecat_port3 = 0
    else
      # @python_forecat_port3 = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port3}" "#{@mean_port3_year1}" "#{@std_dev_port3_year1}" "#{@skew_port3_year1}" "#{@kurt_port3_year1}" "#{@correlation_port3_year1}" "#{@yields_port3_year1}" "#{@mean_port3_year2}" "#{@std_dev_port3_year2}" "#{@skew_port3_year2}" "#{@kurt_port3_year2}" "#{@correlation_port3_year2}" "#{@yields_port3_year2}" "#{@mean_port3_year3}" "#{@std_dev_port3_year3}" "#{@skew_port3_year3}" "#{@kurt_port3_year3}" "#{@correlation_port3_year3}" "#{@yields_port3_year3}" "#{@mean_port3_year4}" "#{@std_dev_port3_year4}" "#{@skew_port3_year4}" "#{@kurt_port3_year4}" "#{@correlation_port3_year4}" "#{@yields_port3_year4}" "#{@mean_port3_year5}" "#{@std_dev_port3_year5}" "#{@skew_port3_year5}" "#{@kurt_port3_year5}" "#{@correlation_port3_year5}" "#{@yields_port3_year5}" "#{@mean_port3_year6}" "#{@std_dev_port3_year6}" "#{@skew_port3_year6}" "#{@kurt_port3_year6}" "#{@correlation_port3_year6}" "#{@yields_port3_year6}" "#{@mean_port3_year7}" "#{@std_dev_port3_year7}" "#{@skew_port3_year7}" "#{@kurt_port3_year7}" "#{@correlation_port3_year7}" "#{@yields_port3_year7}" "#{@mean_port3_year8}" "#{@std_dev_port3_year8}" "#{@skew_port3_year8}" "#{@kurt_port3_year8}" "#{@correlation_port3_year8}" "#{@yields_port3_year8}" "#{@mean_port3_year9}" "#{@std_dev_port3_year9}" "#{@skew_port3_year9}" "#{@kurt_port3_year9}" "#{@correlation_port3_year9}" "#{@yields_port3_year9}" "#{@mean_port3_year10}" "#{@std_dev_port3_year10}" "#{@skew_port3_year10}" "#{@kurt_port3_year10}" "#{@correlation_port3_year10}" "#{@yields_port3_year10}" "#{@mean_port3_year11}" "#{@std_dev_port3_year11}" "#{@skew_port3_year11}" "#{@kurt_port3_year11}" "#{@correlation_port3_year11}" "#{@yields_port3_year11}" "#{@mean_port3_year12}" "#{@std_dev_port3_year12}" "#{@skew_port3_year12}" "#{@kurt_port3_year12}" "#{@correlation_port3_year12}" "#{@yields_port3_year12}" "#{@mean_port3_year13}" "#{@std_dev_port3_year13}" "#{@skew_port3_year13}" "#{@kurt_port3_year13}" "#{@correlation_port3_year13}" "#{@yields_port3_year13}" "#{@mean_port3_year14}" "#{@std_dev_port3_year14}" "#{@skew_port3_year14}" "#{@kurt_port3_year14}" "#{@correlation_port3_year14}" "#{@yields_port3_year14}" "#{@mean_port3_year15}" "#{@std_dev_port3_year15}" "#{@skew_port3_year15}" "#{@kurt_port3_year15}" "#{@correlation_port3_year15}" "#{@yields_port3_year15}" "#{@mean_port3_year16}" "#{@std_dev_port3_year16}" "#{@skew_port3_year16}" "#{@kurt_port3_year16}" "#{@correlation_port3_year16}" "#{@yields_port3_year16}" "#{@mean_port3_year17}" "#{@std_dev_port3_year17}" "#{@skew_port3_year17}" "#{@kurt_port3_year17}" "#{@correlation_port3_year17}" "#{@yields_port3_year17}" "#{@mean_port3_year18}" "#{@std_dev_port3_year18}" "#{@skew_port3_year18}" "#{@kurt_port3_year18}" "#{@correlation_port3_year18}" "#{@yields_port3_year18}" "#{@mean_port3_year19}" "#{@std_dev_port3_year19}" "#{@skew_port3_year19}" "#{@kurt_port3_year19}" "#{@correlation_port3_year19}" "#{@yields_port3_year19}" "#{@mean_port3_year20}" "#{@std_dev_port3_year20}" "#{@skew_port3_year20}" "#{@kurt_port3_year20}" "#{@correlation_port3_year20}" "#{@yields_port3_year20}" "#{@mean_port3_year21}" "#{@std_dev_port3_year21}" "#{@skew_port3_year21}" "#{@kurt_port3_year21}" "#{@correlation_port3_year21}" "#{@yields_port3_year21}" "#{@mean_port3_year22}" "#{@std_dev_port3_year22}" "#{@skew_port3_year22}" "#{@kurt_port3_year22}" "#{@correlation_port3_year22}" "#{@yields_port3_year22}" "#{@mean_port3_year23}" "#{@std_dev_port3_year23}" "#{@skew_port3_year23}" "#{@kurt_port3_year23}" "#{@correlation_port3_year23}" "#{@yields_port3_year23}" "#{@mean_port3_year24}" "#{@std_dev_port3_year24}" "#{@skew_port3_year24}" "#{@kurt_port3_year24}" "#{@correlation_port3_year24}" "#{@yields_port3_year24}" "#{@mean_port3_year25}" "#{@std_dev_port3_year25}" "#{@skew_port3_year25}" "#{@kurt_port3_year25}" "#{@correlation_port3_year25}" "#{@yields_port3_year25}" "#{@mean_port3_year26}" "#{@std_dev_port3_year26}" "#{@skew_port3_year26}" "#{@kurt_port3_year26}" "#{@correlation_port3_year26}" "#{@yields_port3_year26}" "#{@mean_port3_year27}" "#{@std_dev_port3_year27}" "#{@skew_port3_year27}" "#{@kurt_port3_year27}" "#{@correlation_port3_year27}" "#{@yields_port3_year27}" "#{@mean_port3_year28}" "#{@std_dev_port3_year28}" "#{@skew_port3_year28}" "#{@kurt_port3_year28}" "#{@correlation_port3_year28}" "#{@yields_port3_year28}" "#{@mean_port3_year29}" "#{@std_dev_port3_year29}" "#{@skew_port3_year29}" "#{@kurt_port3_year29}" "#{@correlation_port3_year29}" "#{@yields_port3_year29}" "#{@mean_port3_year30}" "#{@std_dev_port3_year30}" "#{@skew_port3_year30}" "#{@kurt_port3_year30}" "#{@correlation_port3_year30}" "#{@yields_port3_year30}"`)
      @python_forecat_port3 = ThirdJob.perform_now(@starting_value, @income, @expense, @weights_port3, @mean_port3_year1, @std_dev_port3_year1, @skew_port3_year1, @kurt_port3_year1, @correlation_port3_year1, @yields_port3_year1, @mean_port3_year2, @std_dev_port3_year2, @skew_port3_year2, @kurt_port3_year2, @correlation_port3_year2, @yields_port3_year2, @mean_port3_year3, @std_dev_port3_year3, @skew_port3_year3, @kurt_port3_year3, @correlation_port3_year3, @yields_port3_year3, @mean_port3_year4, @std_dev_port3_year4, @skew_port3_year4, @kurt_port3_year4, @correlation_port3_year4, @yields_port3_year4, @mean_port3_year5, @std_dev_port3_year5, @skew_port3_year5, @kurt_port3_year5, @correlation_port3_year5, @yields_port3_year5, @mean_port3_year6, @std_dev_port3_year6, @skew_port3_year6, @kurt_port3_year6, @correlation_port3_year6, @yields_port3_year6, @mean_port3_year7, @std_dev_port3_year7, @skew_port3_year7, @kurt_port3_year7, @correlation_port3_year7, @yields_port3_year7, @mean_port3_year8, @std_dev_port3_year8, @skew_port3_year8, @kurt_port3_year8, @correlation_port3_year8, @yields_port3_year8, @mean_port3_year9, @std_dev_port3_year9, @skew_port3_year9, @kurt_port3_year9, @correlation_port3_year9, @yields_port3_year9, @mean_port3_year10, @std_dev_port3_year10, @skew_port3_year10, @kurt_port3_year10, @correlation_port3_year10, @yields_port3_year10, @mean_port3_year11, @std_dev_port3_year11, @skew_port3_year11, @kurt_port3_year11, @correlation_port3_year11, @yields_port3_year11, @mean_port3_year12, @std_dev_port3_year12, @skew_port3_year12, @kurt_port3_year12, @correlation_port3_year12, @yields_port3_year12, @mean_port3_year13, @std_dev_port3_year13, @skew_port3_year13, @kurt_port3_year13, @correlation_port3_year13, @yields_port3_year13, @mean_port3_year14, @std_dev_port3_year14, @skew_port3_year14, @kurt_port3_year14, @correlation_port3_year14, @yields_port3_year14, @mean_port3_year15, @std_dev_port3_year15, @skew_port3_year15, @kurt_port3_year15, @correlation_port3_year15, @yields_port3_year15, @mean_port3_year16, @std_dev_port3_year16, @skew_port3_year16, @kurt_port3_year16, @correlation_port3_year16, @yields_port3_year16, @mean_port3_year17, @std_dev_port3_year17, @skew_port3_year17, @kurt_port3_year17, @correlation_port3_year17, @yields_port3_year17, @mean_port3_year18, @std_dev_port3_year18, @skew_port3_year18, @kurt_port3_year18, @correlation_port3_year18, @yields_port3_year18, @mean_port3_year19, @std_dev_port3_year19, @skew_port3_year19, @kurt_port3_year19, @correlation_port3_year19, @yields_port3_year19, @mean_port3_year20, @std_dev_port3_year20, @skew_port3_year20, @kurt_port3_year20, @correlation_port3_year20, @yields_port3_year20, @mean_port3_year21, @std_dev_port3_year21, @skew_port3_year21, @kurt_port3_year21, @correlation_port3_year21, @yields_port3_year21, @mean_port3_year22, @std_dev_port3_year22, @skew_port3_year22, @kurt_port3_year22, @correlation_port3_year22, @yields_port3_year22, @mean_port3_year23, @std_dev_port3_year23, @skew_port3_year23, @kurt_port3_year23, @correlation_port3_year23, @yields_port3_year23, @mean_port3_year24, @std_dev_port3_year24, @skew_port3_year24, @kurt_port3_year24, @correlation_port3_year24, @yields_port3_year24, @mean_port3_year25, @std_dev_port3_year25, @skew_port3_year25, @kurt_port3_year25, @correlation_port3_year25, @yields_port3_year25, @mean_port3_year26, @std_dev_port3_year26, @skew_port3_year26, @kurt_port3_year26, @correlation_port3_year26, @yields_port3_year26, @mean_port3_year27, @std_dev_port3_year27, @skew_port3_year27, @kurt_port3_year27, @correlation_port3_year27, @yields_port3_year27, @mean_port3_year28, @std_dev_port3_year28, @skew_port3_year28, @kurt_port3_year28, @correlation_port3_year28, @yields_port3_year28, @mean_port3_year29, @std_dev_port3_year29, @skew_port3_year29, @kurt_port3_year29, @correlation_port3_year29, @yields_port3_year29, @mean_port3_year30, @std_dev_port3_year30, @skew_port3_year30, @kurt_port3_year30, @correlation_port3_year30, @yields_port3_year30)
    end
    
    if @the_forecast_input.portfolio4_id.blank?
    @python_forecat_port4 = 0
    else
    @python_forecat_port4 = 0
    # @python_forecat_port4 = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port4}" "#{@mean_port4_year1}" "#{@std_dev_port4_year1}" "#{@skew_port4_year1}" "#{@kurt_port4_year1}" "#{@correlation_port4_year1}" "#{@yields_port4_year1}" "#{@mean_port4_year2}" "#{@std_dev_port4_year2}" "#{@skew_port4_year2}" "#{@kurt_port4_year2}" "#{@correlation_port4_year2}" "#{@yields_port4_year2}" "#{@mean_port4_year3}" "#{@std_dev_port4_year3}" "#{@skew_port4_year3}" "#{@kurt_port4_year3}" "#{@correlation_port4_year3}" "#{@yields_port4_year3}" "#{@mean_port4_year4}" "#{@std_dev_port4_year4}" "#{@skew_port4_year4}" "#{@kurt_port4_year4}" "#{@correlation_port4_year4}" "#{@yields_port4_year4}" "#{@mean_port4_year5}" "#{@std_dev_port4_year5}" "#{@skew_port4_year5}" "#{@kurt_port4_year5}" "#{@correlation_port4_year5}" "#{@yields_port4_year5}" "#{@mean_port4_year6}" "#{@std_dev_port4_year6}" "#{@skew_port4_year6}" "#{@kurt_port4_year6}" "#{@correlation_port4_year6}" "#{@yields_port4_year6}" "#{@mean_port4_year7}" "#{@std_dev_port4_year7}" "#{@skew_port4_year7}" "#{@kurt_port4_year7}" "#{@correlation_port4_year7}" "#{@yields_port4_year7}" "#{@mean_port4_year8}" "#{@std_dev_port4_year8}" "#{@skew_port4_year8}" "#{@kurt_port4_year8}" "#{@correlation_port4_year8}" "#{@yields_port4_year8}" "#{@mean_port4_year9}" "#{@std_dev_port4_year9}" "#{@skew_port4_year9}" "#{@kurt_port4_year9}" "#{@correlation_port4_year9}" "#{@yields_port4_year9}" "#{@mean_port4_year10}" "#{@std_dev_port4_year10}" "#{@skew_port4_year10}" "#{@kurt_port4_year10}" "#{@correlation_port4_year10}" "#{@yields_port4_year10}" "#{@mean_port4_year11}" "#{@std_dev_port4_year11}" "#{@skew_port4_year11}" "#{@kurt_port4_year11}" "#{@correlation_port4_year11}" "#{@yields_port4_year11}" "#{@mean_port4_year12}" "#{@std_dev_port4_year12}" "#{@skew_port4_year12}" "#{@kurt_port4_year12}" "#{@correlation_port4_year12}" "#{@yields_port4_year12}" "#{@mean_port4_year13}" "#{@std_dev_port4_year13}" "#{@skew_port4_year13}" "#{@kurt_port4_year13}" "#{@correlation_port4_year13}" "#{@yields_port4_year13}" "#{@mean_port4_year14}" "#{@std_dev_port4_year14}" "#{@skew_port4_year14}" "#{@kurt_port4_year14}" "#{@correlation_port4_year14}" "#{@yields_port4_year14}" "#{@mean_port4_year15}" "#{@std_dev_port4_year15}" "#{@skew_port4_year15}" "#{@kurt_port4_year15}" "#{@correlation_port4_year15}" "#{@yields_port4_year15}" "#{@mean_port4_year16}" "#{@std_dev_port4_year16}" "#{@skew_port4_year16}" "#{@kurt_port4_year16}" "#{@correlation_port4_year16}" "#{@yields_port4_year16}" "#{@mean_port4_year17}" "#{@std_dev_port4_year17}" "#{@skew_port4_year17}" "#{@kurt_port4_year17}" "#{@correlation_port4_year17}" "#{@yields_port4_year17}" "#{@mean_port4_year18}" "#{@std_dev_port4_year18}" "#{@skew_port4_year18}" "#{@kurt_port4_year18}" "#{@correlation_port4_year18}" "#{@yields_port4_year18}" "#{@mean_port4_year19}" "#{@std_dev_port4_year19}" "#{@skew_port4_year19}" "#{@kurt_port4_year19}" "#{@correlation_port4_year19}" "#{@yields_port4_year19}" "#{@mean_port4_year20}" "#{@std_dev_port4_year20}" "#{@skew_port4_year20}" "#{@kurt_port4_year20}" "#{@correlation_port4_year20}" "#{@yields_port4_year20}" "#{@mean_port4_year21}" "#{@std_dev_port4_year21}" "#{@skew_port4_year21}" "#{@kurt_port4_year21}" "#{@correlation_port4_year21}" "#{@yields_port4_year21}" "#{@mean_port4_year22}" "#{@std_dev_port4_year22}" "#{@skew_port4_year22}" "#{@kurt_port4_year22}" "#{@correlation_port4_year22}" "#{@yields_port4_year22}" "#{@mean_port4_year23}" "#{@std_dev_port4_year23}" "#{@skew_port4_year23}" "#{@kurt_port4_year23}" "#{@correlation_port4_year23}" "#{@yields_port4_year23}" "#{@mean_port4_year24}" "#{@std_dev_port4_year24}" "#{@skew_port4_year24}" "#{@kurt_port4_year24}" "#{@correlation_port4_year24}" "#{@yields_port4_year24}" "#{@mean_port4_year25}" "#{@std_dev_port4_year25}" "#{@skew_port4_year25}" "#{@kurt_port4_year25}" "#{@correlation_port4_year25}" "#{@yields_port4_year25}" "#{@mean_port4_year26}" "#{@std_dev_port4_year26}" "#{@skew_port4_year26}" "#{@kurt_port4_year26}" "#{@correlation_port4_year26}" "#{@yields_port4_year26}" "#{@mean_port4_year27}" "#{@std_dev_port4_year27}" "#{@skew_port4_year27}" "#{@kurt_port4_year27}" "#{@correlation_port4_year27}" "#{@yields_port4_year27}" "#{@mean_port4_year28}" "#{@std_dev_port4_year28}" "#{@skew_port4_year28}" "#{@kurt_port4_year28}" "#{@correlation_port4_year28}" "#{@yields_port4_year28}" "#{@mean_port4_year29}" "#{@std_dev_port4_year29}" "#{@skew_port4_year29}" "#{@kurt_port4_year29}" "#{@correlation_port4_year29}" "#{@yields_port4_year29}" "#{@mean_port4_year30}" "#{@std_dev_port4_year30}" "#{@skew_port4_year30}" "#{@kurt_port4_year30}" "#{@correlation_port4_year30}" "#{@yields_port4_year30}"`)
    # @python_forecat_port4 = FourthJob.perform_now(@starting_value, @income, @expense, @weights_port4, @mean_port4_year1, @std_dev_port4_year1, @skew_port4_year1, @kurt_port4_year1, @correlation_port4_year1, @yields_port4_year1, @mean_port4_year2, @std_dev_port4_year2, @skew_port4_year2, @kurt_port4_year2, @correlation_port4_year2, @yields_port4_year2, @mean_port4_year3, @std_dev_port4_year3, @skew_port4_year3, @kurt_port4_year3, @correlation_port4_year3, @yields_port4_year3, @mean_port4_year4, @std_dev_port4_year4, @skew_port4_year4, @kurt_port4_year4, @correlation_port4_year4, @yields_port4_year4, @mean_port4_year5, @std_dev_port4_year5, @skew_port4_year5, @kurt_port4_year5, @correlation_port4_year5, @yields_port4_year5, @mean_port4_year6, @std_dev_port4_year6, @skew_port4_year6, @kurt_port4_year6, @correlation_port4_year6, @yields_port4_year6, @mean_port4_year7, @std_dev_port4_year7, @skew_port4_year7, @kurt_port4_year7, @correlation_port4_year7, @yields_port4_year7, @mean_port4_year8, @std_dev_port4_year8, @skew_port4_year8, @kurt_port4_year8, @correlation_port4_year8, @yields_port4_year8, @mean_port4_year9, @std_dev_port4_year9, @skew_port4_year9, @kurt_port4_year9, @correlation_port4_year9, @yields_port4_year9, @mean_port4_year10, @std_dev_port4_year10, @skew_port4_year10, @kurt_port4_year10, @correlation_port4_year10, @yields_port4_year10, @mean_port4_year11, @std_dev_port4_year11, @skew_port4_year11, @kurt_port4_year11, @correlation_port4_year11, @yields_port4_year11, @mean_port4_year12, @std_dev_port4_year12, @skew_port4_year12, @kurt_port4_year12, @correlation_port4_year12, @yields_port4_year12, @mean_port4_year13, @std_dev_port4_year13, @skew_port4_year13, @kurt_port4_year13, @correlation_port4_year13, @yields_port4_year13, @mean_port4_year14, @std_dev_port4_year14, @skew_port4_year14, @kurt_port4_year14, @correlation_port4_year14, @yields_port4_year14, @mean_port4_year15, @std_dev_port4_year15, @skew_port4_year15, @kurt_port4_year15, @correlation_port4_year15, @yields_port4_year15, @mean_port4_year16, @std_dev_port4_year16, @skew_port4_year16, @kurt_port4_year16, @correlation_port4_year16, @yields_port4_year16, @mean_port4_year17, @std_dev_port4_year17, @skew_port4_year17, @kurt_port4_year17, @correlation_port4_year17, @yields_port4_year17, @mean_port4_year18, @std_dev_port4_year18, @skew_port4_year18, @kurt_port4_year18, @correlation_port4_year18, @yields_port4_year18, @mean_port4_year19, @std_dev_port4_year19, @skew_port4_year19, @kurt_port4_year19, @correlation_port4_year19, @yields_port4_year19, @mean_port4_year20, @std_dev_port4_year20, @skew_port4_year20, @kurt_port4_year20, @correlation_port4_year20, @yields_port4_year20, @mean_port4_year21, @std_dev_port4_year21, @skew_port4_year21, @kurt_port4_year21, @correlation_port4_year21, @yields_port4_year21, @mean_port4_year22, @std_dev_port4_year22, @skew_port4_year22, @kurt_port4_year22, @correlation_port4_year22, @yields_port4_year22, @mean_port4_year23, @std_dev_port4_year23, @skew_port4_year23, @kurt_port4_year23, @correlation_port4_year23, @yields_port4_year23, @mean_port4_year24, @std_dev_port4_year24, @skew_port4_year24, @kurt_port4_year24, @correlation_port4_year24, @yields_port4_year24, @mean_port4_year25, @std_dev_port4_year25, @skew_port4_year25, @kurt_port4_year25, @correlation_port4_year25, @yields_port4_year25, @mean_port4_year26, @std_dev_port4_year26, @skew_port4_year26, @kurt_port4_year26, @correlation_port4_year26, @yields_port4_year26, @mean_port4_year27, @std_dev_port4_year27, @skew_port4_year27, @kurt_port4_year27, @correlation_port4_year27, @yields_port4_year27, @mean_port4_year28, @std_dev_port4_year28, @skew_port4_year28, @kurt_port4_year28, @correlation_port4_year28, @yields_port4_year28, @mean_port4_year29, @std_dev_port4_year29, @skew_port4_year29, @kurt_port4_year29, @correlation_port4_year29, @yields_port4_year29, @mean_port4_year30, @std_dev_port4_year30, @skew_port4_year30, @kurt_port4_year30, @correlation_port4_year30, @yields_port4_year30)
    end

    # require 'parallel'
    # array1 = [@starting_value, @income, @expense, @weights_port1, @mean_port1_year1, @std_dev_port1_year1, @skew_port1_year1, @kurt_port1_year1, @correlation_port1_year1, @yields_port1_year1, @mean_port1_year2, @std_dev_port1_year2, @skew_port1_year2, @kurt_port1_year2, @correlation_port1_year2, @yields_port1_year2, @mean_port1_year3, @std_dev_port1_year3, @skew_port1_year3, @kurt_port1_year3, @correlation_port1_year3, @yields_port1_year3, @mean_port1_year4, @std_dev_port1_year4, @skew_port1_year4, @kurt_port1_year4, @correlation_port1_year4, @yields_port1_year4, @mean_port1_year5, @std_dev_port1_year5, @skew_port1_year5, @kurt_port1_year5, @correlation_port1_year5, @yields_port1_year5, @mean_port1_year6, @std_dev_port1_year6, @skew_port1_year6, @kurt_port1_year6, @correlation_port1_year6, @yields_port1_year6, @mean_port1_year7, @std_dev_port1_year7, @skew_port1_year7, @kurt_port1_year7, @correlation_port1_year7, @yields_port1_year7, @mean_port1_year8, @std_dev_port1_year8, @skew_port1_year8, @kurt_port1_year8, @correlation_port1_year8, @yields_port1_year8, @mean_port1_year9, @std_dev_port1_year9, @skew_port1_year9, @kurt_port1_year9, @correlation_port1_year9, @yields_port1_year9, @mean_port1_year10, @std_dev_port1_year10, @skew_port1_year10, @kurt_port1_year10, @correlation_port1_year10, @yields_port1_year10, @mean_port1_year11, @std_dev_port1_year11, @skew_port1_year11, @kurt_port1_year11, @correlation_port1_year11, @yields_port1_year11, @mean_port1_year12, @std_dev_port1_year12, @skew_port1_year12, @kurt_port1_year12, @correlation_port1_year12, @yields_port1_year12, @mean_port1_year13, @std_dev_port1_year13, @skew_port1_year13, @kurt_port1_year13, @correlation_port1_year13, @yields_port1_year13, @mean_port1_year14, @std_dev_port1_year14, @skew_port1_year14, @kurt_port1_year14, @correlation_port1_year14, @yields_port1_year14, @mean_port1_year15, @std_dev_port1_year15, @skew_port1_year15, @kurt_port1_year15, @correlation_port1_year15, @yields_port1_year15, @mean_port1_year16, @std_dev_port1_year16, @skew_port1_year16, @kurt_port1_year16, @correlation_port1_year16, @yields_port1_year16, @mean_port1_year17, @std_dev_port1_year17, @skew_port1_year17, @kurt_port1_year17, @correlation_port1_year17, @yields_port1_year17, @mean_port1_year18, @std_dev_port1_year18, @skew_port1_year18, @kurt_port1_year18, @correlation_port1_year18, @yields_port1_year18, @mean_port1_year19, @std_dev_port1_year19, @skew_port1_year19, @kurt_port1_year19, @correlation_port1_year19, @yields_port1_year19, @mean_port1_year20, @std_dev_port1_year20, @skew_port1_year20, @kurt_port1_year20, @correlation_port1_year20, @yields_port1_year20, @mean_port1_year21, @std_dev_port1_year21, @skew_port1_year21, @kurt_port1_year21, @correlation_port1_year21, @yields_port1_year21, @mean_port1_year22, @std_dev_port1_year22, @skew_port1_year22, @kurt_port1_year22, @correlation_port1_year22, @yields_port1_year22, @mean_port1_year23, @std_dev_port1_year23, @skew_port1_year23, @kurt_port1_year23, @correlation_port1_year23, @yields_port1_year23, @mean_port1_year24, @std_dev_port1_year24, @skew_port1_year24, @kurt_port1_year24, @correlation_port1_year24, @yields_port1_year24, @mean_port1_year25, @std_dev_port1_year25, @skew_port1_year25, @kurt_port1_year25, @correlation_port1_year25, @yields_port1_year25, @mean_port1_year26, @std_dev_port1_year26, @skew_port1_year26, @kurt_port1_year26, @correlation_port1_year26, @yields_port1_year26, @mean_port1_year27, @std_dev_port1_year27, @skew_port1_year27, @kurt_port1_year27, @correlation_port1_year27, @yields_port1_year27, @mean_port1_year28, @std_dev_port1_year28, @skew_port1_year28, @kurt_port1_year28, @correlation_port1_year28, @yields_port1_year28, @mean_port1_year29, @std_dev_port1_year29, @skew_port1_year29, @kurt_port1_year29, @correlation_port1_year29, @yields_port1_year29, @mean_port1_year30, @std_dev_port1_year30, @skew_port1_year30, @kurt_port1_year30, @correlation_port1_year30, @yields_port1_year30]
    # array2 = [@starting_value, @income, @expense, @weights_port2, @mean_port2_year1, @std_dev_port2_year1, @skew_port2_year1, @kurt_port2_year1, @correlation_port2_year1, @yields_port2_year1, @mean_port2_year2, @std_dev_port2_year2, @skew_port2_year2, @kurt_port2_year2, @correlation_port2_year2, @yields_port2_year2, @mean_port2_year3, @std_dev_port2_year3, @skew_port2_year3, @kurt_port2_year3, @correlation_port2_year3, @yields_port2_year3, @mean_port2_year4, @std_dev_port2_year4, @skew_port2_year4, @kurt_port2_year4, @correlation_port2_year4, @yields_port2_year4, @mean_port2_year5, @std_dev_port2_year5, @skew_port2_year5, @kurt_port2_year5, @correlation_port2_year5, @yields_port2_year5, @mean_port2_year6, @std_dev_port2_year6, @skew_port2_year6, @kurt_port2_year6, @correlation_port2_year6, @yields_port2_year6, @mean_port2_year7, @std_dev_port2_year7, @skew_port2_year7, @kurt_port2_year7, @correlation_port2_year7, @yields_port2_year7, @mean_port2_year8, @std_dev_port2_year8, @skew_port2_year8, @kurt_port2_year8, @correlation_port2_year8, @yields_port2_year8, @mean_port2_year9, @std_dev_port2_year9, @skew_port2_year9, @kurt_port2_year9, @correlation_port2_year9, @yields_port2_year9, @mean_port2_year10, @std_dev_port2_year10, @skew_port2_year10, @kurt_port2_year10, @correlation_port2_year10, @yields_port2_year10, @mean_port2_year11, @std_dev_port2_year11, @skew_port2_year11, @kurt_port2_year11, @correlation_port2_year11, @yields_port2_year11, @mean_port2_year12, @std_dev_port2_year12, @skew_port2_year12, @kurt_port2_year12, @correlation_port2_year12, @yields_port2_year12, @mean_port2_year13, @std_dev_port2_year13, @skew_port2_year13, @kurt_port2_year13, @correlation_port2_year13, @yields_port2_year13, @mean_port2_year14, @std_dev_port2_year14, @skew_port2_year14, @kurt_port2_year14, @correlation_port2_year14, @yields_port2_year14, @mean_port2_year15, @std_dev_port2_year15, @skew_port2_year15, @kurt_port2_year15, @correlation_port2_year15, @yields_port2_year15, @mean_port2_year16, @std_dev_port2_year16, @skew_port2_year16, @kurt_port2_year16, @correlation_port2_year16, @yields_port2_year16, @mean_port2_year17, @std_dev_port2_year17, @skew_port2_year17, @kurt_port2_year17, @correlation_port2_year17, @yields_port2_year17, @mean_port2_year18, @std_dev_port2_year18, @skew_port2_year18, @kurt_port2_year18, @correlation_port2_year18, @yields_port2_year18, @mean_port2_year19, @std_dev_port2_year19, @skew_port2_year19, @kurt_port2_year19, @correlation_port2_year19, @yields_port2_year19, @mean_port2_year20, @std_dev_port2_year20, @skew_port2_year20, @kurt_port2_year20, @correlation_port2_year20, @yields_port2_year20, @mean_port2_year21, @std_dev_port2_year21, @skew_port2_year21, @kurt_port2_year21, @correlation_port2_year21, @yields_port2_year21, @mean_port2_year22, @std_dev_port2_year22, @skew_port2_year22, @kurt_port2_year22, @correlation_port2_year22, @yields_port2_year22, @mean_port2_year23, @std_dev_port2_year23, @skew_port2_year23, @kurt_port2_year23, @correlation_port2_year23, @yields_port2_year23, @mean_port2_year24, @std_dev_port2_year24, @skew_port2_year24, @kurt_port2_year24, @correlation_port2_year24, @yields_port2_year24, @mean_port2_year25, @std_dev_port2_year25, @skew_port2_year25, @kurt_port2_year25, @correlation_port2_year25, @yields_port2_year25, @mean_port2_year26, @std_dev_port2_year26, @skew_port2_year26, @kurt_port2_year26, @correlation_port2_year26, @yields_port2_year26, @mean_port2_year27, @std_dev_port2_year27, @skew_port2_year27, @kurt_port2_year27, @correlation_port2_year27, @yields_port2_year27, @mean_port2_year28, @std_dev_port2_year28, @skew_port2_year28, @kurt_port2_year28, @correlation_port2_year28, @yields_port2_year28, @mean_port2_year29, @std_dev_port2_year29, @skew_port2_year29, @kurt_port2_year29, @correlation_port2_year29, @yields_port2_year29, @mean_port2_year30, @std_dev_port2_year30, @skew_port2_year30, @kurt_port2_year30, @correlation_port2_year30, @yields_port2_year30]
    # array3 = [@starting_value, @income, @expense, @weights_port3, @mean_port3_year1, @std_dev_port3_year1, @skew_port3_year1, @kurt_port3_year1, @correlation_port3_year1, @yields_port3_year1, @mean_port3_year2, @std_dev_port3_year2, @skew_port3_year2, @kurt_port3_year2, @correlation_port3_year2, @yields_port3_year2, @mean_port3_year3, @std_dev_port3_year3, @skew_port3_year3, @kurt_port3_year3, @correlation_port3_year3, @yields_port3_year3, @mean_port3_year4, @std_dev_port3_year4, @skew_port3_year4, @kurt_port3_year4, @correlation_port3_year4, @yields_port3_year4, @mean_port3_year5, @std_dev_port3_year5, @skew_port3_year5, @kurt_port3_year5, @correlation_port3_year5, @yields_port3_year5, @mean_port3_year6, @std_dev_port3_year6, @skew_port3_year6, @kurt_port3_year6, @correlation_port3_year6, @yields_port3_year6, @mean_port3_year7, @std_dev_port3_year7, @skew_port3_year7, @kurt_port3_year7, @correlation_port3_year7, @yields_port3_year7, @mean_port3_year8, @std_dev_port3_year8, @skew_port3_year8, @kurt_port3_year8, @correlation_port3_year8, @yields_port3_year8, @mean_port3_year9, @std_dev_port3_year9, @skew_port3_year9, @kurt_port3_year9, @correlation_port3_year9, @yields_port3_year9, @mean_port3_year10, @std_dev_port3_year10, @skew_port3_year10, @kurt_port3_year10, @correlation_port3_year10, @yields_port3_year10, @mean_port3_year11, @std_dev_port3_year11, @skew_port3_year11, @kurt_port3_year11, @correlation_port3_year11, @yields_port3_year11, @mean_port3_year12, @std_dev_port3_year12, @skew_port3_year12, @kurt_port3_year12, @correlation_port3_year12, @yields_port3_year12, @mean_port3_year13, @std_dev_port3_year13, @skew_port3_year13, @kurt_port3_year13, @correlation_port3_year13, @yields_port3_year13, @mean_port3_year14, @std_dev_port3_year14, @skew_port3_year14, @kurt_port3_year14, @correlation_port3_year14, @yields_port3_year14, @mean_port3_year15, @std_dev_port3_year15, @skew_port3_year15, @kurt_port3_year15, @correlation_port3_year15, @yields_port3_year15, @mean_port3_year16, @std_dev_port3_year16, @skew_port3_year16, @kurt_port3_year16, @correlation_port3_year16, @yields_port3_year16, @mean_port3_year17, @std_dev_port3_year17, @skew_port3_year17, @kurt_port3_year17, @correlation_port3_year17, @yields_port3_year17, @mean_port3_year18, @std_dev_port3_year18, @skew_port3_year18, @kurt_port3_year18, @correlation_port3_year18, @yields_port3_year18, @mean_port3_year19, @std_dev_port3_year19, @skew_port3_year19, @kurt_port3_year19, @correlation_port3_year19, @yields_port3_year19, @mean_port3_year20, @std_dev_port3_year20, @skew_port3_year20, @kurt_port3_year20, @correlation_port3_year20, @yields_port3_year20, @mean_port3_year21, @std_dev_port3_year21, @skew_port3_year21, @kurt_port3_year21, @correlation_port3_year21, @yields_port3_year21, @mean_port3_year22, @std_dev_port3_year22, @skew_port3_year22, @kurt_port3_year22, @correlation_port3_year22, @yields_port3_year22, @mean_port3_year23, @std_dev_port3_year23, @skew_port3_year23, @kurt_port3_year23, @correlation_port3_year23, @yields_port3_year23, @mean_port3_year24, @std_dev_port3_year24, @skew_port3_year24, @kurt_port3_year24, @correlation_port3_year24, @yields_port3_year24, @mean_port3_year25, @std_dev_port3_year25, @skew_port3_year25, @kurt_port3_year25, @correlation_port3_year25, @yields_port3_year25, @mean_port3_year26, @std_dev_port3_year26, @skew_port3_year26, @kurt_port3_year26, @correlation_port3_year26, @yields_port3_year26, @mean_port3_year27, @std_dev_port3_year27, @skew_port3_year27, @kurt_port3_year27, @correlation_port3_year27, @yields_port3_year27, @mean_port3_year28, @std_dev_port3_year28, @skew_port3_year28, @kurt_port3_year28, @correlation_port3_year28, @yields_port3_year28, @mean_port3_year29, @std_dev_port3_year29, @skew_port3_year29, @kurt_port3_year29, @correlation_port3_year29, @yields_port3_year29, @mean_port3_year30, @std_dev_port3_year30, @skew_port3_year30, @kurt_port3_year30, @correlation_port3_year30, @yields_port3_year30]
    # array4 = [@starting_value, @income, @expense, @weights_port4, @mean_port4_year1, @std_dev_port4_year1, @skew_port4_year1, @kurt_port4_year1, @correlation_port4_year1, @yields_port4_year1, @mean_port4_year2, @std_dev_port4_year2, @skew_port4_year2, @kurt_port4_year2, @correlation_port4_year2, @yields_port4_year2, @mean_port4_year3, @std_dev_port4_year3, @skew_port4_year3, @kurt_port4_year3, @correlation_port4_year3, @yields_port4_year3, @mean_port4_year4, @std_dev_port4_year4, @skew_port4_year4, @kurt_port4_year4, @correlation_port4_year4, @yields_port4_year4, @mean_port4_year5, @std_dev_port4_year5, @skew_port4_year5, @kurt_port4_year5, @correlation_port4_year5, @yields_port4_year5, @mean_port4_year6, @std_dev_port4_year6, @skew_port4_year6, @kurt_port4_year6, @correlation_port4_year6, @yields_port4_year6, @mean_port4_year7, @std_dev_port4_year7, @skew_port4_year7, @kurt_port4_year7, @correlation_port4_year7, @yields_port4_year7, @mean_port4_year8, @std_dev_port4_year8, @skew_port4_year8, @kurt_port4_year8, @correlation_port4_year8, @yields_port4_year8, @mean_port4_year9, @std_dev_port4_year9, @skew_port4_year9, @kurt_port4_year9, @correlation_port4_year9, @yields_port4_year9, @mean_port4_year10, @std_dev_port4_year10, @skew_port4_year10, @kurt_port4_year10, @correlation_port4_year10, @yields_port4_year10, @mean_port4_year11, @std_dev_port4_year11, @skew_port4_year11, @kurt_port4_year11, @correlation_port4_year11, @yields_port4_year11, @mean_port4_year12, @std_dev_port4_year12, @skew_port4_year12, @kurt_port4_year12, @correlation_port4_year12, @yields_port4_year12, @mean_port4_year13, @std_dev_port4_year13, @skew_port4_year13, @kurt_port4_year13, @correlation_port4_year13, @yields_port4_year13, @mean_port4_year14, @std_dev_port4_year14, @skew_port4_year14, @kurt_port4_year14, @correlation_port4_year14, @yields_port4_year14, @mean_port4_year15, @std_dev_port4_year15, @skew_port4_year15, @kurt_port4_year15, @correlation_port4_year15, @yields_port4_year15, @mean_port4_year16, @std_dev_port4_year16, @skew_port4_year16, @kurt_port4_year16, @correlation_port4_year16, @yields_port4_year16, @mean_port4_year17, @std_dev_port4_year17, @skew_port4_year17, @kurt_port4_year17, @correlation_port4_year17, @yields_port4_year17, @mean_port4_year18, @std_dev_port4_year18, @skew_port4_year18, @kurt_port4_year18, @correlation_port4_year18, @yields_port4_year18, @mean_port4_year19, @std_dev_port4_year19, @skew_port4_year19, @kurt_port4_year19, @correlation_port4_year19, @yields_port4_year19, @mean_port4_year20, @std_dev_port4_year20, @skew_port4_year20, @kurt_port4_year20, @correlation_port4_year20, @yields_port4_year20, @mean_port4_year21, @std_dev_port4_year21, @skew_port4_year21, @kurt_port4_year21, @correlation_port4_year21, @yields_port4_year21, @mean_port4_year22, @std_dev_port4_year22, @skew_port4_year22, @kurt_port4_year22, @correlation_port4_year22, @yields_port4_year22, @mean_port4_year23, @std_dev_port4_year23, @skew_port4_year23, @kurt_port4_year23, @correlation_port4_year23, @yields_port4_year23, @mean_port4_year24, @std_dev_port4_year24, @skew_port4_year24, @kurt_port4_year24, @correlation_port4_year24, @yields_port4_year24, @mean_port4_year25, @std_dev_port4_year25, @skew_port4_year25, @kurt_port4_year25, @correlation_port4_year25, @yields_port4_year25, @mean_port4_year26, @std_dev_port4_year26, @skew_port4_year26, @kurt_port4_year26, @correlation_port4_year26, @yields_port4_year26, @mean_port4_year27, @std_dev_port4_year27, @skew_port4_year27, @kurt_port4_year27, @correlation_port4_year27, @yields_port4_year27, @mean_port4_year28, @std_dev_port4_year28, @skew_port4_year28, @kurt_port4_year28, @correlation_port4_year28, @yields_port4_year28, @mean_port4_year29, @std_dev_port4_year29, @skew_port4_year29, @kurt_port4_year29, @correlation_port4_year29, @yields_port4_year29, @mean_port4_year30, @std_dev_port4_year30, @skew_port4_year30, @kurt_port4_year30, @correlation_port4_year30, @yields_port4_year30]
    # arrays = [array1, array2, array3, array4]
    
    # Parallel.map(array1, in_processes: 4) { |array|
    #     @python_forecat_port1 = FirstJob.perform_now(array)
    #    }
    # Parallel.map(array2, in_processes: 4) { |array|
    #     @python_forecat_port2 = SecondJob.perform_now(array)
    #    }
    # Parallel.map(array3, in_processes: 4) { |array|
    #     @python_forecat_port3 = ThirdJob.perform_now(array)
    #    }  
    # Parallel.map(array4, in_processes: 4) { |array|
    #     @python_forecat_port4 = FourthJob.perform_now(array)
    #    }          
    # @python_forecat_port5 = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port5}" "#{@mean_port5_year1}" "#{@std_dev_port5_year1}" "#{@skew_port5_year1}" "#{@kurt_port5_year1}" "#{@correlation_port5_year1}" "#{@yields_port5_year1}" "#{@mean_port5_year2}" "#{@std_dev_port5_year2}" "#{@skew_port5_year2}" "#{@kurt_port5_year2}" "#{@correlation_port5_year2}" "#{@yields_port5_year2}" "#{@mean_port5_year3}" "#{@std_dev_port5_year3}" "#{@skew_port5_year3}" "#{@kurt_port5_year3}" "#{@correlation_port5_year3}" "#{@yields_port5_year3}" "#{@mean_port5_year4}" "#{@std_dev_port5_year4}" "#{@skew_port5_year4}" "#{@kurt_port5_year4}" "#{@correlation_port5_year4}" "#{@yields_port5_year4}" "#{@mean_port5_year5}" "#{@std_dev_port5_year5}" "#{@skew_port5_year5}" "#{@kurt_port5_year5}" "#{@correlation_port5_year5}" "#{@yields_port5_year5}" "#{@mean_port5_year6}" "#{@std_dev_port5_year6}" "#{@skew_port5_year6}" "#{@kurt_port5_year6}" "#{@correlation_port5_year6}" "#{@yields_port5_year6}" "#{@mean_port5_year7}" "#{@std_dev_port5_year7}" "#{@skew_port5_year7}" "#{@kurt_port5_year7}" "#{@correlation_port5_year7}" "#{@yields_port5_year7}" "#{@mean_port5_year8}" "#{@std_dev_port5_year8}" "#{@skew_port5_year8}" "#{@kurt_port5_year8}" "#{@correlation_port5_year8}" "#{@yields_port5_year8}" "#{@mean_port5_year9}" "#{@std_dev_port5_year9}" "#{@skew_port5_year9}" "#{@kurt_port5_year9}" "#{@correlation_port5_year9}" "#{@yields_port5_year9}" "#{@mean_port5_year10}" "#{@std_dev_port5_year10}" "#{@skew_port5_year10}" "#{@kurt_port5_year10}" "#{@correlation_port5_year10}" "#{@yields_port5_year10}" "#{@mean_port5_year11}" "#{@std_dev_port5_year11}" "#{@skew_port5_year11}" "#{@kurt_port5_year11}" "#{@correlation_port5_year11}" "#{@yields_port5_year11}" "#{@mean_port5_year12}" "#{@std_dev_port5_year12}" "#{@skew_port5_year12}" "#{@kurt_port5_year12}" "#{@correlation_port5_year12}" "#{@yields_port5_year12}" "#{@mean_port5_year13}" "#{@std_dev_port5_year13}" "#{@skew_port5_year13}" "#{@kurt_port5_year13}" "#{@correlation_port5_year13}" "#{@yields_port5_year13}" "#{@mean_port5_year14}" "#{@std_dev_port5_year14}" "#{@skew_port5_year14}" "#{@kurt_port5_year14}" "#{@correlation_port5_year14}" "#{@yields_port5_year14}" "#{@mean_port5_year15}" "#{@std_dev_port5_year15}" "#{@skew_port5_year15}" "#{@kurt_port5_year15}" "#{@correlation_port5_year15}" "#{@yields_port5_year15}" "#{@mean_port5_year16}" "#{@std_dev_port5_year16}" "#{@skew_port5_year16}" "#{@kurt_port5_year16}" "#{@correlation_port5_year16}" "#{@yields_port5_year16}" "#{@mean_port5_year17}" "#{@std_dev_port5_year17}" "#{@skew_port5_year17}" "#{@kurt_port5_year17}" "#{@correlation_port5_year17}" "#{@yields_port5_year17}" "#{@mean_port5_year18}" "#{@std_dev_port5_year18}" "#{@skew_port5_year18}" "#{@kurt_port5_year18}" "#{@correlation_port5_year18}" "#{@yields_port5_year18}" "#{@mean_port5_year19}" "#{@std_dev_port5_year19}" "#{@skew_port5_year19}" "#{@kurt_port5_year19}" "#{@correlation_port5_year19}" "#{@yields_port5_year19}" "#{@mean_port5_year20}" "#{@std_dev_port5_year20}" "#{@skew_port5_year20}" "#{@kurt_port5_year20}" "#{@correlation_port5_year20}" "#{@yields_port5_year20}" "#{@mean_port5_year21}" "#{@std_dev_port5_year21}" "#{@skew_port5_year21}" "#{@kurt_port5_year21}" "#{@correlation_port5_year21}" "#{@yields_port5_year21}" "#{@mean_port5_year22}" "#{@std_dev_port5_year22}" "#{@skew_port5_year22}" "#{@kurt_port5_year22}" "#{@correlation_port5_year22}" "#{@yields_port5_year22}" "#{@mean_port5_year23}" "#{@std_dev_port5_year23}" "#{@skew_port5_year23}" "#{@kurt_port5_year23}" "#{@correlation_port5_year23}" "#{@yields_port5_year23}" "#{@mean_port5_year24}" "#{@std_dev_port5_year24}" "#{@skew_port5_year24}" "#{@kurt_port5_year24}" "#{@correlation_port5_year24}" "#{@yields_port5_year24}" "#{@mean_port5_year25}" "#{@std_dev_port5_year25}" "#{@skew_port5_year25}" "#{@kurt_port5_year25}" "#{@correlation_port5_year25}" "#{@yields_port5_year25}" "#{@mean_port5_year26}" "#{@std_dev_port5_year26}" "#{@skew_port5_year26}" "#{@kurt_port5_year26}" "#{@correlation_port5_year26}" "#{@yields_port5_year26}" "#{@mean_port5_year27}" "#{@std_dev_port5_year27}" "#{@skew_port5_year27}" "#{@kurt_port5_year27}" "#{@correlation_port5_year27}" "#{@yields_port5_year27}" "#{@mean_port5_year28}" "#{@std_dev_port5_year28}" "#{@skew_port5_year28}" "#{@kurt_port5_year28}" "#{@correlation_port5_year28}" "#{@yields_port5_year28}" "#{@mean_port5_year29}" "#{@std_dev_port5_year29}" "#{@skew_port5_year29}" "#{@kurt_port5_year29}" "#{@correlation_port5_year29}" "#{@yields_port5_year29}" "#{@mean_port5_year30}" "#{@std_dev_port5_year30}" "#{@skew_port5_year30}" "#{@kurt_port5_year30}" "#{@correlation_port5_year30}" "#{@yields_port5_year30}"`)
    render({ :template => "forecasts/calculate.html.erb" })
  end

  def download

   @port1_year1_10th =  params.fetch("port1_year1_10th")
   @port1_year2_10th =  params.fetch("port1_year2_10th")
   @port1_year3_10th =  params.fetch("port1_year3_10th")
   @port1_year4_10th =  params.fetch("port1_year4_10th")
   @port1_year5_10th =  params.fetch("port1_year5_10th")
   @port1_year6_10th =  params.fetch("port1_year6_10th")
   @port1_year7_10th =  params.fetch("port1_year7_10th")
   @port1_year8_10th =  params.fetch("port1_year8_10th")
   @port1_year9_10th =  params.fetch("port1_year9_10th")
   @port1_year10_10th =  params.fetch("port1_year10_10th")
   @port1_year11_10th =  params.fetch("port1_year11_10th")
   @port1_year12_10th =  params.fetch("port1_year12_10th")
   @port1_year13_10th =  params.fetch("port1_year13_10th")
   @port1_year14_10th =  params.fetch("port1_year14_10th")
   @port1_year15_10th =  params.fetch("port1_year15_10th")
   @port1_year16_10th =  params.fetch("port1_year16_10th")
   @port1_year17_10th =  params.fetch("port1_year17_10th")
   @port1_year18_10th =  params.fetch("port1_year18_10th")
   @port1_year19_10th =  params.fetch("port1_year19_10th")
   @port1_year20_10th =  params.fetch("port1_year20_10th")
   @port1_year21_10th =  params.fetch("port1_year21_10th")
   @port1_year22_10th =  params.fetch("port1_year22_10th")
   @port1_year23_10th =  params.fetch("port1_year23_10th")
   @port1_year24_10th =  params.fetch("port1_year24_10th")
   @port1_year25_10th =  params.fetch("port1_year25_10th")
   @port1_year26_10th =  params.fetch("port1_year26_10th")
   @port1_year27_10th =  params.fetch("port1_year27_10th")
   @port1_year28_10th =  params.fetch("port1_year28_10th")
   @port1_year29_10th =  params.fetch("port1_year29_10th")
   @port1_year30_10th =  params.fetch("port1_year30_10th")

   @port1_year1_50th =  params.fetch("port1_year1_50th")
   @port1_year2_50th =  params.fetch("port1_year2_50th")
   @port1_year3_50th =  params.fetch("port1_year3_50th")
   @port1_year4_50th =  params.fetch("port1_year4_50th")
   @port1_year5_50th =  params.fetch("port1_year5_50th")
   @port1_year6_50th =  params.fetch("port1_year6_50th")
   @port1_year7_50th =  params.fetch("port1_year7_50th")
   @port1_year8_50th =  params.fetch("port1_year8_50th")
   @port1_year9_50th =  params.fetch("port1_year9_50th")
   @port1_year10_50th =  params.fetch("port1_year10_50th")
   @port1_year11_50th =  params.fetch("port1_year11_50th")
   @port1_year12_50th =  params.fetch("port1_year12_50th")
   @port1_year13_50th =  params.fetch("port1_year13_50th")
   @port1_year14_50th =  params.fetch("port1_year14_50th")
   @port1_year15_50th =  params.fetch("port1_year15_50th")
   @port1_year16_50th =  params.fetch("port1_year16_50th")
   @port1_year17_50th =  params.fetch("port1_year17_50th")
   @port1_year18_50th =  params.fetch("port1_year18_50th")
   @port1_year19_50th =  params.fetch("port1_year19_50th")
   @port1_year20_50th =  params.fetch("port1_year20_50th")
   @port1_year21_50th =  params.fetch("port1_year21_50th")
   @port1_year22_50th =  params.fetch("port1_year22_50th")
   @port1_year23_50th =  params.fetch("port1_year23_50th")
   @port1_year24_50th =  params.fetch("port1_year24_50th")
   @port1_year25_50th =  params.fetch("port1_year25_50th")
   @port1_year26_50th =  params.fetch("port1_year26_50th")
   @port1_year27_50th =  params.fetch("port1_year27_50th")
   @port1_year28_50th =  params.fetch("port1_year28_50th")
   @port1_year29_50th =  params.fetch("port1_year29_50th")
   @port1_year30_50th =  params.fetch("port1_year30_50th")
   
   @port1_year1_90th =  params.fetch("port1_year1_90th")
   @port1_year2_90th =  params.fetch("port1_year2_90th")
   @port1_year3_90th =  params.fetch("port1_year3_90th")
   @port1_year4_90th =  params.fetch("port1_year4_90th")
   @port1_year5_90th =  params.fetch("port1_year5_90th")
   @port1_year6_90th =  params.fetch("port1_year6_90th")
   @port1_year7_90th =  params.fetch("port1_year7_90th")
   @port1_year8_90th =  params.fetch("port1_year8_90th")
   @port1_year9_90th =  params.fetch("port1_year9_90th")
   @port1_year10_90th =  params.fetch("port1_year10_90th")
   @port1_year11_90th =  params.fetch("port1_year11_90th")
   @port1_year12_90th =  params.fetch("port1_year12_90th")
   @port1_year13_90th =  params.fetch("port1_year13_90th")
   @port1_year14_90th =  params.fetch("port1_year14_90th")
   @port1_year15_90th =  params.fetch("port1_year15_90th")
   @port1_year16_90th =  params.fetch("port1_year16_90th")
   @port1_year17_90th =  params.fetch("port1_year17_90th")
   @port1_year18_90th =  params.fetch("port1_year18_90th")
   @port1_year19_90th =  params.fetch("port1_year19_90th")
   @port1_year20_90th =  params.fetch("port1_year20_90th") 
   @port1_year21_90th =  params.fetch("port1_year21_90th")
   @port1_year22_90th =  params.fetch("port1_year22_90th")
   @port1_year23_90th =  params.fetch("port1_year23_90th")
   @port1_year24_90th =  params.fetch("port1_year24_90th")
   @port1_year25_90th =  params.fetch("port1_year25_90th")
   @port1_year26_90th =  params.fetch("port1_year26_90th")
   @port1_year27_90th =  params.fetch("port1_year27_90th")
   @port1_year28_90th =  params.fetch("port1_year28_90th")
   @port1_year29_90th =  params.fetch("port1_year29_90th")
   @port1_year30_90th =  params.fetch("port1_year30_90th")

    render xlsx:  "forecasts/download.xlsx.axlsx", filename: "Frontier-#{DateTime.now.to_date}.xlsx"
  end

    def download2

   @port1_year1_10th =  params.fetch("port1_year1_10th")
   @port1_year2_10th =  params.fetch("port1_year2_10th")
   @port1_year3_10th =  params.fetch("port1_year3_10th")
   @port1_year4_10th =  params.fetch("port1_year4_10th")
   @port1_year5_10th =  params.fetch("port1_year5_10th")
   @port1_year6_10th =  params.fetch("port1_year6_10th")
   @port1_year7_10th =  params.fetch("port1_year7_10th")
   @port1_year8_10th =  params.fetch("port1_year8_10th")
   @port1_year9_10th =  params.fetch("port1_year9_10th")
   @port1_year10_10th =  params.fetch("port1_year10_10th")
   @port1_year11_10th =  params.fetch("port1_year11_10th")
   @port1_year12_10th =  params.fetch("port1_year12_10th")
   @port1_year13_10th =  params.fetch("port1_year13_10th")
   @port1_year14_10th =  params.fetch("port1_year14_10th")
   @port1_year15_10th =  params.fetch("port1_year15_10th")
   @port1_year16_10th =  params.fetch("port1_year16_10th")
   @port1_year17_10th =  params.fetch("port1_year17_10th")
   @port1_year18_10th =  params.fetch("port1_year18_10th")
   @port1_year19_10th =  params.fetch("port1_year19_10th")
   @port1_year20_10th =  params.fetch("port1_year20_10th")
   @port1_year21_10th =  params.fetch("port1_year21_10th")
   @port1_year22_10th =  params.fetch("port1_year22_10th")
   @port1_year23_10th =  params.fetch("port1_year23_10th")
   @port1_year24_10th =  params.fetch("port1_year24_10th")
   @port1_year25_10th =  params.fetch("port1_year25_10th")
   @port1_year26_10th =  params.fetch("port1_year26_10th")
   @port1_year27_10th =  params.fetch("port1_year27_10th")
   @port1_year28_10th =  params.fetch("port1_year28_10th")
   @port1_year29_10th =  params.fetch("port1_year29_10th")
   @port1_year30_10th =  params.fetch("port1_year30_10th")

   @port1_year1_50th =  params.fetch("port1_year1_50th")
   @port1_year2_50th =  params.fetch("port1_year2_50th")
   @port1_year3_50th =  params.fetch("port1_year3_50th")
   @port1_year4_50th =  params.fetch("port1_year4_50th")
   @port1_year5_50th =  params.fetch("port1_year5_50th")
   @port1_year6_50th =  params.fetch("port1_year6_50th")
   @port1_year7_50th =  params.fetch("port1_year7_50th")
   @port1_year8_50th =  params.fetch("port1_year8_50th")
   @port1_year9_50th =  params.fetch("port1_year9_50th")
   @port1_year10_50th =  params.fetch("port1_year10_50th")
   @port1_year11_50th =  params.fetch("port1_year11_50th")
   @port1_year12_50th =  params.fetch("port1_year12_50th")
   @port1_year13_50th =  params.fetch("port1_year13_50th")
   @port1_year14_50th =  params.fetch("port1_year14_50th")
   @port1_year15_50th =  params.fetch("port1_year15_50th")
   @port1_year16_50th =  params.fetch("port1_year16_50th")
   @port1_year17_50th =  params.fetch("port1_year17_50th")
   @port1_year18_50th =  params.fetch("port1_year18_50th")
   @port1_year19_50th =  params.fetch("port1_year19_50th")
   @port1_year20_50th =  params.fetch("port1_year20_50th")
   @port1_year21_50th =  params.fetch("port1_year21_50th")
   @port1_year22_50th =  params.fetch("port1_year22_50th")
   @port1_year23_50th =  params.fetch("port1_year23_50th")
   @port1_year24_50th =  params.fetch("port1_year24_50th")
   @port1_year25_50th =  params.fetch("port1_year25_50th")
   @port1_year26_50th =  params.fetch("port1_year26_50th")
   @port1_year27_50th =  params.fetch("port1_year27_50th")
   @port1_year28_50th =  params.fetch("port1_year28_50th")
   @port1_year29_50th =  params.fetch("port1_year29_50th")
   @port1_year30_50th =  params.fetch("port1_year30_50th")
   
   @port1_year1_90th =  params.fetch("port1_year1_90th")
   @port1_year2_90th =  params.fetch("port1_year2_90th")
   @port1_year3_90th =  params.fetch("port1_year3_90th")
   @port1_year4_90th =  params.fetch("port1_year4_90th")
   @port1_year5_90th =  params.fetch("port1_year5_90th")
   @port1_year6_90th =  params.fetch("port1_year6_90th")
   @port1_year7_90th =  params.fetch("port1_year7_90th")
   @port1_year8_90th =  params.fetch("port1_year8_90th")
   @port1_year9_90th =  params.fetch("port1_year9_90th")
   @port1_year10_90th =  params.fetch("port1_year10_90th")
   @port1_year11_90th =  params.fetch("port1_year11_90th")
   @port1_year12_90th =  params.fetch("port1_year12_90th")
   @port1_year13_90th =  params.fetch("port1_year13_90th")
   @port1_year14_90th =  params.fetch("port1_year14_90th")
   @port1_year15_90th =  params.fetch("port1_year15_90th")
   @port1_year16_90th =  params.fetch("port1_year16_90th")
   @port1_year17_90th =  params.fetch("port1_year17_90th")
   @port1_year18_90th =  params.fetch("port1_year18_90th")
   @port1_year19_90th =  params.fetch("port1_year19_90th")
   @port1_year20_90th =  params.fetch("port1_year20_90th") 
   @port1_year21_90th =  params.fetch("port1_year21_90th")
   @port1_year22_90th =  params.fetch("port1_year22_90th")
   @port1_year23_90th =  params.fetch("port1_year23_90th")
   @port1_year24_90th =  params.fetch("port1_year24_90th")
   @port1_year25_90th =  params.fetch("port1_year25_90th")
   @port1_year26_90th =  params.fetch("port1_year26_90th")
   @port1_year27_90th =  params.fetch("port1_year27_90th")
   @port1_year28_90th =  params.fetch("port1_year28_90th")
   @port1_year29_90th =  params.fetch("port1_year29_90th")
   @port1_year30_90th =  params.fetch("port1_year30_90th")

    render xlsx:  "forecasts/download.xlsx.axlsx", filename: "Frontier-#{DateTime.now.to_date}.xlsx"
  end
end
