class AddUserIdToForecastInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :forecast_inputs, :user_id, :integer
  end
end
