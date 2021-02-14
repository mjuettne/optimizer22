class AddYear26ExpToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :year26_exp, :float
  end
end
