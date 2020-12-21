class AddSubtypeToAssetClasses < ActiveRecord::Migration[6.0]
  def change
    add_column :asset_classes, :subtype, :string
  end
end
