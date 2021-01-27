class AddCmaIdToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :cma_id, :integer
  end
end
