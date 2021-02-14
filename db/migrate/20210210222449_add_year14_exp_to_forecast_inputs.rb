class AddYear14ExpToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :year14_exp, :float
  end
end
