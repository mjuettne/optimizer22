# == Schema Information
#
# Table name: forecasts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Forecast < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  has_many(:forecast_inputs, { :class_name => "ForecastInput", :foreign_key => "forecast_id", :dependent => :destroy })
end
