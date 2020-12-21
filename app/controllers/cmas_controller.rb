class CmasController < ApplicationController
  def index
    matching_cmas = Cma.all
    @asset_class = AssetClass.all
    @cma_inputs = CmaInput.all 
    @list_of_cmas = matching_cmas.order({ :created_at => :desc })

    render({ :template => "cmas/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @asset_class = AssetClass.all
    matching_cmas = Cma.where({ :id => the_id })
    @cma_inputs = CmaInput.all 

    @thecma = matching_cmas.at(0)

    render({ :template => "cmas/show.html.erb" })
  end

  def download
    the_id = params.fetch("path_id")
    @asset_class = AssetClass.all
    @cma_inputs = CmaInput.all
    matching_cmas = Cma.where({ :id => the_id })
    @thecma = matching_cmas.at(0)

    # respond_to do |format|
    #   #  format.html
        # format.xlsx do
    render xlsx:  "cmas/download.xlsx.axlsx", filename: "#{@thecma.name}-#{DateTime.now.to_date}.xlsx"
        # end
        # end
  end

  def import
    require 'roo'
      file = params[:file]
      
      begin
            file_ext = File.extname(file.original_filename)
            raise "Unknown file type: #{file.original_filename}" unless [".xls", ".xlsx"].include?(file_ext)
            spreadsheet = (file_ext == ".xls") ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
            query_cma_input_id = spreadsheet.column(1)
            query_exp_ret = spreadsheet.column(3)
            query_std_dev = spreadsheet.column(4)
            query_skew = spreadsheet.column(5)
            query_kurt = spreadsheet.column(6)
            query_yield = spreadsheet.column(7)
            ## We are iterating from row 2 because we have left row one for header
             (2..spreadsheet.last_row).each do |i|
                the_cma_input = CmaInput.where({ :id => query_cma_input_id[i-1] }).at(0)
                the_cma_input.exp_ret = query_exp_ret[i-1]
                the_cma_input.std_dev = query_std_dev[i-1]
                the_cma_input.skew = query_skew[i-1]
                the_cma_input.kurt = query_kurt[i-1]
                the_cma_input.yield = query_yield[i-1]
                the_cma_input.save
                end
          
           redirect_to("/cmas", { :notice => "Import Successful" })
          rescue Exception => e
            flash[:notice] = "Issues with file"
            redirect_to("/cmas", { :alert => "Issues with file" })
 
          end
  end

  def create
    the_cma = Cma.new
    the_cma.name = params.fetch("query_name")
    the_cma.save
    asset_class = AssetClass.all
    all_cmas = Cma.all
    cma_name = params.fetch("query_name")
    query_cma_id = all_cmas.where(:name => cma_name)[0].id
    
    redirect_to("/insert_cma_new")
    
  end

  def create_new
    asset_class = AssetClass.all
    all_cmas = Cma.all
    query_cma_id = all_cmas.order('created_at desc')[0].id
    asset_class_length = asset_class.length.to_i
    asset_class_length = asset_class_length +1
    for i in 1...asset_class_length
    the_cma_input = CmaInput.new
    the_cma_input.cma_id = query_cma_id
    the_cma_input.exp_ret = 0.0
    the_cma_input.std_dev = 0.0
    the_cma_input.skew = 0.0
    the_cma_input.kurt = 0.0
    the_cma_input.yield = 0.0
    the_cma_input.asset_class_id = asset_class.ids[i-1]
    the_cma_input.save
    end
    redirect_to("/cmas", { :notice => "CMA created successfully." })
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
