class AddPortfolio5IdToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :portfolio5_id, :integer
  end
end
