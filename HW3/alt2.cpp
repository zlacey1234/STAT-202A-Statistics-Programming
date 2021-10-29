#include <Rcpp.h>
#include <math.h>
using namespace Rcpp;

// [[Rcpp::export]]
/* Function: alt2
 * Input: 
 *    n: Number of iterations in the infinite series to estimate ln(n)
 *    
 * Output: 
 *    alt2Estimates: Vector that contains the first 'n' alt2 estimates of 
 *                   ln(n) 
 * 
 */
DoubleVector alt2(int n) {
  
  DoubleVector alt2Estimates(n);
  double series_sum = 0.0;
  
  for (int k = 1; k <= n; k++) {
    series_sum += (pow(-1.0, k + 1)) / k;
    alt2Estimates[k - 1] = series_sum;
  }
  
  return alt2Estimates;
}
