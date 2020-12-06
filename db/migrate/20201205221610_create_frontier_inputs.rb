class CreateFrontierInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :frontier_inputs do |t|
      t.integer :asset_class_id
      t.integer :frontier_id
      t.integer :cma_id
      t.integer :correlation_id
      t.integer :min
      t.integer :max

      t.timestamps
    end
  end
end
