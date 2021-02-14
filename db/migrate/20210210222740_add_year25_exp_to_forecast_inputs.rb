class AddYear25ExpToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :year25_exp, :float
  end
end
