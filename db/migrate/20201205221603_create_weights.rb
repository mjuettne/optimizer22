class CreateWeights < ActiveRecord::Migration[6.0]
  def change
    create_table :weights do |t|
      t.integer :portfolio_id
      t.float :weight
      t.integer :asset_class_id

      t.timestamps
    end
  end
end
