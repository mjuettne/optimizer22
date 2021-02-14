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
    the_forecast_input.portfolio1_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio1")}).at(0).id
    the_forecast_input.portfolio2_id = Portfolio.all.where({:user_id => @current_user.id}).where({:name => params.fetch("query_portfolio2")}).at(0).id
    the_forecast_input.inflation = inflation
    the_forecast_input.starting_value = params.fetch("query_starting_value")
    the_forecast_input.income = params.fetch("query_income")
    the_forecast_input.spend_value = params.fetch("query_spend_value")
    the_forecast_input.weight_port1 = params.fetch("query_weight_port1")
    the_forecast_input.weight_port2 = params.fetch("query_weight_port2")

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
   
    the_forecast_input.save

    redirect_to("/forecasts", { :notice => "Forecast created successfully." })
    
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

    ######## YEAR 1 (PORT 1) ###########
    correlation_id_year1 = Correlation.all.where({:name => params.fetch("query_correlation_year1")}).at(0).id
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
    
    ######## YEAR 2 (PORT 1) ###########
    correlation_id_year2 = Correlation.all.where({:name => params.fetch("query_correlation_year2")}).at(0).id
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
    @correlation_port1_year2 = Matrix.build(length_port1) {1}
    for i in 0...length_port1
      for j in 0...i
        @correlation_port1_year2[i,j] = correlation_inputs_port1_year2.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
        @correlation_port1_year2[j,i] = correlation_inputs_port1_year2.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
      end
    end
    @yields_port1_year2 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year2[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year2_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end

    ######## YEAR 3 (PORT 1) ###########
    correlation_id_year3 = Correlation.all.where({:name => params.fetch("query_correlation_year3")}).at(0).id
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
    @correlation_port1_year3 = Matrix.build(length_port1) {1}
    for i in 0...length_port1
      for j in 0...i
        @correlation_port1_year3[i,j] = correlation_inputs_port1_year3.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
        @correlation_port1_year3[j,i] = correlation_inputs_port1_year3.where(:asset_class1 => asset_class_port1[i]).where(:asset_class2 => asset_class_port1[j])[0].correl
      end
    end
    @yields_port1_year3 = Array.new(length_port1)
    for i in 0...length_port1
      @yields_port1_year3[i] = CmaInput.all.where({:cma_id => @the_forecast_input.year3_cma_id }).where({:asset_class_id => asset_class_port1[i] }).at(0).yield.to_f/100
    end


    
    @starting_value = params.fetch("query_starting_value").to_f
    @income = [params.fetch("query_income_year1").to_f, params.fetch("query_income_year2").to_f, params.fetch("query_income_year3").to_f, params.fetch("query_income_year4").to_f, params.fetch("query_income_year5").to_f, params.fetch("query_income_year6").to_f, params.fetch("query_income_year7").to_f, params.fetch("query_income_year8").to_f, params.fetch("query_income_year9").to_f, params.fetch("query_income_year10").to_f,
              params.fetch("query_income_year11").to_f, params.fetch("query_income_year12").to_f, params.fetch("query_income_year13").to_f, params.fetch("query_income_year14").to_f, params.fetch("query_income_year15").to_f, params.fetch("query_income_year16").to_f, params.fetch("query_income_year17").to_f, params.fetch("query_income_year18").to_f, params.fetch("query_income_year19").to_f, params.fetch("query_income_year20").to_f,
              params.fetch("query_income_year21").to_f, params.fetch("query_income_year22").to_f, params.fetch("query_income_year23").to_f, params.fetch("query_income_year24").to_f, params.fetch("query_income_year25").to_f, params.fetch("query_income_year26").to_f, params.fetch("query_income_year27").to_f, params.fetch("query_income_year28").to_f, params.fetch("query_income_year29").to_f, params.fetch("query_income_year30").to_f] 

    @expense = [params.fetch("query_expense_year1").to_f, params.fetch("query_expense_year2").to_f, params.fetch("query_expense_year3").to_f, params.fetch("query_expense_year4").to_f, params.fetch("query_expense_year5").to_f, params.fetch("query_expense_year6").to_f, params.fetch("query_expense_year7").to_f, params.fetch("query_expense_year8").to_f, params.fetch("query_expense_year9").to_f, params.fetch("query_expense_year10").to_f, 
                params.fetch("query_expense_year11").to_f, params.fetch("query_expense_year12").to_f, params.fetch("query_expense_year13").to_f, params.fetch("query_expense_year14").to_f, params.fetch("query_expense_year15").to_f, params.fetch("query_expense_year16").to_f, params.fetch("query_expense_year17").to_f, params.fetch("query_expense_year18").to_f, params.fetch("query_expense_year19").to_f, params.fetch("query_expense_year20").to_f, 
                params.fetch("query_expense_year21").to_f, params.fetch("query_expense_year22").to_f, params.fetch("query_expense_year23").to_f, params.fetch("query_expense_year24").to_f, params.fetch("query_expense_year25").to_f, params.fetch("query_expense_year26").to_f, params.fetch("query_expense_year27").to_f, params.fetch("query_expense_year28").to_f, params.fetch("query_expense_year29").to_f, params.fetch("query_expense_year30").to_f]
 
    
    @starting_value = @starting_value.to_json
    @income = @income.to_json
    @expense = @expense.to_json   

    @weights_port1 = @weights_port1.to_json
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
    

    @python_forecat = JSON.parse(`python3 lib/assets/python/forecast.py "#{@starting_value}" "#{@income}" "#{@expense}" "#{@weights_port1}" "#{@mean_port1_year1}" "#{@std_dev_port1_year1}" "#{@skew_port1_year1}" "#{@kurt_port1_year1}" "#{@correlation_port1_year1}" "#{@yields_port1_year1}" "#{@mean_port1_year2}" "#{@std_dev_port1_year2}" "#{@skew_port1_year2}" "#{@kurt_port1_year2}" "#{@correlation_port1_year2}" "#{@yields_port1_year2}" "#{@mean_port1_year3}" "#{@std_dev_port1_year3}" "#{@skew_port1_year3}" "#{@kurt_port1_year3}" "#{@correlation_port1_year3}" "#{@yields_port1_year3}" `)

    render({ :template => "forecasts/calculate.html.erb" })
  end
end
