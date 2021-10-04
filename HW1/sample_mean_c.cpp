#include <Rcpp.h>
#include <Rmath.h>
using namespace Rcpp;

// [[Rcpp::export]]

DoubleVector sample_mean_c(DoubleVector sample_data_vec, int m) {
  
  DoubleVector sample_mean(m);
  double sample_sum = 0.0;
  
  for (int iteration = 0; iteration < m; iteration++) {
    sample_sum += sample_data_vec[iteration];
    
    sample_mean[iteration] = sample_sum / (iteration + 1);
    
    // std::cout << iteration << std::endl;
  }
  
  return sample_mean;
}
