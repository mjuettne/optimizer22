# == Schema Information
#
# Table name: cma_inputs
#
#  id             :integer          not null, primary key
#  exp_ret        :float
#  kurt           :float
#  skew           :float
#  std_dev        :float
#  yield          :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  asset_class_id :integer
#  cma_id         :integer
#
class CmaInput < ApplicationRecord
belongs_to(:asset_class, { :required => false, :class_name => "AssetClass", :foreign_key => "asset_class_id" })
belongs_to(:cma, { :required => false, :class_name => "Cma", :foreign_key => "cma_id" })
end
