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


mean = json.loads(sys.argv[1]) ##### FROM RUBY
std = json.loads(sys.argv[2]) ##### FROM RUBY
skew = json.loads(sys.argv[3]) ##### FROM RUBY
kurt = json.loads(sys.argv[4]) ##### FROM RUBY
correlation = json.loads(sys.argv[5]) ##### FROM RUBY
weights = json.loads(sys.argv[6]) ##### FROM RUBY
yields = json.loads(sys.argv[7]) ##### FROM RUBY
weights = np.array(weights)
yields = np.array(yields)



sample1 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample2 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample3 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample4 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample5 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample6 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample7 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample8 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample9 =  fleishman_opt.output(mean, std, skew, kurt, correlation)
sample10 =  fleishman_opt.output(mean, std, skew, kurt, correlation)

year_1 = weights.dot(sample1)/100*100
year_2 = weights.dot(sample2)/100*100
year_3 = weights.dot(sample3)/100*100
year_4 = weights.dot(sample4)/100*100
year_5 = weights.dot(sample5)/100*100
year_6 = weights.dot(sample6)/100*100
year_7 = weights.dot(sample7)/100*100
year_8 = weights.dot(sample8)/100*100
year_9 = weights.dot(sample9)/100*100
year_10 = weights.dot(sample10)/100*100

forecast1 = year_1
forecast2 = ((1 + year_1)*(1 + year_2))**(1/2) - 1 
forecast3 = ((1 + year_1)*(1 + year_2)*(1 + year_3))**(1/3) - 1 
forecast4 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4))**(1/4) - 1 
forecast5 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5))**(1/5) - 1 
forecast6 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6))**(1/6) - 1 
forecast7 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7))**(1/7) - 1 
forecast8 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8))**(1/8) - 1 
forecast9 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8)*(1 + year_9))**(1/9) - 1 
forecast10 = ((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8)*(1 + year_9)*(1 + year_10))**(1/10) - 1 

dollar1 = 1000000*(1 + year_1)
dollar2 = 1000000*((1 + year_1)*(1 + year_2))
dollar3 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)) 
dollar4 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)) 
dollar5 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)) 
dollar6 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)) 
dollar7 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)) 
dollar8 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8)) 
dollar9 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8)*(1 + year_9)) 
dollar10 = 1000000*((1 + year_1)*(1 + year_2)*(1 + year_3)*(1 + year_4)*(1 + year_5)*(1 + year_6)*(1 + year_7)*(1 + year_8)*(1 + year_9)*(1 + year_10)) 

dollar1_50th = np.percentile(dollar1, 50)
dollar2_50th = np.percentile(dollar2, 50)
dollar3_50th = np.percentile(dollar3, 50)
dollar4_50th = np.percentile(dollar4, 50)
dollar5_50th = np.percentile(dollar5, 50)
dollar6_50th = np.percentile(dollar6, 50)
dollar7_50th = np.percentile(dollar7, 50)
dollar8_50th = np.percentile(dollar8, 50)
dollar9_50th = np.percentile(dollar9, 50)
dollar10_50th = np.percentile(dollar10, 50)


dollar1_90th = np.percentile(dollar1, 90)
dollar2_90th = np.percentile(dollar2, 90)
dollar3_90th = np.percentile(dollar3, 90)
dollar4_90th = np.percentile(dollar4, 90)
dollar5_90th = np.percentile(dollar5, 90)
dollar6_90th = np.percentile(dollar6, 90)
dollar7_90th = np.percentile(dollar7, 90)
dollar8_90th = np.percentile(dollar8, 90)
dollar9_90th = np.percentile(dollar9, 90)
dollar10_90th = np.percentile(dollar10, 90)

dollar1_10th = np.percentile(dollar1, 10)
dollar2_10th = np.percentile(dollar2, 10)
dollar3_10th = np.percentile(dollar3, 10)
dollar4_10th = np.percentile(dollar4, 10)
dollar5_10th = np.percentile(dollar5, 10)
dollar6_10th = np.percentile(dollar6, 10)
dollar7_10th = np.percentile(dollar7, 10)
dollar8_10th = np.percentile(dollar8, 10)
dollar9_10th = np.percentile(dollar9, 10)
dollar10_10th = np.percentile(dollar10, 10)

dollar_50th = [dollar1_50th, dollar2_50th, dollar3_50th, dollar4_50th, dollar5_50th, dollar6_50th, dollar7_50th, dollar8_50th, dollar9_50th, dollar10_50th]
dollar_90th = [dollar1_90th, dollar2_90th, dollar3_90th, dollar4_90th, dollar5_90th, dollar6_90th, dollar7_90th, dollar8_90th, dollar9_90th, dollar10_90th]
dollar_10th = [dollar1_10th, dollar2_10th, dollar3_10th, dollar4_10th, dollar5_10th, dollar6_10th, dollar7_10th, dollar8_10th, dollar9_10th, dollar10_10th]




Success_Rate_year_1 = sum(map(lambda y : y > 0.0, forecast1))/len(forecast1)
Success_Rate_year_2 = sum(map(lambda y : y > 0.0, forecast2))/len(forecast2)
Success_Rate_year_3 = sum(map(lambda y : y > 0.0, forecast3))/len(forecast3)
Success_Rate_year_4 = sum(map(lambda y : y > 0.0, forecast4))/len(forecast4)
Success_Rate_year_5 = sum(map(lambda y : y > 0.0, forecast5))/len(forecast5)
Success_Rate_year_6 = sum(map(lambda y : y > 0.0, forecast6))/len(forecast6)
Success_Rate_year_7 = sum(map(lambda y : y > 0.0, forecast7))/len(forecast7)
Success_Rate_year_8 = sum(map(lambda y : y > 0.0, forecast8))/len(forecast8)
Success_Rate_year_9 = sum(map(lambda y : y > 0.0, forecast9))/len(forecast9)
Success_Rate_year_10 = sum(map(lambda y : y > 0.0, forecast10))/len(forecast10)

k1 = int(0.05*len(forecast1))
ind1 = np.argpartition(forecast1,k1)[:k1]
CVAR_year1 = sum(forecast1[ind1])/len(forecast1[ind1])

k2 = int(0.05*len(forecast2))
ind2 = np.argpartition(forecast2,k2)[:k2]
CVAR_year2 = sum(forecast2[ind2])/len(forecast2[ind2])

k3 = int(0.05*len(forecast3))
ind3 = np.argpartition(forecast3,k3)[:k3]
CVAR_year3 = sum(forecast3[ind3])/len(forecast3[ind3])

k4 = int(0.05*len(forecast4))
ind4 = np.argpartition(forecast4,k4)[:k4]
CVAR_year4 = sum(forecast4[ind4])/len(forecast4[ind4])

k5 = int(0.05*len(forecast5))
ind5 = np.argpartition(forecast5,k5)[:k5]
CVAR_year5 = sum(forecast5[ind5])/len(forecast5[ind5])

k6 = int(0.05*len(forecast6))
ind6 = np.argpartition(forecast6,k6)[:k6]
CVAR_year6 = sum(forecast6[ind6])/len(forecast6[ind6])

k7 = int(0.05*len(forecast7))
ind7 = np.argpartition(forecast7,k7)[:k7]
CVAR_year7 = sum(forecast7[ind7])/len(forecast7[ind7])

k8 = int(0.05*len(forecast8))
ind8 = np.argpartition(forecast8,k8)[:k8]
CVAR_year8 = sum(forecast8[ind8])/len(forecast8[ind8])

k9 = int(0.05*len(forecast9))
ind9 = np.argpartition(forecast9,k9)[:k9]
CVAR_year9 = sum(forecast9[ind9])/len(forecast9[ind9])

k10 = int(0.05*len(forecast10))
ind10 = np.argpartition(forecast10,k10)[:k10]
CVAR_year10 = sum(forecast10[ind10])/len(forecast10[ind10])
  

numpySuccess_year1 = {"year1_probability": Success_Rate_year_1}
encodedSuccessRate_year1 = json.dumps(numpySuccess_year1, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year2 = {"year2_probability": Success_Rate_year_2}
encodedSuccessRate_year2 = json.dumps(numpySuccess_year2, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year3 = {"year3_probability": Success_Rate_year_3}
encodedSuccessRate_year3 = json.dumps(numpySuccess_year3, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year4 = {"year4_probability": Success_Rate_year_4}
encodedSuccessRate_year4 = json.dumps(numpySuccess_year4, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year5 = {"year5_probability": Success_Rate_year_5}
encodedSuccessRate_year5 = json.dumps(numpySuccess_year5, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year6 = {"year6_probability": Success_Rate_year_6}
encodedSuccessRate_year6 = json.dumps(numpySuccess_year6, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year7 = {"year7_probability": Success_Rate_year_7}
encodedSuccessRate_year7 = json.dumps(numpySuccess_year7, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year8 = {"year8_probability": Success_Rate_year_8}
encodedSuccessRate_year8 = json.dumps(numpySuccess_year8, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year9 = {"year9_probability": Success_Rate_year_9}
encodedSuccessRate_year9 = json.dumps(numpySuccess_year9, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySuccess_year10 = {"year10_probability": Success_Rate_year_10}
encodedSuccessRate_year10 = json.dumps(numpySuccess_year10, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year1 = {"CVAR_year1": CVAR_year1}
encoded_CVAR_year1 = json.dumps(numpy_CVAR_year1, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year2 = {"CVAR_year2": CVAR_year2}
encoded_CVAR_year2 = json.dumps(numpy_CVAR_year2, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year3 = {"CVAR_year3": CVAR_year3}
encoded_CVAR_year3 = json.dumps(numpy_CVAR_year3, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year4 = {"CVAR_year4": CVAR_year4}
encoded_CVAR_year4 = json.dumps(numpy_CVAR_year4, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year5 = {"CVAR_year5": CVAR_year5}
encoded_CVAR_year5 = json.dumps(numpy_CVAR_year5, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year6 = {"CVAR_year6": CVAR_year6}
encoded_CVAR_year6 = json.dumps(numpy_CVAR_year6, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year7 = {"CVAR_year7": CVAR_year7}
encoded_CVAR_year7 = json.dumps(numpy_CVAR_year7, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year8 = {"CVAR_year8": CVAR_year8}
encoded_CVAR_year8 = json.dumps(numpy_CVAR_year8, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year9 = {"CVAR_year9": CVAR_year9}
encoded_CVAR_year9 = json.dumps(numpy_CVAR_year9, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_CVAR_year10 = {"CVAR_year10": CVAR_year10}
encoded_CVAR_year10 = json.dumps(numpy_CVAR_year10, cls=NumpyArrayEncoder)  # use dump() to write array into file


numpy_returns_year1 = {"returns_year1": forecast1}
encoded_returns_year1 = json.dumps(numpy_returns_year1, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year2 = {"returns_year2": forecast2}
encoded_returns_year2 = json.dumps(numpy_returns_year2, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year3 = {"returns_year3": forecast3}
encoded_returns_year3 = json.dumps(numpy_returns_year3, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year4 = {"returns_year4": forecast4}
encoded_returns_year4 = json.dumps(numpy_returns_year4, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year5 = {"returns_year5": forecast5}
encoded_returns_year5 = json.dumps(numpy_returns_year5, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year6 = {"returns_year6": forecast6}
encoded_returns_year6 = json.dumps(numpy_returns_year6, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year7 = {"returns_year7": forecast7}
encoded_returns_year7 = json.dumps(numpy_returns_year7, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year8 = {"returns_year8": forecast8}
encoded_returns_year8 = json.dumps(numpy_returns_year8, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year9 = {"returns_year9": forecast9}
encoded_returns_year9 = json.dumps(numpy_returns_year9, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_returns_year10 = {"returns_year10": forecast10}
encoded_returns_year10 = json.dumps(numpy_returns_year10, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year1 = {"dollar_year1": dollar1}
encoded_dollar_year1 = json.dumps(numpy_dollar_year1, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year2 = {"dollar_year2": dollar2}
encoded_dollar_year2 = json.dumps(numpy_dollar_year2, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year3 = {"dollar_year3": dollar3}
encoded_dollar_year3 = json.dumps(numpy_dollar_year3, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year4 = {"dollar_year4": dollar4}
encoded_dollar_year4 = json.dumps(numpy_dollar_year4, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year5 = {"dollar_year5": dollar5}
encoded_dollar_year5 = json.dumps(numpy_dollar_year5, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year6 = {"dollar_year6": dollar6}
encoded_dollar_year6 = json.dumps(numpy_dollar_year6, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year7 = {"dollar_year7": dollar7}
encoded_dollar_year7 = json.dumps(numpy_dollar_year7, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year8 = {"dollar_year8": dollar8}
encoded_dollar_year8 = json.dumps(numpy_dollar_year8, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year9 = {"dollar_year9": dollar9}
encoded_dollar_year9 = json.dumps(numpy_dollar_year9, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpy_dollar_year10 = {"dollar_year10": dollar10}
encoded_dollar_year10 = json.dumps(numpy_dollar_year10, cls=NumpyArrayEncoder)  # use dump() to write array into file

#### 90th Percentil
numpy_dollar_50th = {"dollar_50th": dollar_50th}
encoded_dollar_50th = json.dumps(numpy_dollar_50th, cls=NumpyArrayEncoder)  # use dump() to write array into file

#### 90th Percentil
numpy_dollar_90th = {"dollar_90th": dollar_90th}
encoded_dollar_90th = json.dumps(numpy_dollar_90th, cls=NumpyArrayEncoder)  # use dump() to write array into file

#### 10th Percentil
numpy_dollar_10th = {"dollar_10th": dollar_10th}
encoded_dollar_10th = json.dumps(numpy_dollar_10th, cls=NumpyArrayEncoder)  # use dump() to write array into file

port_yield = yields.dot(weights)
#### Yield
numpy_port_yield = {"port_yield": port_yield}
encoded_port_yield = json.dumps(numpy_port_yield, cls=NumpyArrayEncoder)  # use dump() to write array into file


# **json.loads(encoded_returns_year2), **json.loads(encoded_returns_year3), **json.loads(encoded_returns_year4), **json.loads(encoded_returns_year5), **json.loads(encoded_returns_year6), **json.loads(encoded_returns_year7), **json.loads(encoded_returns_year8), **json.loads(encoded_returns_year9), **json.loads(encoded_returns_year10)
jsonMerged = {**json.loads(encodedSuccessRate_year1), **json.loads(encodedSuccessRate_year2), **json.loads(encodedSuccessRate_year3), **json.loads(encodedSuccessRate_year4), **json.loads(encodedSuccessRate_year5), **json.loads(encodedSuccessRate_year6), **json.loads(encodedSuccessRate_year7), **json.loads(encodedSuccessRate_year8), **json.loads(encodedSuccessRate_year9), **json.loads(encodedSuccessRate_year10), 
              **json.loads(encoded_CVAR_year1), **json.loads(encoded_CVAR_year2), **json.loads(encoded_CVAR_year3), **json.loads(encoded_CVAR_year4), **json.loads(encoded_CVAR_year5), **json.loads(encoded_CVAR_year6), **json.loads(encoded_CVAR_year7), **json.loads(encoded_CVAR_year8), **json.loads(encoded_CVAR_year9), **json.loads(encoded_CVAR_year10), 
              **json.loads(encoded_returns_year1), 
              **json.loads(encoded_dollar_50th),
              **json.loads(encoded_dollar_90th),
              **json.loads(encoded_dollar_10th),
              **json.loads(encoded_port_yield) }

asString = json.dumps(jsonMerged)
print(asString)
