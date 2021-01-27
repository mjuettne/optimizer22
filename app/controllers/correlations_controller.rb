class CorrelationsController < ApplicationController
  def index
    @asset_class = AssetClass.all
    matching_correlations = Correlation.all
    length = @asset_class.length.to_i
    @length = length +1
    @list_of_correlations = matching_correlations.order({ :created_at => :desc })
    @list_of_correlation_inputs = CorrelationInput.all
    render({ :template => "correlations/index.html.erb" })
  end

  def show
    @asset_class = AssetClass.all
    the_id = params.fetch("path_id")
    @list_of_correlation_inputs = CorrelationInput.all
    matching_correlations = Correlation.where({ :id => the_id })
    length = @asset_class.length.to_i
    @length = length +1
    @the_correlation = matching_correlations.at(0)

    render({ :template => "correlations/show.html.erb" })
  end

  def create
    the_correlation = Correlation.new
    the_correlation.name = params.fetch("query_name")
    the_correlation.save
    redirect_to("/insert_correlation_new", { :notice => "Correlation created successfully." })
  end
  
  def create_new
  asset_class = AssetClass.all
  all_correlations = Correlation.all
  correlation_id = all_correlations.order('created_at desc')[0].id
  length = asset_class.length.to_i
  length = length +1
    for i in 1...length
      for j in 1...i
      the_correlation_input = CorrelationInput.new  
      the_correlation_input.correlation_id = correlation_id
      the_correlation_input.asset_class1_id = asset_class[i-1].id
      the_correlation_input.asset_class2_id = asset_class[j-1].id
      the_correlation_input.correl = 0.95
      the_correlation_input.save
      end
    end
    for i in 1...length
    the_correlation_input = CorrelationInput.new      
    the_correlation_input.correlation_id = correlation_id
    the_correlation_input.asset_class1_id = asset_class[i-1].id
    the_correlation_input.asset_class2_id = asset_class[i-1].id
    the_correlation_input.correl = 1.0
    the_correlation_input.save
    end
  redirect_to("/correlations", { :notice => "Correlation created successfully." })
  end
  
  
  def update
    the_id = params.fetch("path_id")
    the_correlation = Correlation.where({ :id => the_id }).at(0)

    the_correlation.name = params.fetch("query_name")

    if the_correlation.valid?
      the_correlation.save
      redirect_to("/correlations/#{the_correlation.id}", { :notice => "Correlation updated successfully."} )
    else
      redirect_to("/correlations/#{the_correlation.id}", { :alert => "Correlation failed to update successfully." })
    end
  end

  def download
    the_id = params.fetch("path_id")
    @asset_class = AssetClass.all
    @correlation_inputs = CorrelationInput.all
    matching_correlations = Correlation.where({ :id => the_id })
    @the_correlation = matching_correlations.at(0)
    length = @asset_class.length.to_i
    @length = length +1
    # respond_to do |format|
    #   #  format.html
        # format.xlsx do
    render xlsx:  "cmas/download.xlsx.axlsx", filename: "#{@the_correlation.name}-#{DateTime.now.to_date}.xlsx"
  end

  def import
    require 'roo'
    file = params[:file]
    correlation_id = params.fetch("path_id")
    @asset_class = AssetClass.all
    length = @asset_class.length.to_i
    @length = length +1
 
    begin
    file_ext = File.extname(file.original_filename)
    raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx"].include?(file_ext)
    spreadsheet = (file_ext == ".xls") ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
    # @input = spreadsheet.row(1)
    # render({ :template => "correlations/import.html.erb" })
    for i in 0...@length
      for j in 1...i
          input = spreadsheet.row(i+1)[j]
          input_id = spreadsheet.row(i+1+ @length)[j]
          the_correlation = CorrelationInput.where({ :id => input_id }).at(0)
          the_correlation.correl = input
          the_correlation.save
      end
    end  
    redirect_to("/correlations", { :notice => "Import Successful" })
    rescue Exception => e
    redirect_to("/correlations", { :alert => "Issues with file" })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_correlation = Correlation.where({ :id => the_id }).at(0)

    the_correlation.destroy

    redirect_to("/correlations", { :notice => "Correlation deleted successfully."} )
  end
end
