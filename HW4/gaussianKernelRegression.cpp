#include <Rcpp.h>
#include <Rmath.h>
using namespace Rcpp;

// [[Rcpp::export]]
/* Function: gaussianKernelRegression
 * Input:
 *    n: Number of observations in X and Y data
 *    X: observations in X
 *    Y: observations in Y
 *    m: Number of elements in vector m 
 *    g2: vector m, vector of values where we compute the kernel 
 *        regression estimates.
 *    res2: initialized Gaussian kernel regression estimate results 
 *          vector.
 *    bw:  bandwidth
 */
DoubleVector gaussianKernelRegression(
    int n, DoubleVector X, DoubleVector Y,
    int m, DoubleVector g2, DoubleVector res2, 
    double bw) {
  
  double numerator, denomenator;
  NumericVector kernel;
  
  for (int i = 0; i < m; i++) {
    numerator = 0.0;
    denomenator = 0.0;
    
    kernel = dnorm((X - g2[i]) / bw, 0, 1, 0) / bw;
    
    for (int j = 0; j < n; j++) {
      
      numerator += kernel[j] * Y[j];
      denomenator += kernel[j];
    }
    if (denomenator > 0.0) {
      res2[i] = numerator / denomenator;
    } else {
      res2[i] = 0.0;
    }
  }
  
  return res2;
}

