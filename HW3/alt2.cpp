#include <Rcpp.h>
#include <math.h>
using namespace Rcpp;

// [[Rcpp::export]]
DoubleVector alt2(int n) {
  
  DoubleVector alt2Estimates(n);
  double series_sum = 0.0;
  
  for (int k = 1; k <= n; k++) {
    series_sum += (pow(-1.0, k + 1)) / k;
    alt2Estimates[k - 1] = series_sum;
  }
  
  return alt2Estimates;
}
