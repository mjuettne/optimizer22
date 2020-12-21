# == Schema Information
#
# Table name: asset_classes
#
#  id         :integer          not null, primary key
#  broad_type :string
#  goal       :string
#  name       :string
#  subtype    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AssetClass < ApplicationRecord
  has_many(:weights, { :class_name => "Weight", :foreign_key => "asset_class_id", :dependent => :destroy })
  has_many(:frontier_inputs, { :class_name => "FrontierInput", :foreign_key => "asset_class_id", :dependent => :destroy })
  has_many(:cma_inputs, { :class_name => "CmaInput", :foreign_key => "asset_class_id", :dependent => :destroy })
  has_many(:correlation_inputs, { :class_name => "CorrelationInput", :foreign_key => "asset_class1_id", :dependent => :destroy })
  has_many(:correlation_inputs2, { :class_name => "CorrelationInput", :foreign_key => "asset_class2_id", :dependent => :destroy })
end
