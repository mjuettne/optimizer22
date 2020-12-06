# == Schema Information
#
# Table name: correlations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Correlation < ApplicationRecord
has_many(:correlation_inputs, { :class_name => "CorrelationInput", :foreign_key => "correlation_id", :dependent => :destroy })
has_many(:frontier_inputs, { :class_name => "FrontierInput", :foreign_key => "correlation_id", :dependent => :destroy })
has_many(:forecast_inputs, { :class_name => "ForecastInput", :foreign_key => "correlation_id", :dependent => :destroy })
has_many(:forecast_inputs_year1_correl, { :class_name => "ForecastInput", :foreign_key => "year1_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year2_correl, { :class_name => "ForecastInput", :foreign_key => "year2_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year3_correl, { :class_name => "ForecastInput", :foreign_key => "year3_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year4_correl, { :class_name => "ForecastInput", :foreign_key => "year4_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year5_correl, { :class_name => "ForecastInput", :foreign_key => "year5_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year6_correl, { :class_name => "ForecastInput", :foreign_key => "year6_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year7_correl, { :class_name => "ForecastInput", :foreign_key => "year7_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year8_correl, { :class_name => "ForecastInput", :foreign_key => "year8_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year9_correl, { :class_name => "ForecastInput", :foreign_key => "year9_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year10_correl, { :class_name => "ForecastInput", :foreign_key => "year10_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year11_correl, { :class_name => "ForecastInput", :foreign_key => "year11_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year12_correl, { :class_name => "ForecastInput", :foreign_key => "year12_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year13_correl, { :class_name => "ForecastInput", :foreign_key => "year13_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year14_correl, { :class_name => "ForecastInput", :foreign_key => "year14_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year15_correl, { :class_name => "ForecastInput", :foreign_key => "year15_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year16_correl, { :class_name => "ForecastInput", :foreign_key => "year16_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year17_correl, { :class_name => "ForecastInput", :foreign_key => "year17_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year18_correl, { :class_name => "ForecastInput", :foreign_key => "year18_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year19_correl, { :class_name => "ForecastInput", :foreign_key => "year19_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year20_correl, { :class_name => "ForecastInput", :foreign_key => "year20_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year21_correl, { :class_name => "ForecastInput", :foreign_key => "year21_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year22_correl, { :class_name => "ForecastInput", :foreign_key => "year22_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year23_correl, { :class_name => "ForecastInput", :foreign_key => "year23_correl_id", :dependent => :destroy })
has_many(:forecast_inputsforecast_inputs_year24_correl, { :class_name => "ForecastInput", :foreign_key => "year24_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year25_correl, { :class_name => "ForecastInput", :foreign_key => "year25_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year26_correl, { :class_name => "ForecastInput", :foreign_key => "year26_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year27_correl, { :class_name => "ForecastInput", :foreign_key => "year27_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year28_correl, { :class_name => "ForecastInput", :foreign_key => "year28_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year29_correl, { :class_name => "ForecastInput", :foreign_key => "year29_correl_id", :dependent => :destroy })
has_many(:forecast_inputs_year30_correl, { :class_name => "ForecastInput", :foreign_key => "year30_correl_id", :dependent => :destroy })
end
