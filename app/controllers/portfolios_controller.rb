class PortfoliosController < ApplicationController
  def index
    matching_portfolios = Portfolio.all
    @list_of_asset_classes = AssetClass.all
    @list_of_portfolios = matching_portfolios.order({ :created_at => :desc })
    @cmas = Cma.all
    @correlations = Correlation.all
    render({ :template => "portfolios/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_portfolios = Portfolio.where({ :id => the_id })
    @the_portfolio = matching_portfolios.at(0)

    
    matching_asset_classes = AssetClass.all
    @list_of_asset_classes = matching_asset_classes.order({ :created_at => :asc })
    @cmas = Cma.all
    @correlations = Correlation.all
    
    @weights = Weight.all.where({:portfolio_id => @the_portfolio.id})    
    @cma_inputs = CmaInput.all

    render({ :template => "portfolios/show.html.erb" })
  end

  def create
    weights = params.fetch("query_weights")
    sum_weights = 0.0 
    length = weights.length.to_i
    for i in 0...length
      sum_weights = sum_weights + weights[i].to_f
    end
    
    
    if sum_weights != 100
      redirect_to("/portfolios/", { :alert => "Portfolio NOT Created! Weights Do NOT Sum to 100!"} ) 
    else


    the_portfolio = Portfolio.new
    the_portfolio.user_id = params.fetch("query_user_id")
    the_portfolio.name = params.fetch("query_name")
    the_portfolio.cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    the_portfolio.correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    the_portfolio.save
    portfolios = Portfolio.all
    newest_portfolio_id = portfolios.order({ :created_at => :desc }).at(0).id
    
    query_asset_class_id = params.fetch("query_asset_class_id")
    
    @checks     = params.fetch("include")
    
      for i in 0...length
            the_weight = Weight.new
            the_weight.portfolio_id = newest_portfolio_id
            the_weight.asset_class_id = query_asset_class_id[i]
            the_weight.weight = weights[i]
            if @checks.include? query_asset_class_id[i].to_s
              the_weight.inclusion = "yes"
            else
              the_weight.inclusion = "no"
            end  
              the_weight.save
        end
        redirect_to("/portfolios", { :notice => "Portfolio created successfully." })
    end   
  end

  def create_frontier

    weights = params.fetch("query_weights")
    sum_weights = 0.0 
    length = weights.length.to_i
    for i in 0...length
      sum_weights = sum_weights + weights[i].to_f
    end
    
    
    if sum_weights != 100
      redirect_to("/portfolios/", { :alert => "Portfolio NOT Created! Weights Do NOT Sum to 100!"} ) 
    else


    the_portfolio = Portfolio.new
    the_portfolio.user_id = params.fetch("query_user_id")
    the_portfolio.name = params.fetch("query_name")
    the_portfolio.cma_id = params.fetch("query_cma_id")
    the_portfolio.correlation_id = params.fetch("query_correlation_id")
    the_portfolio.save
    portfolios = Portfolio.all
    newest_portfolio_id = portfolios.order({ :created_at => :desc }).at(0).id
    
    query_asset_class_id = params.fetch("query_asset_class_id")
    
    @checks     = params.fetch("include")
    
      for i in 0...length
            the_weight = Weight.new
            the_weight.portfolio_id = newest_portfolio_id
            the_weight.asset_class_id = query_asset_class_id[i]
            the_weight.weight = weights[i]
            if @checks.include? query_asset_class_id[i].to_s
              the_weight.inclusion = "yes"
            else
              the_weight.inclusion = "no"
            end  
              the_weight.save
        end
        redirect_to("/portfolios", { :notice => "Portfolio created successfully." })
    end   

  end

  def update
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)

    the_portfolio.name = params.fetch("query_name")
    the_portfolio.cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    the_portfolio.correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    query_benchmark = params.fetch("query_benchmark")
    if query_benchmark == ""

    else
    the_portfolio.benchmark = AssetClass.all.where({:name => params.fetch("query_benchmark")}).at(0).id
    end
    if the_portfolio.valid?
      the_portfolio.save
      redirect_to("/portfolios/#{the_portfolio.id}", { :notice => "Portfolio updated successfully."} )
    else
      redirect_to("/portfolios/#{the_portfolio.id}", { :alert => "Portfolio failed to update successfully." })
    end
  end

  def update_all
    
    the_portfolio_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_portfolio_id }).at(0)
    
    the_id = params.fetch("query_id")
    inclusion = params.fetch("include")
    query_weights = params.fetch("query_weights")
    query_asset_class_id = params.fetch("query_asset_class_id")
    length = query_weights.length.to_i
    sum_weights = 0.0 
    for i in 0...length
       
      sum_weights = sum_weights + query_weights[i].to_f
    end
    
    

    if sum_weights == 100
      
      for i in 0...length
            the_weight = Weight.where({:id => the_id[i] }).at(0)
            if inclusion.include? query_asset_class_id[i].to_s
                the_weight.inclusion = "yes"
                the_weight.weight =  query_weights[i]
            else
                the_weight.inclusion = "no"
                the_weight.weight =  0.0
            end
            the_weight.save
      end
        redirect_to("/portfolios/#{the_portfolio.id}", { :notice => "Portfolio updated successfully."} )  
    else
        redirect_to("/portfolios/#{the_portfolio.id}", { :alert => "Portfolio not updated! Weights Do NOT Sum to 100!"} ) 
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_portfolio = Portfolio.where({ :id => the_id }).at(0)

    the_portfolio.destroy

    redirect_to("/portfolios", { :notice => "Portfolio deleted successfully."} )
  end

  def calculate
    require 'json'
    require 'matrix'

    @portfolio_id = params.fetch("portfolio_id")
    @the_portfolio = Portfolio.all.where({:id => @portfolio_id }).at(0)
    @all_asset_class = AssetClass.all

    query_mean = params.fetch("query_mean")
    query_std_dev = params.fetch("query_std_dev")
    query_skew = params.fetch("query_skew")
    query_kurt = params.fetch("query_kurt")
    query_yield = params.fetch("query_yield")
    query_asset_id_all = params.fetch("query_asset_id")
    query_asset_id_bench = query_asset_id_all[-1]
    @query_weights = params.fetch("query_weights")

    if query_asset_id_all.uniq.length == query_asset_id_all.length
      @query_asset_id = query_asset_id_all
      length = @query_asset_id.length.to_i
      @query_weights[length-1] = 0      
    else
      @query_asset_id = query_asset_id_all.first query_asset_id_all.size - 1
      query_mean = query_mean.first query_mean.size - 1
      query_std_dev = query_std_dev.first query_std_dev.size - 1
      query_skew = query_skew.first query_skew.size - 1
      query_kurt = query_kurt.first query_kurt.size - 1
      query_yield = query_yield.first query_yield.size - 1
      @query_weights = @query_weights.first @query_weights.size - 1
      length = @query_asset_id.length.to_i
      @query_weights[length-1] = 0
    end

    @bench_location = @query_asset_id.index(query_asset_id_bench)

    coreltation_id = params.fetch("coreltation_id")
    correlation_inputs = CorrelationInput.all.where({:correlation_id => coreltation_id})
    @length = @query_asset_id.length.to_i
    
    mean = query_mean
    std_dev = query_std_dev
    skew = query_skew
    kurt = query_kurt

    @correlation = Matrix.build(@length) {1}
    for i in 0...@length
      for j in 0...i
        @correlation[i,j] = correlation_inputs.where(:asset_class1 => @query_asset_id[i]).where(:asset_class2 => @query_asset_id[j])[0].correl
        @correlation[j,i] = correlation_inputs.where(:asset_class1 => @query_asset_id[i]).where(:asset_class2 => @query_asset_id[j])[0].correl
      end
    end
    
    @mean = Array.new(@length)
    for i in 0...@length
      @mean[i] = mean[i].to_f/100
    end

    @std_dev = Array.new(@length)
    for i in 0...@length
      @std_dev[i] = std_dev[i].to_f/100
    end
    @skew = Array.new(@length)
    for i in 0...@length
      @skew[i] = skew[i].to_f
    end
    
    @kurt = Array.new(@length)
    for i in 0...@length
      @kurt[i] = kurt[i].to_f
    end

    @yields = Array.new(@length)
    for i in 0...@length
      @yields[i] = query_yield[i].to_f/100
    end

    @weights = Array.new(@length)
    for i in 0...@length
      @weights[i] = @query_weights[i].to_f/100
    end



    
    @mean = @mean.to_json
    @std_dev = @std_dev.to_json
    @skew = @skew.to_json
    @kurt = @kurt.to_json
    @correlation = @correlation.to_json
    query_asset_id = @query_asset_id.to_json
    @yields = @yields.to_json
    @weights = @weights.to_json

    # require 'json'
    # require 'matrix'
    # @mean = [0.051, 0.0588, 0.0620, 0.081, 0.09, 0.115, 0.145, 0.056, 0.0263, 0.09]
    # @std_dev = [0.1451, 0.1736, 0.1938, 0.1626, 0.1751, 0.2136, 0.2188, 0.1674, 0.06, 0.14]
    # @skew = [-0.4614, -0.7489, -0.7786, -0.3084, -0.7884, -0.5633, -0.1200, -0.6689, -0.8200, -1.6123]
    # @kurt = [4.9770, 5.9379, 5.7061, 4.1577, 5.8101, 4.8648, 25.6100, 11.0321, 9.3100, 11.3722]
    
    # @correlation = Matrix[ [1.00, 0.97, 0.92, 0.88, 0.82, 0.75, 0.64, 0.75, 0.79, 0.14 ], 
    #                        [0.97, 1.00, 0.95, 0.90, 0.88, 0.80, 0.69, 0.77, 0.86, 0.07 ], 
    #                        [0.92, 0.95, 1.00, 0.83, 0.81, 0.69, 0.61, 0.77, 0.77, 0.06 ], 
    #                        [0.88, 0.90, 0.83, 1.00, 0.96, 0.90, 0.56, 0.66, 0.85, 0.19 ], 
    #                        [0.82, 0.88, 0.81, 0.96, 1.00, 0.87, 0.53, 0.63, 0.85, 0.18 ], 
    #                        [0.75, 0.80, 0.69, 0.90, 0.87, 1.00, 0.57, 0.54, 0.87, 0.18 ], 
    #                        [0.64, 0.69, 0.61, 0.56, 0.53, 0.57, 1.00, 0.45, 0.73, 0.06 ], 
    #                        [0.75, 0.77, 0.77, 0.66, 0.63, 0.54, 0.45, 1.00, 0.58, 0.09 ], 
    #                        [0.79, 0.86, 0.77, 0.85, 0.85, 0.87, 0.73, 0.58, 1.00, 0.17 ], 
    #                        [0.14, 0.07, 0.06, 0.19, 0.18, 0.18, 0.06, 0.09, 0.17, 1.00 ] ]
    
    # @weights = [0.30, 0.10, 0.10, 0.40, 0.0, 0.10, 0.0, 0.0, 0.0, 0.0]

    # @mean = @mean.to_json
    # @std_dev = @std_dev.to_json
    # @skew = @skew.to_json
    # @kurt = @kurt.to_json
    # @correlation = @correlation.to_json
    # @weights = @weights.to_json
  
    @python_simulation = JSON.parse(`python3 lib/assets/python/simulation.py "#{@mean}" "#{@std_dev}" "#{@skew}" "#{@kurt}" "#{@correlation}" "#{@weights}" "#{@yields}" "#{@bench_location}"`)
 
    render({ :template => "portfolios/calculate.html.erb" })
  end
end
