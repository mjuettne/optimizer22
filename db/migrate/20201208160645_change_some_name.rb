class ChangeSomeName < ActiveRecord::Migration[6.0]
  def change
    rename_column :asset_classes, :type, :broad_type
  end
end
