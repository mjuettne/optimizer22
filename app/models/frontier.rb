# == Schema Information
#
# Table name: frontiers
#
#  id             :integer          not null, primary key
#  name           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cma_id         :integer
#  correlation_id :integer
#  user_id        :integer
#
class Frontier < ApplicationRecord
  belongs_to(:user, { :required => false, :class_name => "User", :foreign_key => "user_id" })
  has_many(:frontier_inputs, { :class_name => "FrontierInput", :foreign_key => "frontier_id", :dependent => :destroy })
end
