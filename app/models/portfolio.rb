# == Schema Information
#
# Table name: portfolios
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cma_id         :integer
#  correlation_id :integer
#  user_id        :integer
#
class Portfolio < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  has_many(:weights, { :class_name => "Weight", :foreign_key => "portfolio_id", :dependent => :destroy })
  has_many(:forecast_inputs, { :class_name => "ForecastInput", :foreign_key => "portfolio1_id", :dependent => :destroy })
  has_many(:forecast_inputs2, { :class_name => "ForecastInput", :foreign_key => "portfolio2_id", :dependent => :destroy })
end
