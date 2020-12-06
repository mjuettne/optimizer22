# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password
  has_many(:portfolios, { :class_name => "Portfolio", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:frontiers, { :class_name => "Frontier", :foreign_key => "user_id", :dependent => :destroy })
  has_many(:forecasts, { :class_name => "Forecast", :foreign_key => "user_id", :dependent => :destroy })
end
