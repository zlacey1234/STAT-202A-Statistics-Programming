#include <Rcpp.h>
#include <Rmath.h>
using namespace Rcpp;


// [[Rcpp::export]]

NumericVector guassianKernelDensity(
    int m, int n, NumericVector gridpoints, 
    NumericVector x, NumericVector y, double bw) {
  
  for (int i = 0; i <= m; i++) {
    y[i] = sum(dnorm((x - gridpoints[i]) / bw, 0, 1, 0)) / n;
  }
  
  return y;
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//


