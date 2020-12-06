class CreateCorrelationInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :correlation_inputs do |t|
      t.integer :correlation_id
      t.integer :asset_class1_id
      t.integer :asset_class2_id
      t.float :correl

      t.timestamps
    end
  end
end
