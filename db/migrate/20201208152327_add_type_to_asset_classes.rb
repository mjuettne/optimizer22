class AddTypeToAssetClasses < ActiveRecord::Migration[6.0]
  def change
    add_column :asset_classes, :type, :string
  end
end
