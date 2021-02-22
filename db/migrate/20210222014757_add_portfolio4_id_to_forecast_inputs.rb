class AddPortfolio4IdToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :portfolio4_id, :integer
  end
end
