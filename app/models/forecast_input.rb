# == Schema Information
#
# Table name: forecast_inputs
#
#  id               :integer          not null, primary key
#  income           :float
#  inflation        :float
#  name             :string
#  spend_value      :float
#  starting_value   :float
#  weight_port1     :float
#  weight_port2     :float
#  year10_cf        :float
#  year10_exp       :float
#  year11_cf        :float
#  year11_exp       :float
#  year12_cf        :float
#  year12_exp       :float
#  year13_cf        :float
#  year13_exp       :float
#  year14_cf        :float
#  year14_exp       :float
#  year15_cf        :float
#  year15_exp       :float
#  year16_cf        :float
#  year16_exp       :float
#  year17_cf        :float
#  year17_exp       :float
#  year18_cf        :float
#  year18_exp       :float
#  year19_cf        :float
#  year19_exp       :float
#  year1_cf         :float
#  year1_exp        :float
#  year20_cf        :float
#  year20_exp       :float
#  year21_cf        :float
#  year21_exp       :float
#  year22_cf        :float
#  year22_exp       :float
#  year23_cf        :float
#  year23_exp       :float
#  year24_cf        :float
#  year24_exp       :float
#  year25_cf        :float
#  year25_exp       :float
#  year26_cf        :float
#  year26_exp       :float
#  year27_cf        :float
#  year27_exp       :float
#  year28_cf        :float
#  year28_exp       :float
#  year29_cf        :float
#  year29_exp       :float
#  year2_cf         :float
#  year2_exp        :float
#  year30_cf        :float
#  year30_exp       :float
#  year3_cf         :float
#  year3_exp        :float
#  year4_cf         :float
#  year4_exp        :float
#  year5_cf         :float
#  year5_exp        :float
#  year6_cf         :float
#  year6_exp        :float
#  year7_cf         :float
#  year7_exp        :float
#  year8_cf         :float
#  year8_exp        :float
#  year9_cf         :float
#  year9_exp        :float
#  years_forecast   :integer
#  years_income     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  cma_id           :integer
#  correlation_id   :integer
#  forecast_id      :integer
#  portfolio1_id    :integer
#  portfolio2_id    :integer
#  user_id          :integer
#  year10_cma_id    :integer
#  year10_correl_id :integer
#  year11_cma_id    :integer
#  year11_correl_id :integer
#  year12_cma_id    :integer
#  year12_correl_id :integer
#  year13_cma_id    :integer
#  year13_correl_id :integer
#  year14_cma_id    :integer
#  year14_correl_id :integer
#  year15_cma_id    :integer
#  year15_correl_id :integer
#  year16_cma_id    :integer
#  year16_correl_id :integer
#  year17_cma_id    :integer
#  year17_correl_id :integer
#  year18_cma_id    :integer
#  year18_correl_id :integer
#  year19_cma_id    :integer
#  year19_correl_id :integer
#  year1_cma_id     :integer
#  year1_correl_id  :integer
#  year20_cma_id    :integer
#  year20_correl_id :integer
#  year21_cma_id    :integer
#  year21_correl_id :integer
#  year22_cma_id    :integer
#  year22_correl_id :integer
#  year23_cma_id    :integer
#  year23_correl_id :integer
#  year24_cma_id    :integer
#  year24_correl_id :integer
#  year25_cma_id    :integer
#  year25_correl_id :integer
#  year26_cma_id    :integer
#  year26_correl_id :integer
#  year27_cma_id    :integer
#  year27_correl_id :integer
#  year28_cma_id    :integer
#  year28_correl_id :integer
#  year29_cma_id    :integer
#  year29_correl_id :integer
#  year2_cma_id     :integer
#  year2_correl_id  :integer
#  year30_cma_id    :integer
#  year30_correl_id :integer
#  year3_cma_id     :integer
#  year3_correl_id  :integer
#  year4_cma_id     :integer
#  year4_correl_id  :integer
#  year5_cma_id     :integer
#  year5_correl_id  :integer
#  year6_cma_id     :integer
#  year6_correl_id  :integer
#  year7_cma_id     :integer
#  year7_correl_id  :integer
#  year8_cma_id     :integer
#  year8_correl_id  :integer
#  year9_cma_id     :integer
#  year9_correl_id  :integer
#
class ForecastInput < ApplicationRecord
belongs_to(:portfolio1, { :required => false, :class_name => "Portfolio", :foreign_key => "portfolio1_id" })
belongs_to(:portfolio2, { :required => false, :class_name => "Portfolio", :foreign_key => "portfolio2_id" })
belongs_to(:forecast, { :required => false, :class_name => "Forecast", :foreign_key => "forecast_id" })
belongs_to(:cma, { :required => false, :class_name => "Cma", :foreign_key => "cma_id" })
belongs_to(:year1_cma, { :required => false, :class_name => "Cma", :foreign_key => "year1_cma_id" })
belongs_to(:year2_cma, { :required => false, :class_name => "Cma", :foreign_key => "year2_cma_id" })
belongs_to(:year3_cma, { :required => false, :class_name => "Cma", :foreign_key => "year3_cma_id" })
belongs_to(:year4_cma, { :required => false, :class_name => "Cma", :foreign_key => "year4_cma_id" })
belongs_to(:year5_cma, { :required => false, :class_name => "Cma", :foreign_key => "year5_cma_id" })
belongs_to(:year6_cma, { :required => false, :class_name => "Cma", :foreign_key => "year6_cma_id" })
belongs_to(:year7_cma, { :required => false, :class_name => "Cma", :foreign_key => "year7_cma_id" })
belongs_to(:year8_cma, { :required => false, :class_name => "Cma", :foreign_key => "year8_cma_id" })
belongs_to(:year9_cma, { :required => false, :class_name => "Cma", :foreign_key => "year9_cma_id" })
belongs_to(:year10_cma, { :required => false, :class_name => "Cma", :foreign_key => "year10_cma_id" })
belongs_to(:year11_cma, { :required => false, :class_name => "Cma", :foreign_key => "year11_cma_id" })
belongs_to(:year12_cma, { :required => false, :class_name => "Cma", :foreign_key => "year12_cma_id" })
belongs_to(:year13_cma, { :required => false, :class_name => "Cma", :foreign_key => "year13_cma_id" })
belongs_to(:year14_cma, { :required => false, :class_name => "Cma", :foreign_key => "year14_cma_id" })
belongs_to(:year15_cma, { :required => false, :class_name => "Cma", :foreign_key => "year15_cma_id" })
belongs_to(:year16_cma, { :required => false, :class_name => "Cma", :foreign_key => "year16_cma_id" })
belongs_to(:year17_cma, { :required => false, :class_name => "Cma", :foreign_key => "year17_cma_id" })
belongs_to(:year18_cma, { :required => false, :class_name => "Cma", :foreign_key => "year18_cma_id" })
belongs_to(:year19_cma, { :required => false, :class_name => "Cma", :foreign_key => "year19_cma_id" })
belongs_to(:year20_cma, { :required => false, :class_name => "Cma", :foreign_key => "year20_cma_id" })
belongs_to(:year21_cma, { :required => false, :class_name => "Cma", :foreign_key => "year21_cma_id" })
belongs_to(:year22_cma, { :required => false, :class_name => "Cma", :foreign_key => "year22_cma_id" })
belongs_to(:year23_cma, { :required => false, :class_name => "Cma", :foreign_key => "year23_cma_id" })
belongs_to(:year24_cma, { :required => false, :class_name => "Cma", :foreign_key => "year24_cma_id" })
belongs_to(:year25_cma, { :required => false, :class_name => "Cma", :foreign_key => "year25_cma_id" })
belongs_to(:year26_cma, { :required => false, :class_name => "Cma", :foreign_key => "year26_cma_id" })
belongs_to(:year27_cma, { :required => false, :class_name => "Cma", :foreign_key => "year27_cma_id" })
belongs_to(:year28_cma, { :required => false, :class_name => "Cma", :foreign_key => "year28_cma_id" })
belongs_to(:year29_cma, { :required => false, :class_name => "Cma", :foreign_key => "year29_cma_id" })
belongs_to(:year30_cma, { :required => false, :class_name => "Cma", :foreign_key => "year30_cma_id" })
belongs_to(:correlation, { :required => false, :class_name => "Correlation", :foreign_key => "correlation_id" })
belongs_to(:year1_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year1_correl_id" })
belongs_to(:year2_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year2_correl_id" })
belongs_to(:year3_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year3_correl_id" })
belongs_to(:year4_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year4_correl_id" })
belongs_to(:year5_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year5_correl_id" })
belongs_to(:year6_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year6_correl_id" })
belongs_to(:year7_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year7_correl_id" })
belongs_to(:year8_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year8_correl_id" })
belongs_to(:year9_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year9_correl_id" })
belongs_to(:year10_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year10_correl_id" })
belongs_to(:year11_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year11_correl_id" })
belongs_to(:year12_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year12_correl_id" })
belongs_to(:year13_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year13_correl_id" })
belongs_to(:year14_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year14_correl_id" })
belongs_to(:year15_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year15_correl_id" })
belongs_to(:year16_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year16_correl_id" })
belongs_to(:year17_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year17_correl_id" })
belongs_to(:year18_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year18_correl_id" })
belongs_to(:year19_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year19_correl_id" })
belongs_to(:year20_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year20_correl_id" })
belongs_to(:year21_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year21_correl_id" })
belongs_to(:year22_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year22_correl_id" })
belongs_to(:year23_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year23_correl_id" })
belongs_to(:year24_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year24_correl_id" })
belongs_to(:year25_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year25_correl_id" })
belongs_to(:year26_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year26_correl_id" })
belongs_to(:year27_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year27_correl_id" })
belongs_to(:year28_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year28_correl_id" })
belongs_to(:year29_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year29_correl_id" })
belongs_to(:year30_correl, { :required => false, :class_name => "Correlation", :foreign_key => "year30_correl_id" })
end
