import sys 
import json
from json import JSONEncoder
import numpy as np
from numpy.linalg import solve
import logging
logging.basicConfig(level = logging.DEBUG)
import scipy
import scipy.stats
from scipy.stats import moment,norm
import statistics as stat
from scipy.stats import kurtosis
from scipy.stats import skew
from scipy.linalg import eigh, cholesky
from scipy.stats import norm
import pandas as pd
import matplotlib.pyplot as plt
import fleishman_opt

np.set_printoptions(threshold=np.inf)

class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)


starting_value = json.loads(sys.argv[1])
income = json.loads(sys.argv[2]) ##### FROM RUBY
expense = json.loads(sys.argv[3]) ##### FROM RUBY
weights_port = json.loads(sys.argv[4]) ##### FROM RUBY
income = np.array(income)
expense = np.array(expense)

###########################
##### PORTFOLIO 1 #########
###########################
weights_port = np.array(weights_port)

##### YEAR1 (PORT 1) ######
mean_port_year1 = json.loads(sys.argv[5]) ##### FROM RUBY
std_port_year1 = json.loads(sys.argv[6]) ##### FROM RUBY
skew_port_year1 = json.loads(sys.argv[7]) ##### FROM RUBY
kurt_port_year1 = json.loads(sys.argv[8]) ##### FROM RUBY
correlation_port_year1 = json.loads(sys.argv[9]) ##### FROM RUBY
yields_port_year1 = json.loads(sys.argv[10]) ##### FROM RUBY
yields_port_year1 = np.array(yields_port_year1)

##### YEAR2 (PORT 1) ######
mean_port_year2 = json.loads(sys.argv[11]) ##### FROM RUBY
std_port_year2 = json.loads(sys.argv[12]) ##### FROM RUBY
skew_port_year2 = json.loads(sys.argv[13]) ##### FROM RUBY
kurt_port_year2 = json.loads(sys.argv[14]) ##### FROM RUBY
correlation_port_year2 = json.loads(sys.argv[15]) ##### FROM RUBY
yields_port_year2 = json.loads(sys.argv[16]) ##### FROM RUBY
yields_port_year2 = np.array(yields_port_year2)

##### YEAR3 (PORT 1) ######
mean_port_year3 = json.loads(sys.argv[17]) ##### FROM RUBY
std_port_year3 = json.loads(sys.argv[18]) ##### FROM RUBY
skew_port_year3 = json.loads(sys.argv[19]) ##### FROM RUBY
kurt_port_year3 = json.loads(sys.argv[20]) ##### FROM RUBY
correlation_port_year3 = json.loads(sys.argv[21]) ##### FROM RUBY
yields_port_year3 = json.loads(sys.argv[22]) ##### FROM RUBY
yields_port_year3 = np.array(yields_port_year3)

##### YEAR4 (PORT 1) ######
mean_port_year4 = json.loads(sys.argv[23]) ##### FROM RUBY
std_port_year4 = json.loads(sys.argv[24]) ##### FROM RUBY
skew_port_year4 = json.loads(sys.argv[25]) ##### FROM RUBY
kurt_port_year4 = json.loads(sys.argv[26]) ##### FROM RUBY
correlation_port_year4 = json.loads(sys.argv[27]) ##### FROM RUBY
yields_port_year4 = json.loads(sys.argv[28]) ##### FROM RUBY
yields_port_year4 = np.array(yields_port_year4)

##### YEAR5 (PORT 1) ######
mean_port_year5 = json.loads(sys.argv[29]) ##### FROM RUBY
std_port_year5 = json.loads(sys.argv[30]) ##### FROM RUBY
skew_port_year5 = json.loads(sys.argv[31]) ##### FROM RUBY
kurt_port_year5 = json.loads(sys.argv[32]) ##### FROM RUBY
correlation_port_year5 = json.loads(sys.argv[33]) ##### FROM RUBY
yields_port_year5 = json.loads(sys.argv[34]) ##### FROM RUBY
yields_port_year5 = np.array(yields_port_year5)

##### YEAR 6 (PORT 1) ######
mean_port_year6 = json.loads(sys.argv[35]) ##### FROM RUBY
std_port_year6 = json.loads(sys.argv[36]) ##### FROM RUBY
skew_port_year6 = json.loads(sys.argv[37]) ##### FROM RUBY
kurt_port_year6 = json.loads(sys.argv[38]) ##### FROM RUBY
correlation_port_year6 = json.loads(sys.argv[39]) ##### FROM RUBY
yields_port_year6 = json.loads(sys.argv[40]) ##### FROM RUBY
yields_port_year6 = np.array(yields_port_year6)

##### YEAR 7 (PORT 1) ######
mean_port_year7 = json.loads(sys.argv[41]) ##### FROM RUBY
std_port_year7 = json.loads(sys.argv[42]) ##### FROM RUBY
skew_port_year7 = json.loads(sys.argv[43]) ##### FROM RUBY
kurt_port_year7 = json.loads(sys.argv[44]) ##### FROM RUBY
correlation_port_year7 = json.loads(sys.argv[45]) ##### FROM RUBY
yields_port_year7 = json.loads(sys.argv[46]) ##### FROM RUBY
yields_port_year7 = np.array(yields_port_year7)

##### YEAR 8 (PORT 1) ######
mean_port_year8 = json.loads(sys.argv[47]) ##### FROM RUBY
std_port_year8 = json.loads(sys.argv[48]) ##### FROM RUBY
skew_port_year8 = json.loads(sys.argv[49]) ##### FROM RUBY
kurt_port_year8 = json.loads(sys.argv[50]) ##### FROM RUBY
correlation_port_year8 = json.loads(sys.argv[51]) ##### FROM RUBY
yields_port_year8 = json.loads(sys.argv[52]) ##### FROM RUBY
yields_port_year8 = np.array(yields_port_year8)

##### YEAR 9 (PORT 1) ######
mean_port_year9 = json.loads(sys.argv[53]) ##### FROM RUBY
std_port_year9 = json.loads(sys.argv[54]) ##### FROM RUBY
skew_port_year9 = json.loads(sys.argv[55]) ##### FROM RUBY
kurt_port_year9 = json.loads(sys.argv[56]) ##### FROM RUBY
correlation_port_year9 = json.loads(sys.argv[57]) ##### FROM RUBY
yields_port_year9 = json.loads(sys.argv[58]) ##### FROM RUBY
yields_port_year9 = np.array(yields_port_year9)

##### YEAR 10 (PORT 1) ######
mean_port_year10 = json.loads(sys.argv[59]) ##### FROM RUBY
std_port_year10 = json.loads(sys.argv[60]) ##### FROM RUBY
skew_port_year10 = json.loads(sys.argv[61]) ##### FROM RUBY
kurt_port_year10 = json.loads(sys.argv[62]) ##### FROM RUBY
correlation_port_year10 = json.loads(sys.argv[63]) ##### FROM RUBY
yields_port_year10 = json.loads(sys.argv[64]) ##### FROM RUBY
yields_port_year10 = np.array(yields_port_year10)

##### YEAR 11 (PORT 1) ######
mean_port_year11 = json.loads(sys.argv[65]) ##### FROM RUBY
std_port_year11 = json.loads(sys.argv[66]) ##### FROM RUBY
skew_port_year11 = json.loads(sys.argv[67]) ##### FROM RUBY
kurt_port_year11 = json.loads(sys.argv[68]) ##### FROM RUBY
correlation_port_year11 = json.loads(sys.argv[69]) ##### FROM RUBY
yields_port_year11 = json.loads(sys.argv[70]) ##### FROM RUBY
yields_port_year11 = np.array(yields_port_year11)

##### YEAR 12 (PORT 1) ######
mean_port_year12 = json.loads(sys.argv[71]) ##### FROM RUBY
std_port_year12 = json.loads(sys.argv[72]) ##### FROM RUBY
skew_port_year12 = json.loads(sys.argv[73]) ##### FROM RUBY
kurt_port_year12 = json.loads(sys.argv[74]) ##### FROM RUBY
correlation_port_year12 = json.loads(sys.argv[75]) ##### FROM RUBY
yields_port_year12 = json.loads(sys.argv[76]) ##### FROM RUBY
yields_port_year12 = np.array(yields_port_year12)

##### YEAR 13 (PORT 1) ######
mean_port_year13 = json.loads(sys.argv[77]) ##### FROM RUBY
std_port_year13 = json.loads(sys.argv[78]) ##### FROM RUBY
skew_port_year13 = json.loads(sys.argv[79]) ##### FROM RUBY
kurt_port_year13 = json.loads(sys.argv[80]) ##### FROM RUBY
correlation_port_year13 = json.loads(sys.argv[81]) ##### FROM RUBY
yields_port_year13 = json.loads(sys.argv[82]) ##### FROM RUBY
yields_port_year13 = np.array(yields_port_year13)

##### YEAR 14 (PORT 1) ######
mean_port_year14 = json.loads(sys.argv[83]) ##### FROM RUBY
std_port_year14 = json.loads(sys.argv[84]) ##### FROM RUBY
skew_port_year14 = json.loads(sys.argv[85]) ##### FROM RUBY
kurt_port_year14 = json.loads(sys.argv[86]) ##### FROM RUBY
correlation_port_year14 = json.loads(sys.argv[87]) ##### FROM RUBY
yields_port_year14 = json.loads(sys.argv[88]) ##### FROM RUBY
yields_port_year14 = np.array(yields_port_year14)

##### YEAR 15 (PORT 1) ######
mean_port_year15 = json.loads(sys.argv[89]) ##### FROM RUBY
std_port_year15 = json.loads(sys.argv[90]) ##### FROM RUBY
skew_port_year15 = json.loads(sys.argv[91]) ##### FROM RUBY
kurt_port_year15 = json.loads(sys.argv[92]) ##### FROM RUBY
correlation_port_year15 = json.loads(sys.argv[93]) ##### FROM RUBY
yields_port_year15 = json.loads(sys.argv[94]) ##### FROM RUBY
yields_port_year15 = np.array(yields_port_year15)

##### YEAR 16 (PORT 1) ######
mean_port_year16 = json.loads(sys.argv[95]) ##### FROM RUBY
std_port_year16 = json.loads(sys.argv[96]) ##### FROM RUBY
skew_port_year16 = json.loads(sys.argv[97]) ##### FROM RUBY
kurt_port_year16 = json.loads(sys.argv[98]) ##### FROM RUBY
correlation_port_year16 = json.loads(sys.argv[99]) ##### FROM RUBY
yields_port_year16 = json.loads(sys.argv[100]) ##### FROM RUBY
yields_port_year16 = np.array(yields_port_year16)

##### YEAR 17 (PORT 1) ######
mean_port_year17 = json.loads(sys.argv[101]) ##### FROM RUBY
std_port_year17 = json.loads(sys.argv[102]) ##### FROM RUBY
skew_port_year17 = json.loads(sys.argv[103]) ##### FROM RUBY
kurt_port_year17 = json.loads(sys.argv[104]) ##### FROM RUBY
correlation_port_year17 = json.loads(sys.argv[105]) ##### FROM RUBY
yields_port_year17 = json.loads(sys.argv[106]) ##### FROM RUBY
yields_port_year17 = np.array(yields_port_year17)

##### YEAR 8 (PORT 1) ######
mean_port_year18 = json.loads(sys.argv[107]) ##### FROM RUBY
std_port_year18 = json.loads(sys.argv[108]) ##### FROM RUBY
skew_port_year18 = json.loads(sys.argv[109]) ##### FROM RUBY
kurt_port_year18 = json.loads(sys.argv[110]) ##### FROM RUBY
correlation_port_year18 = json.loads(sys.argv[111]) ##### FROM RUBY
yields_port_year18 = json.loads(sys.argv[112]) ##### FROM RUBY
yields_port_year18 = np.array(yields_port_year18)

##### YEAR 9 (PORT 1) ######
mean_port_year19 = json.loads(sys.argv[113]) ##### FROM RUBY
std_port_year19 = json.loads(sys.argv[114]) ##### FROM RUBY
skew_port_year19 = json.loads(sys.argv[115]) ##### FROM RUBY
kurt_port_year19 = json.loads(sys.argv[116]) ##### FROM RUBY
correlation_port_year19 = json.loads(sys.argv[117]) ##### FROM RUBY
yields_port_year19 = json.loads(sys.argv[118]) ##### FROM RUBY
yields_port_year19 = np.array(yields_port_year19)

##### YEAR 20 (PORT 1) ######
mean_port_year20 = json.loads(sys.argv[119]) ##### FROM RUBY
std_port_year20 = json.loads(sys.argv[120]) ##### FROM RUBY
skew_port_year20 = json.loads(sys.argv[121]) ##### FROM RUBY
kurt_port_year20 = json.loads(sys.argv[122]) ##### FROM RUBY
correlation_port_year20 = json.loads(sys.argv[123]) ##### FROM RUBY
yields_port_year20 = json.loads(sys.argv[124]) ##### FROM RUBY
yields_port_year20 = np.array(yields_port_year20)

##### YEAR 21 (PORT 1) ######
mean_port_year21 = json.loads(sys.argv[125]) ##### FROM RUBY
std_port_year21 = json.loads(sys.argv[126]) ##### FROM RUBY
skew_port_year21 = json.loads(sys.argv[127]) ##### FROM RUBY
kurt_port_year21 = json.loads(sys.argv[128]) ##### FROM RUBY
correlation_port_year21 = json.loads(sys.argv[129]) ##### FROM RUBY
yields_port_year21 = json.loads(sys.argv[130]) ##### FROM RUBY
yields_port_year21 = np.array(yields_port_year21)

##### YEAR 22 (PORT 1) ######
mean_port_year22 = json.loads(sys.argv[131]) ##### FROM RUBY
std_port_year22 = json.loads(sys.argv[132]) ##### FROM RUBY
skew_port_year22 = json.loads(sys.argv[133]) ##### FROM RUBY
kurt_port_year22 = json.loads(sys.argv[134]) ##### FROM RUBY
correlation_port_year22 = json.loads(sys.argv[135]) ##### FROM RUBY
yields_port_year22 = json.loads(sys.argv[136]) ##### FROM RUBY
yields_port_year22 = np.array(yields_port_year22)

##### YEAR 23 (PORT 1) ######
mean_port_year23 = json.loads(sys.argv[137]) ##### FROM RUBY
std_port_year23 = json.loads(sys.argv[138]) ##### FROM RUBY
skew_port_year23 = json.loads(sys.argv[139]) ##### FROM RUBY
kurt_port_year23 = json.loads(sys.argv[140]) ##### FROM RUBY
correlation_port_year23 = json.loads(sys.argv[141]) ##### FROM RUBY
yields_port_year23 = json.loads(sys.argv[142]) ##### FROM RUBY
yields_port_year23 = np.array(yields_port_year23)

##### YEAR 24 (PORT 1) ######
mean_port_year24 = json.loads(sys.argv[143]) ##### FROM RUBY
std_port_year24 = json.loads(sys.argv[144]) ##### FROM RUBY
skew_port_year24 = json.loads(sys.argv[145]) ##### FROM RUBY
kurt_port_year24 = json.loads(sys.argv[146]) ##### FROM RUBY
correlation_port_year24 = json.loads(sys.argv[147]) ##### FROM RUBY
yields_port_year24 = json.loads(sys.argv[148]) ##### FROM RUBY
yields_port_year24 = np.array(yields_port_year24)

##### YEAR 25 (PORT 1) ######
mean_port_year25 = json.loads(sys.argv[149]) ##### FROM RUBY
std_port_year25 = json.loads(sys.argv[150]) ##### FROM RUBY
skew_port_year25 = json.loads(sys.argv[151]) ##### FROM RUBY
kurt_port_year25 = json.loads(sys.argv[152]) ##### FROM RUBY
correlation_port_year25 = json.loads(sys.argv[153]) ##### FROM RUBY
yields_port_year25 = json.loads(sys.argv[154]) ##### FROM RUBY
yields_port_year25 = np.array(yields_port_year25)

##### YEAR 26 (PORT 1) ######
mean_port_year26 = json.loads(sys.argv[155]) ##### FROM RUBY
std_port_year26 = json.loads(sys.argv[156]) ##### FROM RUBY
skew_port_year26 = json.loads(sys.argv[157]) ##### FROM RUBY
kurt_port_year26 = json.loads(sys.argv[158]) ##### FROM RUBY
correlation_port_year26 = json.loads(sys.argv[159]) ##### FROM RUBY
yields_port_year26 = json.loads(sys.argv[160]) ##### FROM RUBY
yields_port_year26 = np.array(yields_port_year26)

##### YEAR 27 (PORT 1) ######
mean_port_year27 = json.loads(sys.argv[161]) ##### FROM RUBY
std_port_year27 = json.loads(sys.argv[162]) ##### FROM RUBY
skew_port_year27 = json.loads(sys.argv[163]) ##### FROM RUBY
kurt_port_year27 = json.loads(sys.argv[164]) ##### FROM RUBY
correlation_port_year27 = json.loads(sys.argv[165]) ##### FROM RUBY
yields_port_year27 = json.loads(sys.argv[166]) ##### FROM RUBY
yields_port_year27 = np.array(yields_port_year27)

##### YEAR 28 (PORT 1) ######
mean_port_year28 = json.loads(sys.argv[167]) ##### FROM RUBY
std_port_year28 = json.loads(sys.argv[168]) ##### FROM RUBY
skew_port_year28 = json.loads(sys.argv[169]) ##### FROM RUBY
kurt_port_year28 = json.loads(sys.argv[170]) ##### FROM RUBY
correlation_port_year28 = json.loads(sys.argv[171]) ##### FROM RUBY
yields_port_year28 = json.loads(sys.argv[172]) ##### FROM RUBY
yields_port_year28 = np.array(yields_port_year28)

##### YEAR 29 (PORT 1) ######
mean_port_year29 = json.loads(sys.argv[173]) ##### FROM RUBY
std_port_year29 = json.loads(sys.argv[174]) ##### FROM RUBY
skew_port_year29 = json.loads(sys.argv[175]) ##### FROM RUBY
kurt_port_year29 = json.loads(sys.argv[176]) ##### FROM RUBY
correlation_port_year29 = json.loads(sys.argv[177]) ##### FROM RUBY
yields_port_year29 = json.loads(sys.argv[178]) ##### FROM RUBY
yields_port_year29 = np.array(yields_port_year29)

##### YEAR 30 (PORT 1) ######
mean_port_year30 = json.loads(sys.argv[179]) ##### FROM RUBY
std_port_year30 = json.loads(sys.argv[180]) ##### FROM RUBY
skew_port_year30 = json.loads(sys.argv[181]) ##### FROM RUBY
kurt_port_year30 = json.loads(sys.argv[182]) ##### FROM RUBY
correlation_port_year30 = json.loads(sys.argv[183]) ##### FROM RUBY
yields_port_year30 = json.loads(sys.argv[184]) ##### FROM RUBY
yields_port_year30 = np.array(yields_port_year30)


port_sample1 =  fleishman_opt.output(mean_port_year1, std_port_year1, skew_port_year1, kurt_port_year1, correlation_port_year1)
port_sample2 =  fleishman_opt.output(mean_port_year2, std_port_year2, skew_port_year2, kurt_port_year2, correlation_port_year2)
port_sample3 =  fleishman_opt.output(mean_port_year3, std_port_year3, skew_port_year3, kurt_port_year3, correlation_port_year3)
port_sample4 =  fleishman_opt.output(mean_port_year4, std_port_year4, skew_port_year4, kurt_port_year4, correlation_port_year4)
port_sample5 =  fleishman_opt.output(mean_port_year5, std_port_year5, skew_port_year5, kurt_port_year5, correlation_port_year5)
port_sample6 =  fleishman_opt.output(mean_port_year6, std_port_year6, skew_port_year6, kurt_port_year6, correlation_port_year6)
port_sample7 =  fleishman_opt.output(mean_port_year7, std_port_year7, skew_port_year7, kurt_port_year7, correlation_port_year7)
port_sample8 =  fleishman_opt.output(mean_port_year8, std_port_year8, skew_port_year8, kurt_port_year8, correlation_port_year8)
port_sample9 =  fleishman_opt.output(mean_port_year9, std_port_year9, skew_port_year9, kurt_port_year9, correlation_port_year9)
port_sample10 =  fleishman_opt.output(mean_port_year10, std_port_year10, skew_port_year10, kurt_port_year10, correlation_port_year10)
port_sample11 =  fleishman_opt.output(mean_port_year11, std_port_year11, skew_port_year11, kurt_port_year11, correlation_port_year11)
port_sample12 =  fleishman_opt.output(mean_port_year12, std_port_year12, skew_port_year12, kurt_port_year12, correlation_port_year12)
port_sample13 =  fleishman_opt.output(mean_port_year13, std_port_year13, skew_port_year13, kurt_port_year13, correlation_port_year13)
port_sample14 =  fleishman_opt.output(mean_port_year14, std_port_year14, skew_port_year14, kurt_port_year14, correlation_port_year14)
port_sample15 =  fleishman_opt.output(mean_port_year15, std_port_year15, skew_port_year15, kurt_port_year15, correlation_port_year15)
port_sample16 =  fleishman_opt.output(mean_port_year16, std_port_year16, skew_port_year16, kurt_port_year16, correlation_port_year16)
port_sample17 =  fleishman_opt.output(mean_port_year17, std_port_year17, skew_port_year17, kurt_port_year17, correlation_port_year17)
port_sample18 =  fleishman_opt.output(mean_port_year18, std_port_year18, skew_port_year18, kurt_port_year18, correlation_port_year18)
port_sample19 =  fleishman_opt.output(mean_port_year19, std_port_year19, skew_port_year19, kurt_port_year19, correlation_port_year19)
port_sample20 =  fleishman_opt.output(mean_port_year20, std_port_year20, skew_port_year20, kurt_port_year20, correlation_port_year20)
port_sample21 =  fleishman_opt.output(mean_port_year21, std_port_year21, skew_port_year21, kurt_port_year21, correlation_port_year21)
port_sample22 =  fleishman_opt.output(mean_port_year22, std_port_year22, skew_port_year22, kurt_port_year22, correlation_port_year22)
port_sample23 =  fleishman_opt.output(mean_port_year23, std_port_year23, skew_port_year23, kurt_port_year23, correlation_port_year23)
port_sample24 =  fleishman_opt.output(mean_port_year24, std_port_year24, skew_port_year24, kurt_port_year24, correlation_port_year24)
port_sample25 =  fleishman_opt.output(mean_port_year25, std_port_year25, skew_port_year25, kurt_port_year25, correlation_port_year25)
port_sample26 =  fleishman_opt.output(mean_port_year26, std_port_year26, skew_port_year26, kurt_port_year26, correlation_port_year26)
port_sample27 =  fleishman_opt.output(mean_port_year27, std_port_year27, skew_port_year27, kurt_port_year27, correlation_port_year27)
port_sample28 =  fleishman_opt.output(mean_port_year28, std_port_year28, skew_port_year28, kurt_port_year28, correlation_port_year28)
port_sample29 =  fleishman_opt.output(mean_port_year29, std_port_year29, skew_port_year29, kurt_port_year29, correlation_port_year29)
port_sample30 =  fleishman_opt.output(mean_port_year30, std_port_year30, skew_port_year30, kurt_port_year30, correlation_port_year30)
zeros = np.zeros(30000)

port_year_1 = weights_port.dot(port_sample1)/100*100
port_year_2 = weights_port.dot(port_sample2)/100*100
port_year_3 = weights_port.dot(port_sample3)/100*100
port_year_4 = weights_port.dot(port_sample4)/100*100
port_year_5 = weights_port.dot(port_sample5)/100*100
port_year_6 = weights_port.dot(port_sample6)/100*100
port_year_7 = weights_port.dot(port_sample7)/100*100
port_year_8 = weights_port.dot(port_sample8)/100*100
port_year_9 = weights_port.dot(port_sample9)/100*100
port_year_10 = weights_port.dot(port_sample10)/100*100
port_year_11 = weights_port.dot(port_sample11)/100*100
port_year_12 = weights_port.dot(port_sample12)/100*100
port_year_13 = weights_port.dot(port_sample13)/100*100
port_year_14 = weights_port.dot(port_sample14)/100*100
port_year_15 = weights_port.dot(port_sample15)/100*100
port_year_16 = weights_port.dot(port_sample16)/100*100
port_year_17 = weights_port.dot(port_sample17)/100*100
port_year_18 = weights_port.dot(port_sample18)/100*100
port_year_19 = weights_port.dot(port_sample19)/100*100
port_year_20 = weights_port.dot(port_sample20)/100*100
port_year_21 = weights_port.dot(port_sample21)/100*100
port_year_22 = weights_port.dot(port_sample22)/100*100
port_year_23 = weights_port.dot(port_sample23)/100*100
port_year_24 = weights_port.dot(port_sample24)/100*100
port_year_25 = weights_port.dot(port_sample25)/100*100
port_year_26 = weights_port.dot(port_sample26)/100*100
port_year_27 = weights_port.dot(port_sample27)/100*100
port_year_28 = weights_port.dot(port_sample28)/100*100
port_year_29 = weights_port.dot(port_sample29)/100*100
port_year_30 = weights_port.dot(port_sample30)/100*100

port_dollar1 = (starting_value + income[0] + expense[0])*(1 + port_year_1)
port_dollar2 = (np.maximum(zeros, (port_dollar1 + income[1] + expense[1] )))*(1 + port_year_2)
port_dollar3 = (np.maximum(zeros, (port_dollar2 + income[2] + expense[2])))*(1 + port_year_3)
port_dollar4 = (np.maximum(zeros, (port_dollar3 + income[3] + expense[3])))*(1 + port_year_4)
port_dollar5 = (np.maximum(zeros, (port_dollar4 + income[4] + expense[4])))*(1 + port_year_5)
port_dollar6 = (np.maximum(zeros, (port_dollar5 + income[5] + expense[5])))*(1 + port_year_6)
port_dollar7 = (np.maximum(zeros, (port_dollar6 + income[6] + expense[6])))*(1 + port_year_7)
port_dollar8 = (np.maximum(zeros, (port_dollar7 + income[7] + expense[7])))*(1 + port_year_8)
port_dollar9 = (np.maximum(zeros, (port_dollar8 + income[8] + expense[8])))*(1 + port_year_9)
port_dollar10 = (np.maximum(zeros, (port_dollar9 + income[9] + expense[9])))*(1 + port_year_10)
port_dollar11 = (np.maximum(zeros, (port_dollar10 + income[10] + expense[10])))*(1 + port_year_11)
port_dollar12 = (np.maximum(zeros, (port_dollar11 + income[11] + expense[11])))*(1 + port_year_12)
port_dollar13 = (np.maximum(zeros, (port_dollar12 + income[12] + expense[12])))*(1 + port_year_13)
port_dollar14 = (np.maximum(zeros, (port_dollar13 + income[13] + expense[13])))*(1 + port_year_14)
port_dollar15 = (np.maximum(zeros, (port_dollar14 + income[14] + expense[14])))*(1 + port_year_15)
port_dollar16 = (np.maximum(zeros, (port_dollar15 + income[15] + expense[15])))*(1 + port_year_16)
port_dollar17 = (np.maximum(zeros, (port_dollar16 + income[16] + expense[16])))*(1 + port_year_17)
port_dollar18 = (np.maximum(zeros, (port_dollar17 + income[17] + expense[17])))*(1 + port_year_18)
port_dollar19 = (np.maximum(zeros, (port_dollar18 + income[18] + expense[18])))*(1 + port_year_19)
port_dollar20 = (np.maximum(zeros, (port_dollar19 + income[19] + expense[19])))*(1 + port_year_20)
port_dollar21 = (np.maximum(zeros, (port_dollar20 + income[20] + expense[20])))*(1 + port_year_21)
port_dollar22 = (np.maximum(zeros, (port_dollar21 + income[21] + expense[21])))*(1 + port_year_22)
port_dollar23 = (np.maximum(zeros, (port_dollar22 + income[22] + expense[22])))*(1 + port_year_23)
port_dollar24 = (np.maximum(zeros, (port_dollar23 + income[23] + expense[23])))*(1 + port_year_24)
port_dollar25 = (np.maximum(zeros, (port_dollar24 + income[24] + expense[24])))*(1 + port_year_25)
port_dollar26 = (np.maximum(zeros, (port_dollar25 + income[25] + expense[25])))*(1 + port_year_26)
port_dollar27 = (np.maximum(zeros, (port_dollar26 + income[26] + expense[26])))*(1 + port_year_27)
port_dollar28 = (np.maximum(zeros, (port_dollar27 + income[27] + expense[27])))*(1 + port_year_28)
port_dollar29 = (np.maximum(zeros, (port_dollar28 + income[28] + expense[28])))*(1 + port_year_29)
port_dollar30 = (np.maximum(zeros, (port_dollar29 + income[29] + expense[29])))*(1 + port_year_30)


d = np.stack((port_dollar1, port_dollar2, port_dollar3, port_dollar4, port_dollar5, port_dollar6, port_dollar7, port_dollar8, port_dollar9, port_dollar10,
              port_dollar11, port_dollar12, port_dollar13, port_dollar14, port_dollar15, port_dollar16, port_dollar17, port_dollar18, port_dollar19, port_dollar20,
              port_dollar21, port_dollar22, port_dollar23, port_dollar24, port_dollar25, port_dollar26, port_dollar27, port_dollar28, port_dollar29, port_dollar30), axis = 0)
sim_paths = np.transpose(d)



### port Year 1 Dollars
numpyport_port_dollar1 = {"port_dollar1": port_dollar1}
encodport_port_dollar1 = json.dumps(numpyport_port_dollar1, cls=NumpyArrayEncoder)  # use dump() to write array into file

### port Year 30 Dollars
numpyport_port_dollar30 = {"port_dollar30": port_dollar30}
encodport_port_dollar30 = json.dumps(numpyport_port_dollar30, cls=NumpyArrayEncoder)  # use dump() to write array into file

### SIM Paths
numpyport_sim_paths = {"sim_paths": sim_paths}
encodport_sim_paths = json.dumps(numpyport_sim_paths, cls=NumpyArrayEncoder)  # use dump() to write array into file


jsonMerged = {**json.loads(encodport_port_dollar1), **json.loads(encodport_port_dollar30), **json.loads(encodport_sim_paths)}
asString = json.dumps(jsonMerged)
print(asString)





