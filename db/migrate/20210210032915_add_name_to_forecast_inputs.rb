class AddNameToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :name, :string
  end
end
