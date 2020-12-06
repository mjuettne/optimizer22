class CreateCmaInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :cma_inputs do |t|
      t.integer :cma_id
      t.float :exp_ret
      t.float :std_dev
      t.float :skew
      t.float :kurt
      t.float :yield
      t.integer :asset_class_id

      t.timestamps
    end
  end
end
