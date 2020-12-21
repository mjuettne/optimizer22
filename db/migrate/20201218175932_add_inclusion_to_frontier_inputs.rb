class AddInclusionToFrontierInputs < ActiveRecord::Migration[6.0]
  def change
    add_column :frontier_inputs, :inclusion, :string
  end
end
