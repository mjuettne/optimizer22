# == Schema Information
#
# Table name: weights
#
#  id             :integer          not null, primary key
#  weight         :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  asset_class_id :integer
#  portfolio_id   :integer
#
class Weight < ApplicationRecord
  belongs_to(:portfolio, { :required => false, :class_name => "Portfolio", :foreign_key => "portfolio_id" })
  belongs_to(:asset_class, { :required => false, :class_name => "AssetClass", :foreign_key => "asset_class_id" })
end
