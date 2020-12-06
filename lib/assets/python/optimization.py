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

Year1 = fleishman_opt.output(mean, std, skew, kurt, correlation)

""" Define Asset Class Constraints """
b1 = tuple(json.loads(sys.argv[6]))
b2 = tuple(json.loads(sys.argv[7]))
b3 = tuple(json.loads(sys.argv[8]))
b4 = tuple(json.loads(sys.argv[9]))
b5 = tuple(json.loads(sys.argv[10]))
b6 = tuple(json.loads(sys.argv[11]))
b7 = tuple(json.loads(sys.argv[12]))
b8 = tuple(json.loads(sys.argv[13]))
b9 = tuple(json.loads(sys.argv[14]))
b10 = tuple(json.loads(sys.argv[15]))
bnds = (b1,b2,b3,b4,b5,b6,b7,b8,b9,b10)
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
    sumweights = weights[0] + weights[1] + weights[2] + weights[3] + weights[4] + weights[5] + weights[6] + weights[7] + weights[8] + weights[9]
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



""" intial guess """
n = 10
weights0 = np.zeros(n)
weights0[0] = 0.30
weights0[1] = 0.05
weights0[2] = 0.05
weights0[3] = 0.15
weights0[4] = 0.05
weights0[5] = 0.15
weights0[6] = 0.00
weights0[7] = 0.00
weights0[8] = 0.10
weights0[9] = 0.15

""" define constraints"""
con1 = {'type': 'eq', 'fun': constraint1}
# con3 = {'type': 'ineq', 'fun': constraint3}
# cons = ([con1,con3])
cons = ([con1])



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
Solutions = np.zeros((len(CVAR_frontier),len(mean )))
for x in range(len(CVAR_frontier)):
    def constraint4(weights):
        total = CVAR_frontier[x]
        arg1 = weights.dot(Year1)
        rr = arg1    
        k = int(0.05*len(rr))
        ind = np.argpartition(rr,k)[:k]
        CVAR = sum(rr[ind])/len(rr[ind])
        return total - CVAR
    con4 = {'type': 'eq', 'fun': constraint4}
    con1 = {'type': 'eq', 'fun': constraint1}
    # con3 = {'type': 'ineq', 'fun': constraint3}
    cons_cvar = ([con1,con4])
    solution = minimize(objective_max_function, x0 = weights0, bounds =  bnds,   constraints =  cons_cvar)
    Solutions[x] = np.around(solution.x*100,2)
    RETURN_Series = returns_function(solution.x)
    AVG_Returns_Frontier[x] = sum(RETURN_Series)/len(RETURN_Series)
    Success_Rate[x] = sum(map(lambda y : y > 0.0, RETURN_Series))/len(RETURN_Series)

final_frontier = np.zeros((len(CVAR_frontier), 2))


for x in range(len(CVAR_frontier)):
    final_frontier[x][0] = -1*CVAR_frontier[x]
    final_frontier[x][1] = AVG_Returns_Frontier[x]

final_frontier = final_frontier*100

class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)

numpyData = {"array": final_frontier}
encodedNumpyData = json.dumps(numpyData, cls=NumpyArrayEncoder)  # use dump() to write array into file

Solutions = {"array2": Solutions}
encodedSolutions = json.dumps(Solutions, cls=NumpyArrayEncoder)  # use dump() to write array into file

jsonMerged = {**json.loads(encodedNumpyData), **json.loads(encodedSolutions)}
asString = json.dumps(jsonMerged)
print(asString)
# print(encodedSolutions)

# end = time()
# print(f'It took {end - start} seconds!')
