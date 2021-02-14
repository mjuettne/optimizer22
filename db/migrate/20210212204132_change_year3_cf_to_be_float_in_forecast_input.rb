class ChangeYear3CfToBeFloatInForecastInput < ActiveRecord::Migration[6.0]
  def change
    change_column :forecast_inputs, :year3_cf, :float
  end
end
