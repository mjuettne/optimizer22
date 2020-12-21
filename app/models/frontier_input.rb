# == Schema Information
#
# Table name: frontier_inputs
#
#  id             :integer          not null, primary key
#  inclusion      :string
#  max            :integer
#  min            :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  asset_class_id :integer
#  cma_id         :integer
#  correlation_id :integer
#  frontier_id    :integer
#
class FrontierInput < ApplicationRecord
  belongs_to(:frontier, { :required => false, :class_name => "Frontier", :foreign_key => "frontier_id" })
  belongs_to(:asset_class, { :required => false, :class_name => "AssetClass", :foreign_key => "asset_class_id" })
  belongs_to(:cma, { :required => false, :class_name => "Cma", :foreign_key => "cma_id" })
  belongs_to(:correlation, { :required => false, :class_name => "Correlation", :foreign_key => "correlation_id" })
end
