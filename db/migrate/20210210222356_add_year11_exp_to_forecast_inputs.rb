class AddYear11ExpToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :year11_exp, :float
  end
end
