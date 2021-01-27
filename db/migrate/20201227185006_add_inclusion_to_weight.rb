class AddInclusionToWeight < ActiveRecord::Migration[6.0]
  def change
    add_column :weights, :inclusion, :string
  end
end
