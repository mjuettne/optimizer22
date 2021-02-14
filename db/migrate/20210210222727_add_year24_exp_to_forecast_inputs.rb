class AddYear24ExpToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :year24_exp, :float
  end
end
