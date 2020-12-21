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
np.set_printoptions(threshold=np.inf)

###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################

def fleishman(b, c, d):
    """calculate the variance, skew and kurtois of a Fleishman distribution
    F = -c + bZ + cZ^2 + dZ^3, where Z ~ N(0,1)
    """
    b2 = b * b
    c2 = c * c
    d2 = d * d
    bd = b * d
    var = b2 + 6*bd + 2*c2 + 15*d2
    skew = 2 * c * (b2 + 24*bd + 105*d2 + 2)
    kurt = 24 * (bd + c2 * (1 + b2 + 28*bd) + 
                 d2 * (12 + 48*bd + 141*c2 + 225*d2))
    return (var, skew, kurt)

def flfunc(b, c, d, skew, kurtosis):
    """
    Given the fleishman coefficients, and a target skew and kurtois
    this function will have a root if the coefficients give the desired skew and kurtosis
    """
    x,y,z = fleishman(b,c,d)
    return (x - 1, y - skew, z - kurtosis)

def flderiv(b, c, d):
    """
    The deriviative of the flfunc above
    returns a matrix of partial derivatives
    """
    b2 = b * b
    c2 = c * c
    d2 = d * d
    bd = b * d
    df1db = 2*b + 6*d
    df1dc = 4*c
    df1dd = 6*b + 30*d
    df2db = 4*c * (b + 12*d)
    df2dc = 2 * (b2 + 24*bd + 105*d2 + 2)
    df2dd = 4 * c * (12*b + 105*d)
    df3db = 24 * (d + c2 * (2*b + 28*d) + 48 * d**3)
    df3dc = 48 * c * (1 + b2 + 28*bd + 141*d2)
    df3dd = 24 * (b + 28*b * c2 + 2 * d * (12 + 48*bd + 
                  141*c2 + 225*d2) + d2 * (48*b + 450*d))
    return np.matrix([[df1db, df1dc, df1dd],
                      [df2db, df2dc, df2dd],
                      [df3db, df3dc, df3dd]])

def newton(a, b, c, skew, kurtosis, max_iter=25, converge=1e-5):
    """Implements newtons method to find a root of flfunc."""
    f = flfunc(a, b, c, skew, kurtosis)
    for i in range(max_iter):
        if max(map(abs, f)) < converge:
            break
        J = flderiv(a, b, c)
        delta = -solve(J, f)
        (a, b, c) = delta + (a,b,c)
        f = flfunc(a, b, c, skew, kurtosis)
    return (a, b, c)


def fleishmanic(skew, kurt):
    """Find an initial estimate of the fleisman coefficients, to feed to newtons method"""
    c1 = 0.95357 - 0.05679 * kurt + 0.03520 * skew**2 + 0.00133 * kurt**2
    c2 = 0.10007 * skew + 0.00844 * skew**3
    c3 = 0.30978 - 0.31655 * c1
    logging.debug("inital guess {},{},{}".format(c1,c2,c3))
    return (c1, c2, c3)


def fit_fleishman_from_sk(skew, kurt):
    """Find the fleishman distribution with given skew and kurtosis
    mean =0 and stdev =1
    
    Returns None if no such distribution can be found
    """
    if kurt < -1.13168 + 1.58837 * skew**2:
        return None
    a, b, c = fleishmanic(skew, kurt)
    coef = newton(a, b, c, skew, kurt)
    return(coef)

def fit_fleishman_from_standardised_data(data):
    """Fit a fleishman distribution to standardised data."""
    skew = moment(data,3)
    kurt = moment(data,4)
    coeff = fit_fleishman_from_sk(skew,kurt)
    return coeff


def describe(data):
    """Return summary statistics of as set of data"""
    mean = sum(data)/len(data)
    var = moment(data,2)
    skew = moment(data,3)/var**1.5
    kurt = moment(data,4)/var**2
    return (mean,var,skew,kurt)

def generate_fleishman(a,b,c,d, N=100, X=3):
    """Generate N data items from fleishman's distribution with given coefficents"""
    r = np.array([
        [  3.40, -2.75, -2.00],
        [ -2.75,  5.50,  1.50],
        [ -2.00,  1.50,  1.25]
    ])
    x = norm.rvs(size=(X, N))
    if method == 'cholesky':
        # Compute the Cholesky decomposition.
        c = cholesky(r, lower=True)
    else:
        # Compute the eigenvalues and eigenvectors.
        evals, evecs = eigh(r)
        # Construct c, so c*c^T = r.
        c = np.dot(evecs, np.diag(np.sqrt(evals)))
    Z = np.dot(c, x)   
    F = np.zeros((X,N))
    for ii in range(3):
        F[ii] = a[ii] + Z[ii].dot((b[ii] +Z[ii].dot((c[ii]+ Z[ii](d[ii])))))
    return F

def _getAplus(A):
    eigval, eigvec = np.linalg.eig(A)
    Q = np.matrix(eigvec)
    xdiag = np.matrix(np.diag(np.maximum(eigval, 0.00001)))
    return Q*xdiag*Q.T

def _getPs(A, W=None):
    W05 = np.matrix(W**.5)
    return  W05.I * _getAplus(W05 * A * W05) * W05.I

def _getPu(A, W=None):
    Aret = np.array(A.copy())
    Aret[W > 0] = np.array(W)[W > 0]
    return np.matrix(Aret)

def nearPD(A, nit=10):
    n = A.shape[0]
    W = np.identity(n) 
# W is the matrix used for the norm (assumed to be Identity matrix here)
# the algorithm should work for any diagonal W
    deltaS = 0
    Yk = A.copy()
    for k in range(nit):
        Rk = Yk - deltaS
        Xk = _getPs(Rk, W=W)
        deltaS = Xk - Rk
        Yk = _getPu(Xk, W=W)
    return Yk
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################
###############################################################################

class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)

###############################################################################
###############################################################################

#### Inputs
method = 'cholesky'


mean = json.loads(sys.argv[1]) ##### FROM RUBY
std = json.loads(sys.argv[2]) ##### FROM RUBY
skew = json.loads(sys.argv[3]) ##### FROM RUBY
kurt = json.loads(sys.argv[4]) ##### FROM RUBY
correlation = json.loads(sys.argv[5]) ##### FROM RUBY

N = 10000

X = np.size(mean)



coeff1 = fit_fleishman_from_sk(skew[0],kurt[0])
coeff2 = fit_fleishman_from_sk(skew[1],kurt[1])
coeff3 = fit_fleishman_from_sk(skew[2],kurt[2])
coeff4 = fit_fleishman_from_sk(skew[3],kurt[3])
coeff5 = fit_fleishman_from_sk(skew[4],kurt[4])
coeff6 = fit_fleishman_from_sk(skew[5],kurt[5])
coeff7 = fit_fleishman_from_sk(skew[6],kurt[6])
coeff8 = fit_fleishman_from_sk(skew[7],kurt[7])
coeff9 = fit_fleishman_from_sk(skew[8],kurt[8])
coeff10 = fit_fleishman_from_sk(skew[9],kurt[9])



B = np.array([coeff1[0], coeff2[0], coeff3[0], coeff4[0], coeff5[0], coeff6[0], coeff7[0], coeff8[0], coeff9[0], coeff10[0] ])
C = np.array([coeff1[1], coeff2[1], coeff3[1], coeff4[1], coeff5[1], coeff6[1], coeff7[1], coeff8[1], coeff9[1], coeff10[1] ])
D = np.array([coeff1[2], coeff2[2], coeff3[2], coeff4[2], coeff5[2], coeff6[2], coeff7[2], coeff8[2], coeff9[2], coeff10[2] ])
A = np.array([-coeff1[1], -coeff2[1], -coeff3[1], coeff4[1], coeff5[1], coeff6[1], coeff7[1], coeff8[1], coeff9[1], coeff10[1] ])

#### Code
r = np.array(correlation)

r_pd = nearPD(r)
x = norm.rvs(size=(X, N))
if method == 'cholesky':
        # Compute the Cholesky decomposition.
        c = cholesky(r_pd, lower=True)
else:
        # Compute the eigenvalues and eigenvectors.
        evals, evecs = eigh(r_pd)
        # Construct c, so c*c^T = r.
        c = np.dot(evecs, np.diag(np.sqrt(evals)))

Z = np.dot(c, x)  
P = np.zeros((X,N))

for i in range(X):
    P[i] = (A[i] + Z[i]*(B[i] +Z[i]*(C[i]+ Z[i]*D[i])))*std[i]+mean[i]


numpyData = {"array": P}
encodedNumpyData = json.dumps(numpyData, cls=NumpyArrayEncoder)  # use dump() to write array into file
print(encodedNumpyData)
# print(Z)
# input1_json = json.dumps(input1, cls=NumpyArrayEncoder)
# SIZE = json.dumps(SIZE, cls=NumpyArrayEncoder)
# print(input1_json)