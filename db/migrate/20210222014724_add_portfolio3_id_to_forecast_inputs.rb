class AddPortfolio3IdToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :portfolio3_id, :integer
  end
end
