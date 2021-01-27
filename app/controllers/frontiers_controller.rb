class FrontiersController < ApplicationController
  def index
    matching_frontiers = Frontier.all
    @cmas = Cma.all
    @correlations = Correlation.all
    @list_of_frontiers = matching_frontiers.order({ :created_at => :desc })
    matching_asset_classes = AssetClass.all
    @list_of_asset_classes = matching_asset_classes.order({ :created_at => :asc })
    render({ :template => "frontiers/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    matching_frontiers = Frontier.where({ :id => the_id })
    matching_asset_classes = AssetClass.all
    @list_of_asset_classes = matching_asset_classes.order({ :created_at => :asc })
    @cmas = Cma.all
    @correlations = Correlation.all
   
    @the_frontier = matching_frontiers.at(0)
    @the_frontier_inputs = FrontierInput.all.where({:frontier_id => @the_frontier.id})    
    @cma_inputs = CmaInput.all
    render({ :template => "frontiers/show.html.erb" })
  end

  def create
    the_frontier = Frontier.new
    the_frontier.user_id = params.fetch("query_user_id")
    the_frontier.name = params.fetch("query_name")
    
    the_frontier.cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    the_frontier.correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    the_frontier.save
    frontiers = Frontier.all
    newest_frontier_id = frontiers.order({ :created_at => :desc }).at(0).id
    
    query_asset_class_id = params.fetch("query_asset_class_id")
    query_min = params.fetch("query_min")
    query_max = params.fetch("query_max")

    @checks     = params.fetch("include")
    # render({ :template => "frontiers/create.html.erb" })
    cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id
    length = query_min.length.to_i
    # length = length + 1

    for i in 0...length
          the_frontier_input = FrontierInput.new
          the_frontier_input.frontier_id = newest_frontier_id
          the_frontier_input.asset_class_id = query_asset_class_id[i]
          the_frontier_input.min = query_min[i]
          the_frontier_input.max = query_max[i]
          the_frontier_input.cma_id = cma_id
          the_frontier_input.correlation_id = correlation_id
          if @checks.include? query_asset_class_id[i].to_s
             the_frontier_input.inclusion = "yes"
          else
             the_frontier_input.inclusion = "no"
          end  
            the_frontier_input.save
   end
    redirect_to("/frontiers/#{newest_frontier_id}", { :notice => "Frontier created successfully." })
  end

  def edit
    the_id = params.fetch("path_id")
    matching_frontiers = Frontier.where({ :id => the_id })
    matching_asset_classes = AssetClass.all
    @the_frontier = matching_frontiers.at(0)
    @the_frontier_inputs = FrontierInput.all.where({:frontier_id => @the_frontier.id})    
    @cma_inputs = CmaInput.all
    @list_of_asset_classes = matching_asset_classes.order({ :created_at => :asc })
    render({ :template => "frontiers/edit.html.erb" })
  end

  def update
    the_id = params.fetch("path_id")
    the_frontier = Frontier.where({ :id => the_id }).at(0)
    the_frontier.name = params.fetch("query_name")
    the_frontier.cma_id = Cma.all.where({:name => params.fetch("query_cma")}).at(0).id
    the_frontier.correlation_id = Correlation.all.where({:name => params.fetch("query_correlation")}).at(0).id

    if the_frontier.valid?
      the_frontier.save
      redirect_to("/frontiers/#{the_frontier.id}", { :notice => "Frontier updated successfully."} )
    else
      redirect_to("/frontiers/#{the_frontier.id}", { :alert => "Frontier failed to update successfully." })
    end
  end

  def update_all
    the_frontier_id = params.fetch("path_id")
    the_frontier = Frontier.where({ :id => the_frontier_id }).at(0)
    
    the_id = params.fetch("query_id")
    inclusion = params.fetch("include")
    query_min = params.fetch("query_min")
    query_max = params.fetch("query_max")

    query_asset_class_id = params.fetch("query_asset_class_id")
    length = query_min.length.to_i

    for i in 0...length
    the_frontier_input = FrontierInput.where({:id => the_id[i] }).at(0)
    the_frontier_input.min =  query_min[i]
    the_frontier_input.max =  query_max[i]
    
    if inclusion.include? query_asset_class_id[i].to_s
        the_frontier_input.inclusion = "yes"
       else
       the_frontier_input.inclusion = "no"
    end  
    the_frontier_input.save
    end
    redirect_to("/frontiers/#{the_frontier.id}", { :notice => "Frontier updated successfully."} )
    
  end




  def destroy
    the_id = params.fetch("path_id")
    the_frontier = Frontier.where({ :id => the_id }).at(0)

    the_frontier.destroy

    redirect_to("/frontiers", { :notice => "Frontier deleted successfully."} )
  end

  def calculate
    require 'json'
    require 'matrix'
    @frontier_id = params.fetch("frontier_id")
    @the_frotnier = Frontier.all.where({:id => @frontier_id }).at(0)
    @all_asset_class = AssetClass.all
    @cma_name = Cma.all.where({:id => @the_frotnier.cma_id}).at(0).name
    @correlation_name = Correlation.all.where({:id => @the_frotnier.correlation_id}).at(0).name

    query_mean = params.fetch("query_mean")
    query_std_dev = params.fetch("query_std_dev")
    query_skew = params.fetch("query_skew")
    query_kurt = params.fetch("query_kurt")
    query_yield = params.fetch("query_yield")
    @query_asset_id = params.fetch("query_asset_id")
    
    query_min = params.fetch("query_min")
    query_max = params.fetch("query_max")

    query_left_constraints1 = params.fetch("query_left_constraints1")
    query_left_constraints2 = params.fetch("query_left_constraints2")
    query_left_constraints3 = params.fetch("query_left_constraints3")

    @query_left_constraints1 =  @all_asset_class.where({:name => query_left_constraints1}).ids
    @query_left_constraints2 =  @all_asset_class.where({:name => query_left_constraints2}).ids
    @query_left_constraints3 =  @all_asset_class.where({:name => query_left_constraints3}).ids

    @left = [@query_left_constraints1,  @query_left_constraints2,  @query_left_constraints3 ]

    query_right_constraints1 = params.fetch("query_right_constraints1")
    query_right_constraints2 = params.fetch("query_right_constraints2")
    query_right_constraints3 = params.fetch("query_right_constraints3")

    @query_right_constraints1 =  @all_asset_class.where({:name => query_right_constraints1}).ids
    @query_right_constraints2 =  @all_asset_class.where({:name => query_right_constraints2}).ids
    @query_right_constraints3 =  @all_asset_class.where({:name => query_right_constraints3}).ids

    @right = [@query_right_constraints1, @query_right_constraints2, @query_right_constraints3 ]

    @query_right2_constraints1 = params.fetch("query_right2_constraints1").to_f/100
    @query_right2_constraints2 = params.fetch("query_right2_constraints2").to_f/100
    @query_right2_constraints3 = params.fetch("query_right2_constraints3").to_f/100

    @right2 = [@query_right2_constraints1, @query_right2_constraints2, @query_right2_constraints3 ]

    @query_left2_constraints1 = params.fetch("query_left2_constraints1").to_f/100
    @query_left2_constraints2 = params.fetch("query_left2_constraints2").to_f/100
    @query_left2_constraints3 = params.fetch("query_left2_constraints3").to_f/100

    @left2 = [@query_left2_constraints1, @query_left2_constraints2, @query_left2_constraints3 ]

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
    
    @min_max = Array.new(@length) { Array.new(2) }
    for i in 0...@length
      @min_max[i][0] = query_min[i].to_f/100
      @min_max[i][1] = query_max[i].to_f/100
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

    
    @mean = @mean.to_json
    @std_dev = @std_dev.to_json
    @skew = @skew.to_json
    @kurt = @kurt.to_json
    @correlation = @correlation.to_json
    @min_max = @min_max.to_json
    @left = @left.to_json
    @right = @right.to_json
    @right2 = @right2.to_json
    @left2 = @left2.to_json
    query_asset_id = @query_asset_id.to_json
    @yields = @yields.to_json

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
    
    # @min_max = [[0,0.6],[0,0.20],[0,0.20],[0,0.50],[0,0.15],[0,0.25],[0,0.20],[0,0.20],[0,0.15],[0,0.20] ]
    # @left = [[1, 2, 3], [4], [1]]
    # @right = [[4, 5, 6], [6], [3]]
    # @right2 = [0.0, 0.0, 0.0]
    # @left2 = [50.0, 100.0, 100.0]
    # @query_asset_id = [1,2,3,4,5,6,7,8,9,10]
    # @yields = [1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1, 1.1]
    
    # @mean = @mean.to_json
    # @std_dev = @std_dev.to_json
    # @skew = @skew.to_json
    # @kurt = @kurt.to_json
    # @correlation = @correlation.to_json
    # @min_max = @min_max.to_json
    # @left = @left.to_json
    # @right = @right.to_json
    # @right2 = @right2.to_json
    # @left2 = @left2.to_json
    # query_asset_id = @query_asset_id.to_json
    # @yields = @yields.to_json

    @python_optimizer = JSON.parse(`python3 lib/assets/python/optimization.py "#{@mean}" "#{@std_dev}" "#{@skew}" "#{@kurt}" "#{@correlation}" "#{@min_max}" "#{@left}" "#{@right}" "#{@right2}" "#{query_asset_id}" "#{@yields}" "#{@left2}" `)
    # @python_output = JSON.parse(`python3 lib/assets/python/fleishman.py "#{mean}" "#{std_dev}" "#{skew}" "#{kurt}" "#{correlation}" `)


    render({ :template => "frontiers/calculate.html.erb" })
  end

  def download
   @asset_ids = params.fetch("assets")
   @assets = AssetClass.all.where({:id => @asset_ids})  
   
   @weights_col1 =  params.fetch("weights_col1")
   @weights_col2 =  params.fetch("weights_col2")
   @weights_col3 =  params.fetch("weights_col3")
   @weights_col4 =  params.fetch("weights_col4")
   @weights_col5 =  params.fetch("weights_col5")
   @weights_col6 =  params.fetch("weights_col6")
   @weights_col7 =  params.fetch("weights_col7")

   @return_col1 = params.fetch("return_col1")
   @return_col2 = params.fetch("return_col2")
   @return_col3 = params.fetch("return_col3")
   @return_col4 = params.fetch("return_col4")
   @return_col5 = params.fetch("return_col5")
   @return_col6 = params.fetch("return_col6")
   @return_col7 = params.fetch("return_col7")

   @cvar_col1 = params.fetch("cvar_col1").to_f
   @cvar_col2 = params.fetch("cvar_col2").to_f
   @cvar_col3 = params.fetch("cvar_col3").to_f
   @cvar_col4 = params.fetch("cvar_col4").to_f
   @cvar_col5 = params.fetch("cvar_col5").to_f
   @cvar_col6 = params.fetch("cvar_col6").to_f
   @cvar_col7 = params.fetch("cvar_col7").to_f
   
   @sharpe_col1 = params.fetch("sharpe_col1")
   @sharpe_col2 = params.fetch("sharpe_col2")
   @sharpe_col3 = params.fetch("sharpe_col3")
   @sharpe_col4 = params.fetch("sharpe_col4")
   @sharpe_col5 = params.fetch("sharpe_col5")
   @sharpe_col6 = params.fetch("sharpe_col6")
   @sharpe_col7 = params.fetch("sharpe_col7")

   @yield_col1 = params.fetch("yield_col1")
   @yield_col2 = params.fetch("yield_col2")
   @yield_col3 = params.fetch("yield_col3")
   @yield_col4 = params.fetch("yield_col4")
   @yield_col5 = params.fetch("yield_col5")
   @yield_col6 = params.fetch("yield_col6")
   @yield_col7 = params.fetch("yield_col7")

   @year1_col1 = params.fetch("year1_col1")
   @year1_col2 = params.fetch("year1_col2")
   @year1_col3 = params.fetch("year1_col3")
   @year1_col4 = params.fetch("year1_col4")
   @year1_col5 = params.fetch("year1_col5")
   @year1_col6 = params.fetch("year1_col6")
   @year1_col7 = params.fetch("year1_col7")

   @year2_col1 = params.fetch("year2_col1")
   @year2_col2 = params.fetch("year2_col2")
   @year2_col3 = params.fetch("year2_col3")
   @year2_col4 = params.fetch("year2_col4")
   @year2_col5 = params.fetch("year2_col5")
   @year2_col6 = params.fetch("year2_col6")
   @year2_col7 = params.fetch("year2_col7")

   @year3_col1 = params.fetch("year3_col1")
   @year3_col2 = params.fetch("year3_col2")
   @year3_col3 = params.fetch("year3_col3")
   @year3_col4 = params.fetch("year3_col4")
   @year3_col5 = params.fetch("year3_col5")
   @year3_col6 = params.fetch("year3_col6")
   @year3_col7 = params.fetch("year3_col7")

   @year4_col1 = params.fetch("year4_col1")
   @year4_col2 = params.fetch("year4_col2")
   @year4_col3 = params.fetch("year4_col3")
   @year4_col4 = params.fetch("year4_col4")
   @year4_col5 = params.fetch("year4_col5")
   @year4_col6 = params.fetch("year4_col6")
   @year4_col7 = params.fetch("year4_col7")

   @year5_col1 = params.fetch("year5_col1")
   @year5_col2 = params.fetch("year5_col2")
   @year5_col3 = params.fetch("year5_col3")
   @year5_col4 = params.fetch("year5_col4")
   @year5_col5 = params.fetch("year5_col5")
   @year5_col6 = params.fetch("year5_col6")
   @year5_col7 = params.fetch("year5_col7")

   @year6_col1 = params.fetch("year6_col1")
   @year6_col2 = params.fetch("year6_col2")
   @year6_col3 = params.fetch("year6_col3")
   @year6_col4 = params.fetch("year6_col4")
   @year6_col5 = params.fetch("year6_col5")
   @year6_col6 = params.fetch("year6_col6")
   @year6_col7 = params.fetch("year6_col7")

   @year7_col1 = params.fetch("year7_col1")
   @year7_col2 = params.fetch("year7_col2")
   @year7_col3 = params.fetch("year7_col3")
   @year7_col4 = params.fetch("year7_col4")
   @year7_col5 = params.fetch("year7_col5")
   @year7_col6 = params.fetch("year7_col6")
   @year7_col7 = params.fetch("year7_col7")

   @year8_col1 = params.fetch("year8_col1")
   @year8_col2 = params.fetch("year8_col2")
   @year8_col3 = params.fetch("year8_col3")
   @year8_col4 = params.fetch("year8_col4")
   @year8_col5 = params.fetch("year8_col5")
   @year8_col6 = params.fetch("year8_col6")
   @year8_col7 = params.fetch("year8_col7")

   @year9_col1 = params.fetch("year9_col1")
   @year9_col2 = params.fetch("year9_col2")
   @year9_col3 = params.fetch("year9_col3")
   @year9_col4 = params.fetch("year9_col4")
   @year9_col5 = params.fetch("year9_col5")
   @year9_col6 = params.fetch("year9_col6")
   @year9_col7 = params.fetch("year9_col7")

   @year10_col1 = params.fetch("year10_col1")
   @year10_col2 = params.fetch("year10_col2")
   @year10_col3 = params.fetch("year10_col3")
   @year10_col4 = params.fetch("year10_col4")
   @year10_col5 = params.fetch("year10_col5")
   @year10_col6 = params.fetch("year10_col6")
   @year10_col7 = params.fetch("year10_col7")

  render xlsx:  "frontiers/download.xlsx.axlsx", filename: "Frontier-#{DateTime.now.to_date}.xlsx"

  end
end
