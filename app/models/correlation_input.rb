# == Schema Information
#
# Table name: correlation_inputs
#
#  id              :integer          not null, primary key
#  correl          :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  asset_class1_id :integer
#  asset_class2_id :integer
#  correlation_id  :integer
#
class CorrelationInput < ApplicationRecord
belongs_to(:asset_class1, { :required => false, :class_name => "AssetClass", :foreign_key => "asset_class1_id" })
belongs_to(:asset_class2, { :required => false, :class_name => "AssetClass", :foreign_key => "asset_class2_id" })
belongs_to(:correlation, { :required => false, :class_name => "Correlation", :foreign_key => "correlation_id" })
end
