#include <R.h>
#include <math.h>
#include <Rmath.h>

double pareto(double x, double c, double p) {
  double paretoResult;
  
  if (x >= 0) {
    paretoResult = (p - 1)*(pow(c, p - 1))*(pow(x + c, -p));
  } else {
    paretoResult = 0;
  }
  return paretoResult;
}