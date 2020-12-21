class AddCmaIdToFrontiers < ActiveRecord::Migration[6.0]
  def change
    add_column :frontiers, :cma_id, :integer
  end
end
