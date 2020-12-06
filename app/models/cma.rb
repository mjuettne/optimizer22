# == Schema Information
#
# Table name: cmas
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cma < ApplicationRecord
has_many(:cma_inputs, { :class_name => "CmaInput", :foreign_key => "cma_id", :dependent => :destroy })
has_many(:frontier_inputs, { :class_name => "FrontierInput", :foreign_key => "cma_id", :dependent => :destroy })
has_many(:forecast_inputs, { :class_name => "ForecastInput", :foreign_key => "cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year1, { :class_name => "ForecastInput", :foreign_key => "year1_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year2, { :class_name => "ForecastInput", :foreign_key => "year2_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year3, { :class_name => "ForecastInput", :foreign_key => "year3_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year4, { :class_name => "ForecastInput", :foreign_key => "year4_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year5, { :class_name => "ForecastInput", :foreign_key => "year5_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year6, { :class_name => "ForecastInput", :foreign_key => "year6_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year7, { :class_name => "ForecastInput", :foreign_key => "year7_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year8, { :class_name => "ForecastInput", :foreign_key => "year8_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year9, { :class_name => "ForecastInput", :foreign_key => "year9_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year10, { :class_name => "ForecastInput", :foreign_key => "year10_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year11, { :class_name => "ForecastInput", :foreign_key => "year11_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year12, { :class_name => "ForecastInput", :foreign_key => "year12_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year13, { :class_name => "ForecastInput", :foreign_key => "year13_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year14, { :class_name => "ForecastInput", :foreign_key => "year14_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year15, { :class_name => "ForecastInput", :foreign_key => "year15_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year16, { :class_name => "ForecastInput", :foreign_key => "year16_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year17, { :class_name => "ForecastInput", :foreign_key => "year17_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year18, { :class_name => "ForecastInput", :foreign_key => "year18_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year19, { :class_name => "ForecastInput", :foreign_key => "year19_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year20, { :class_name => "ForecastInput", :foreign_key => "year20_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year21, { :class_name => "ForecastInput", :foreign_key => "year21_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year22, { :class_name => "ForecastInput", :foreign_key => "year22_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year23, { :class_name => "ForecastInput", :foreign_key => "year23_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year24, { :class_name => "ForecastInput", :foreign_key => "year24_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year25, { :class_name => "ForecastInput", :foreign_key => "year25_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year26, { :class_name => "ForecastInput", :foreign_key => "year26_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year27, { :class_name => "ForecastInput", :foreign_key => "year27_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year28, { :class_name => "ForecastInput", :foreign_key => "year28_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year29, { :class_name => "ForecastInput", :foreign_key => "year29_cma_id", :dependent => :destroy })
has_many(:forecast_inputs_year30, { :class_name => "ForecastInput", :foreign_key => "year30_cma_id", :dependent => :destroy })
end
