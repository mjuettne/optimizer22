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

    query_mean = params.fetch("query_mean")
    query_std_dev = params.fetch("query_std_dev")
    query_skew = params.fetch("query_skew")
    query_kurt = params.fetch("query_kurt")
    query_yield = params.fetch("query_yield")
    @query_asset_id = params.fetch("query_asset_id")
    
    query_min = params.fetch("query_min")
    query_max = params.fetch("query_max")

    coreltation_id = params.fetch("coreltation_id")
    correlation_inputs = CorrelationInput.all.where({:correlation_id => coreltation_id})
    length = @query_asset_id.length.to_i
    @length = length + 1
    mean = query_mean
    std_dev = query_std_dev
    @skew = query_skew
    @kurt = query_kurt

    @correlation = Matrix.build(@length-1) {1}
    for i in 0...length
      for j in 0...i
        @correlation[i,j] = correlation_inputs.where(:asset_class1 => @query_asset_id[i]).where(:asset_class2 => @query_asset_id[j])[0].correl
        @correlation[j,i] = correlation_inputs.where(:asset_class1 => @query_asset_id[i]).where(:asset_class2 => @query_asset_id[j])[0].correl
      end
    end

    
    @mean = Array.new(length)
    for i in 0...length
      @mean[i] = mean[i].to_f/100
    end

    @std_dev = Array.new(length)
    for i in 0...length
      @std_dev[i] = std_dev[i].to_f/100
    end
    
    @min_max = Array.new(length) { Array.new(2) }
    for i in 0...length
      @min_max[i][0] = query_min[i].to_f/100
      @min_max[i][1] = query_max[i].to_f/100
    end


    # mean = mean.to_json
    # std_dev = std_dev.to_json
    # skew = skew.to_json
    # kurt = kurt.to_json
    # correlation = @correlation.to_json
    # min_max = @min_max.to_json
 
    
    # @python_output = JSON.parse(`python3 lib/assets/python/fleishman.py "#{mean}" "#{std_dev}" "#{skew}" "#{kurt}" "#{correlation}" `)

    # @python_optimizer = JSON.parse(`python3 lib/assets/python/optimization.py "#{mean}" "#{std_dev}" "#{skew}" "#{kurt}" "#{correlation}" "#{min_max}" `)


    render({ :template => "frontiers/calculate.html.erb" })
  end
end
