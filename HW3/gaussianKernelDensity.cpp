#include <Rcpp.h>
#include <Rmath.h>
using namespace Rcpp;

// [[Rcpp::export]]
/* Function: gaussianKernelDensity
 * Input:
 *    m: Number of elements in vector m 
 *    n: Number of observations in earthquake magnitude data
 *    gridpoints: vector m, vector of values where we compute the 
 *                kernel estimate.
 *    x: earthquake magnitude data
 *    y: initialized Gaussian kernel density estimate results vector.
 *    bw: bandwidth
 *    
 * Output:
 *    y: Gaussian kernel density estimate results vector.
 *    
 */
NumericVector gaussianKernelDensity(
    int m, int n, NumericVector gridpoints, 
    NumericVector x, NumericVector y, double bw) {
  
  for (int i = 0; i <= m; i++) {
    y[i] = sum(dnorm((x - gridpoints[i]) / bw, 0, 1, 0)) / n;
  }
  
  return y;
}
