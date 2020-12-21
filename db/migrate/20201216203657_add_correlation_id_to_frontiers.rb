class AddCorrelationIdToFrontiers < ActiveRecord::Migration[6.0]
  def change
    add_column :frontiers, :correlation_id, :integer
  end
end
