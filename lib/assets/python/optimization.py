import sys 
import json
from json import JSONEncoder
import numpy as np
import pandas as pd
from scipy.optimize import minimize, LinearConstraint, NonlinearConstraint, differential_evolution, fmin_cobyla
from scipy.optimize import _cobyla
from scipy import optimize
import matplotlib.pyplot as plt
import fleishman_opt
from time import time


# start = time()
# # your script here
mean = json.loads(sys.argv[1]) ##### FROM RUBY
std = json.loads(sys.argv[2]) ##### FROM RUBY
skew = json.loads(sys.argv[3]) ##### FROM RUBY
kurt = json.loads(sys.argv[4]) ##### FROM RUBY
correlation = json.loads(sys.argv[5]) ##### FROM RUBY
bnds = tuple(json.loads(sys.argv[6])) ##### FROM RUBY
weight_left = json.loads(sys.argv[7]) ##### FROM RUBY
weight_right = json.loads(sys.argv[8]) ##### FROM RUBY
weight_right2 = json.loads(sys.argv[9]) ##### FROM RUBY
asset_id = json.loads(sys.argv[10]) ##### FROM RUBY
query_yield = json.loads(sys.argv[11]) ##### FROM RUBY
weight_left2 = json.loads(sys.argv[12]) ##### FROM RUBY

Year1 = fleishman_opt.output(mean, std, skew, kurt, correlation)

""" Define Asset Class Constraints """
# b1 = tuple(json.loads(sys.argv[6]))
# b2 = tuple(json.loads(sys.argv[7]))
# b3 = tuple(json.loads(sys.argv[8]))
# b4 = tuple(json.loads(sys.argv[9]))
# b5 = tuple(json.loads(sys.argv[10]))
# b6 = tuple(json.loads(sys.argv[11]))
# b7 = tuple(json.loads(sys.argv[12]))
# b8 = tuple(json.loads(sys.argv[13]))
# b9 = tuple(json.loads(sys.argv[14]))
# b10 = tuple(json.loads(sys.argv[15]))
# bnds = (b1,b2,b3,b4,b5,b6,b7,b8,b9,b10)
# print(bnds)


" MAX FUNCTION TO MAXIMIZE AVG Return "
def objective_max_function(weights):
    arg1 = weights.dot(Year1)
    period = arg1    
    return -sum(period)/len(period)

" MIN FUNCTION TO MINIMIZE CVAR "
def objective_min_function(weights):
    arg1 = weights.dot(Year1)
    period = arg1
    k = int(0.05*len(period))
    ind = np.argpartition(period,k)[:k]
    CVAR = -sum(period[ind])/len(period[ind])     
    return CVAR

" SERIES RETURNS FUNCTION "
def returns_function(weights):
    arg1 = weights.dot(Year1)
    period = arg1   
    return period


""" Define Optimization Constraints """

" SUM TO 100% CONSTRAINT"
def constraint1(weights):
    total = -1.0
    sumweights = sum(weights)
    total = total + sumweights
    return total

" PROBABILITY CONSTRAINT"
# def constraint3(weights):
#     total = -0.90
#     arg1 = weights.dot(Year1)
#     arg2 = weights.dot(Year2)
#     arg3 = weights.dot(Year3)
#     arg4 = weights.dot(Year4)
#     arg5 = weights.dot(Year5)
#     arg6 = weights.dot(Year6)
#     arg7 = weights.dot(Year7)
      # arg1 = np.where(arg1 <= -0.99, -0.98, arg1)
      # arg2 = np.where(arg1 <= -0.99, -0.98, arg2)
      # arg3 = np.where(arg1 <= -0.99, -0.98, arg3)
      # arg4 = np.where(arg1 <= -0.99, -0.98, arg4)
      # arg5 = np.where(arg1 <= -0.99, -0.98, arg5)
      # arg6 = np.where(arg1 <= -0.99, -0.98, arg6)
      # arg7 = np.where(arg1 <= -0.99, -0.98, arg7)     
#     rr = ((1 + arg1)*(1 + arg2)*(1+arg3)*(1+arg4)*(1+arg5)*(1+arg6)*(1+arg7))**(1/7) - 1    
#     xx = sum(map(lambda x : x > 0.0, rr))/len(rr)
#     return total + xx
    

" CVAR CONSTRAINT"
def constraint4(weights):
        target_cvar = 0.02
        arg1 = weights.dot(Year1)
        rr = arg1    
        k = int(0.05*len(rr))
        ind = np.argpartition(rr,k)[:k]
        CVAR = sum(rr[ind])/len(rr[ind])
        return target_cvar - CVAR




""" NEW Relative CONSTRAINTS CODE"""
asset_id = np.array(asset_id)
left_rows = len(weight_left)
left_cols = list(map(len, weight_left))

right_rows = len(weight_right)
right_cols = list(map(len, weight_right))

left = np.empty((1,left_rows), dtype = object)
right = np.empty((1,right_rows), dtype = object)

for i in range(left_rows):
    left[0,i] = np.zeros(left_cols[i])

for i in range(right_rows):    
    right[0,i] = np.zeros(right_cols[i])

for i in range(len(left_cols)):
        for j in range(left_cols[i]):
            left[0][i][j] = np.where(asset_id == weight_left[i][j])[0]
        left[0][i] = left[0][i].astype(int)

for i in range(len(right_cols)):
        for j in range(right_cols[i]):
            right[0][i][j] = np.where(asset_id == weight_right[i][j])[0]
            right[0][i][j] = right[0][i][j].astype(int)
        right[0][i] = right[0][i].astype(int)

# for i in range(len(cols)):
#         for j in range(cols[i]):
#             left[0][i][j] = np.where(asset_id == weight_left[i][j])[0]
#             right[0][i][j] = np.where(asset_id == weight_right[i][j])[0]
#             right[0][i][j] = right[0][i][j].astype(int)
#         left[0][i] = left[0][i].astype(int)
#         right[0][i] = right[0][i].astype(int)

def constraint6(weights):
    ll =   list(map(lambda x: weights[x], left[0] ))
    rr =   list(map(lambda x: weights[x], right[0]))
    return  np.array(list(map(sum, ll))) - np.array(list(map(sum, rr)))

def constraint7(weights):
    ll =   list(map(lambda x: weights[x], left[0] ))
    return np.array(list(map(sum, ll))) - weight_right2

def constraint8(weights):
    ll =   list(map(lambda x: weights[x], left[0] ))
    return weight_left2 - np.array(list(map(sum, ll)))


""" intial guess """
n = len(mean)
weights0 = np.zeros(n)
for i in range(n):
    weights0[i] = 1/n


""" define constraints"""
con1 = {'type': 'eq', 'fun': constraint1}
# con3 = {'type': 'ineq', 'fun': constraint3}
con6 = {'type': 'ineq', 'fun': constraint6}
con7 = {'type': 'ineq', 'fun': constraint7}
con8 = {'type': 'ineq', 'fun': constraint8}
# cons = ([con1,con3])
cons = ([con1, con6, con7, con8])



"MIN AND MAX RETURNS"
solution_max = minimize(objective_max_function, x0 = weights0, bounds =  bnds,   constraints =  cons)
solution_min = minimize(objective_min_function, x0 = weights0, bounds =  bnds,   constraints =  cons)

MAX_Return_Series  = returns_function(solution_max.x)
MIN_Return_Series  = returns_function(solution_min.x)

k = int(0.05*len(MAX_Return_Series))
ind_max = np.argpartition(MAX_Return_Series,k)[:k]
ind_min = np.argpartition(MIN_Return_Series,k)[:k]

CVAR_MAX = sum(MAX_Return_Series[ind_max])/len(MAX_Return_Series[ind_max])
CVAR_MIN = sum(MIN_Return_Series[ind_min])/len(MIN_Return_Series[ind_min])

""" Define Frontier """
CVAR_frontier = np.zeros(7)
CVAR_step = (CVAR_MAX - CVAR_MIN)/(len(CVAR_frontier)-1)

CVAR_frontier[0] = CVAR_MIN
for x in range(6):
    CVAR_frontier[x+1] = CVAR_frontier[x] + CVAR_step


""" Effcient Frontier"""
AVG_Returns_Frontier = np.zeros(len(CVAR_frontier)) 
Success_Rate = np.zeros(len(CVAR_frontier))
Solutions = np.zeros((len(CVAR_frontier),len(mean)))
Yield = np.zeros(len(CVAR_frontier))

# for x in range(len(CVAR_frontier)):
#     def constraint4(weights):
#         total = CVAR_frontier[x]
#         arg1 = weights.dot(Year1)
#         rr = arg1    
#         k = int(0.05*len(rr))
#         ind = np.argpartition(rr,k)[:k]
#         CVAR = sum(rr[ind])/len(rr[ind])
#         return total - CVAR
#     con4 = {'type': 'eq', 'fun': constraint4}
#     con1 = {'type': 'eq', 'fun': constraint1}
#     # con3 = {'type': 'ineq', 'fun': constraint3}
#     cons_cvar = ([con1,con4])
#     solution = minimize(objective_max_function, x0 = weights0, bounds =  bnds,   constraints =  cons_cvar)
#     Solutions[x] = np.around(solution.x*100,2)
#     RETURN_Series = returns_function(solution.x)
#     AVG_Returns_Frontier[x] = sum(RETURN_Series)/len(RETURN_Series)
#     Success_Rate[x] = sum(map(lambda y : y > 0.0, RETURN_Series))/len(RETURN_Series)

def optimize(x):
    def constraint4(weights):
        total = x
        arg1 = weights.dot(Year1)
        rr = arg1    
        k = int(0.05*len(rr))
        ind = np.argpartition(rr,k)[:k]
        CVAR = sum(rr[ind])/len(rr[ind])
        return CVAR - total
    con4 = {'type': 'ineq', 'fun': constraint4}
    con1 = {'type': 'eq', 'fun': constraint1}
    con6 = {'type': 'ineq', 'fun': constraint6}
    con7 = {'type': 'ineq', 'fun': constraint7}
    con8 = {'type': 'ineq', 'fun': constraint8}
    # con3 = {'type': 'ineq', 'fun': constraint3}
    cons_cvar = ([con1,con4,con6,con7 ,con8])
    solution = minimize(objective_max_function, x0 = weights0, bounds =  bnds,   constraints =  cons_cvar)
    Solutions = np.around(solution.x*100,2)
    RETURN_Series = returns_function(solution.x)
    AVG_Returns_Frontier = sum(RETURN_Series)/len(RETURN_Series)
    Success_Rate = sum(map(lambda y : y > 0.0, RETURN_Series))/len(RETURN_Series)
    return Solutions, AVG_Returns_Frontier

middle5_CVAR_frontier = [CVAR_frontier[1], CVAR_frontier[2], CVAR_frontier[3], CVAR_frontier[4], CVAR_frontier[5]]
tt = list(map(optimize, middle5_CVAR_frontier))

final_frontier = np.zeros((len(CVAR_frontier), 2))
final_frontier[0][0] = -1*CVAR_frontier[0]
final_frontier[0][1] = sum(MIN_Return_Series)/len(MIN_Return_Series)
final_frontier[6][0] = -1*CVAR_frontier[6]
final_frontier[6][1] = sum(MAX_Return_Series)/len(MAX_Return_Series)
for x in range(5):
    final_frontier[x+1][0] = -1*CVAR_frontier[x+1]
    final_frontier[x+1][1] = tt[x][1]
    
final_frontier = final_frontier*100

Solutions[0] = np.around(solution_min.x*100,2)
Solutions[6] = np.around(solution_max.x*100,2)
for x in range(5):
  Solutions[x+1] = tt[x][0]

class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)

Yield = Solutions.dot(query_yield)
numpyData = {"array": final_frontier}
encodedNumpyData = json.dumps(numpyData, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpySolutions = {"array2": Solutions}
encodedSolutions = json.dumps(numpySolutions, cls=NumpyArrayEncoder)  # use dump() to write array into file

numpyYields = {"yields": Yield}
encodedYields = json.dumps(numpyYields, cls=NumpyArrayEncoder)  # use dump() to write array into file


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

year_1 = Solutions.dot(sample1)/100
year_2 = Solutions.dot(sample2)/100
year_3 = Solutions.dot(sample3)/100
year_4 = Solutions.dot(sample4)/100
year_5 = Solutions.dot(sample5)/100
year_6 = Solutions.dot(sample6)/100
year_7 = Solutions.dot(sample7)/100
year_8 = Solutions.dot(sample8)/100
year_9 = Solutions.dot(sample9)/100
year_10 = Solutions.dot(sample10)/100

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


Success_Rate_year_1 = np.empty(shape=(7,1))
Success_Rate_year_2 = np.empty(shape=(7,1))
Success_Rate_year_3 = np.empty(shape=(7,1))
Success_Rate_year_4 = np.empty(shape=(7,1))
Success_Rate_year_5 = np.empty(shape=(7,1))
Success_Rate_year_6 = np.empty(shape=(7,1))
Success_Rate_year_7 = np.empty(shape=(7,1))
Success_Rate_year_8 = np.empty(shape=(7,1))
Success_Rate_year_9 = np.empty(shape=(7,1))
Success_Rate_year_10 = np.empty(shape=(7,1))


for i in range(7):
  Success_Rate_year_1[i] = sum(map(lambda y : y > 0.0, forecast1[i]))/len(forecast1[i])
  Success_Rate_year_2[i] = sum(map(lambda y : y > 0.0, forecast2[i]))/len(forecast2[i])
  Success_Rate_year_3[i] = sum(map(lambda y : y > 0.0, forecast3[i]))/len(forecast3[i])
  Success_Rate_year_4[i] = sum(map(lambda y : y > 0.0, forecast4[i]))/len(forecast4[i])
  Success_Rate_year_5[i] = sum(map(lambda y : y > 0.0, forecast5[i]))/len(forecast5[i])
  Success_Rate_year_6[i] = sum(map(lambda y : y > 0.0, forecast6[i]))/len(forecast6[i])
  Success_Rate_year_7[i] = sum(map(lambda y : y > 0.0, forecast7[i]))/len(forecast7[i])
  Success_Rate_year_8[i] = sum(map(lambda y : y > 0.0, forecast8[i]))/len(forecast8[i])
  Success_Rate_year_9[i] = sum(map(lambda y : y > 0.0, forecast9[i]))/len(forecast9[i])
  Success_Rate_year_10[i] = sum(map(lambda y : y > 0.0, forecast10[i]))/len(forecast10[i])


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


jsonMerged = {**json.loads(encodedNumpyData), **json.loads(encodedSolutions), **json.loads(encodedYields), **json.loads(encodedSuccessRate_year1), **json.loads(encodedSuccessRate_year2), **json.loads(encodedSuccessRate_year3), **json.loads(encodedSuccessRate_year4), **json.loads(encodedSuccessRate_year5), 
              **json.loads(encodedSuccessRate_year6), **json.loads(encodedSuccessRate_year7), **json.loads(encodedSuccessRate_year8), **json.loads(encodedSuccessRate_year9) ,**json.loads(encodedSuccessRate_year10)}
              
asString = json.dumps(jsonMerged)
print(asString)
# print(encodedSolutions)

# end = time()
# print(f'It took {end - start} seconds!')
