class AddGoalToAssetClasses < ActiveRecord::Migration[6.0]
  def change
    add_column :asset_classes, :goal, :string
  end
end
