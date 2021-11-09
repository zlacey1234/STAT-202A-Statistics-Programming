#include <Rcpp.h>
#include <math.h>
#include <stdio.h>

using namespace Rcpp;

// [[Rcpp::export]]
double pareto(double x, double c, double p) {
  double paretoResult;
  
  if (x >= 0) {
    paretoResult = (p - 1)*(pow(c, p - 1))*(pow(x + c, -p));
  } else {
    paretoResult = 0;
  }
  return paretoResult;
}

// [[Rcpp::export]]
double paretoint(double lowerBound, double upperBound, long n, double c, 
               double p, double paretoIntegralResult) {
  double x, xIncrement, f;
  
  xIncrement = (upperBound - lowerBound) / (double) n;
  
  
  
  // Initialized values of Pareto Density function f at x = 0. 
  x = lowerBound; 
  f = pareto(x, c, p);
  
  for (int increment = 1; increment < n; increment++) {
    // Incremented values of Pareto Density function f at incremented x
    x += xIncrement;
    f += pareto(x, c, p);
  }
  
  paretoIntegralResult = f * xIncrement;
  return paretoIntegralResult;
}

// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically 
// run after the compilation.
//

/*** R
pareto(-1.5, 3.0, 2.0)
pareto(5.3, 3, 2)
pareto(0, 3, 2)
pareto(10, 3, 2)

paretoint(0, 10, 1000000, 3, 2, 0.0)
*/
