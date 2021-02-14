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
weights_port1 = json.loads(sys.argv[4]) ##### FROM RUBY
income = np.array(income)
expense = np.array(expense)

###########################
##### PORTFOLIO 1 #########
###########################
weights_port1 = np.array(weights_port1)

##### YEAR1 (PORT 1) ######
mean_port1_year1 = json.loads(sys.argv[5]) ##### FROM RUBY
std_port1_year1 = json.loads(sys.argv[6]) ##### FROM RUBY
skew_port1_year1 = json.loads(sys.argv[7]) ##### FROM RUBY
kurt_port1_year1 = json.loads(sys.argv[8]) ##### FROM RUBY
correlation_port1_year1 = json.loads(sys.argv[9]) ##### FROM RUBY
yields_port1_year1 = json.loads(sys.argv[10]) ##### FROM RUBY
yields_port1_year1 = np.array(yields_port1_year1)

##### YEAR2 (PORT 1) ######
mean_port1_year2 = json.loads(sys.argv[11]) ##### FROM RUBY
std_port1_year2 = json.loads(sys.argv[12]) ##### FROM RUBY
skew_port1_year2 = json.loads(sys.argv[13]) ##### FROM RUBY
kurt_port1_year2 = json.loads(sys.argv[14]) ##### FROM RUBY
correlation_port1_year2 = json.loads(sys.argv[15]) ##### FROM RUBY
yields_port1_year2 = json.loads(sys.argv[16]) ##### FROM RUBY
yields_port1_year2 = np.array(yields_port1_year2)

##### YEAR3 (PORT 1) ######
mean_port1_year3 = json.loads(sys.argv[17]) ##### FROM RUBY
std_port1_year3 = json.loads(sys.argv[18]) ##### FROM RUBY
skew_port1_year3 = json.loads(sys.argv[19]) ##### FROM RUBY
kurt_port1_year3 = json.loads(sys.argv[20]) ##### FROM RUBY
correlation_port1_year3 = json.loads(sys.argv[21]) ##### FROM RUBY
yields_port1_year3 = json.loads(sys.argv[22]) ##### FROM RUBY
yields_port1_year3 = np.array(yields_port1_year3)






port1_sample1 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample2 =  fleishman_opt.output(mean_port1_year2, std_port1_year2, skew_port1_year2, kurt_port1_year2, correlation_port1_year2)
port1_sample3 =  fleishman_opt.output(mean_port1_year3, std_port1_year3, skew_port1_year3, kurt_port1_year3, correlation_port1_year3)
port1_sample4 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample5 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample6 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample7 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample8 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample9 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)
port1_sample10 =  fleishman_opt.output(mean_port1_year1, std_port1_year1, skew_port1_year1, kurt_port1_year1, correlation_port1_year1)


zeros = np.zeros(30000)

port1_year_1 = weights_port1.dot(port1_sample1)/100*100
port1_year_2 = weights_port1.dot(port1_sample2)/100*100
port1_year_3 = weights_port1.dot(port1_sample3)/100*100
port1_year_4 = weights_port1.dot(port1_sample4)/100*100
port1_year_5 = weights_port1.dot(port1_sample5)/100*100
port1_year_6 = weights_port1.dot(port1_sample6)/100*100
port1_year_7 = weights_port1.dot(port1_sample7)/100*100
port1_year_8 = weights_port1.dot(port1_sample8)/100*100
port1_year_9 = weights_port1.dot(port1_sample9)/100*100
port1_year_10 = weights_port1.dot(port1_sample10)/100*100

port1_dollar1 = (starting_value + income[0] + expense[0])*(1 + port1_year_1)
port1_dollar2 = (np.maximum(zeros, (port1_dollar1 + income[1] + expense[1] )))*(1 + port1_year_2)
port1_dollar3 = (np.maximum(zeros, (port1_dollar2 + income[2] + expense[2])))*(1 + port1_year_3)
port1_dollar4 = (np.maximum(zeros, (port1_dollar3 + income[3] + expense[3])))*(1 + port1_year_4)
port1_dollar5 = (np.maximum(zeros, (port1_dollar4 + income[4] + expense[4])))*(1 + port1_year_5)
port1_dollar6 = (np.maximum(zeros, (port1_dollar5 + income[5] + expense[5])))*(1 + port1_year_6)
port1_dollar7 = (np.maximum(zeros, (port1_dollar6 + income[6] + expense[6])))*(1 + port1_year_7)
port1_dollar8 = (np.maximum(zeros, (port1_dollar7 + income[7] + expense[7])))*(1 + port1_year_8)
port1_dollar9 = (np.maximum(zeros, (port1_dollar8 + income[8] + expense[8])))*(1 + port1_year_9)
port1_dollar10 = (np.maximum(zeros, (port1_dollar9 + income[9] + expense[9])))*(1 + port1_year_10)



### Port vs Benchmark Success Rate
numpyport_port1_dollar1 = {"port1_dollar1": port1_dollar1}
encodport_port1_dollar1 = json.dumps(numpyport_port1_dollar1, cls=NumpyArrayEncoder)  # use dump() to write array into file

jsonMerged = {**json.loads(encodport_port1_dollar1)}
asString = json.dumps(jsonMerged)
print(asString)





