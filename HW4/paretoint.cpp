#include <Rcpp.h>
#include <math.h>

using namespace Rcpp;

// [[Rcpp::export]]
/* Function: pareto
 * Input:
 *    x: Input variable of the Pareto Density Function f[x].
 *    c: Constant input variable of the Pareto Density Function f[x].
 *    p: Constant input variable of the Pareto Density Function f[x].
 * 
 * Output:
 *    paretoResult: Output of the Pareto Density Function f[x].
 * */
double pareto(double x, double c, double p) {
  // Results for the Pareto Density Function.
  double paretoResult;
  
  // Pareto Density Function
  if (x >= 0) {
    paretoResult = (p - 1)*(pow(c, p - 1))*(pow(x + c, -p));
  } else {
    paretoResult = 0;
  }
  return paretoResult;
}

// [[Rcpp::export]]
/* Function: paretoint
 * Input:
 *    lowerBound: Lower-bound of the integration.
 *    upperBound: Upper-bound of the integration.
 *    n: Number of sample increments in the integration grid [for us we 
 *           use 1 million values ranging from x = 0 and x = xmax].
 *    c: Constant input variable of the Pareto Density Function f[x].
 *    p: Constant input variable of the Pareto Density Function f[x].
 *    paretoIntegralResult: Initialized variable to store the result.
 * 
 * Output:
 *    paretoIntegralResult: Approximated integral result.
 *    
 * */
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
  // Approximate the Integral of the Pareto Density function
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
