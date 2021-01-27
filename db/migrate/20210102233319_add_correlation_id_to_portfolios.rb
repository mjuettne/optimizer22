class AddCorrelationIdToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :correlation_id, :integer
  end
end
