class AddBenchmarkToPortfolios < ActiveRecord::Migration[6.0]
  def change
    add_column :portfolios, :benchmark, :integer
  end
end
