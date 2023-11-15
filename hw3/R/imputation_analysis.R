#' analysis after imputation
#'@description when we use mice to impute the data including NA, the next step we want to do is analyze the efficacy of imputation. RE is a crucial factor to assess the efficacy of imputation.
#' @param formula the glm regression expression
#' @param imputed.data output of imputed data using MICE
#' @param n number of covariates
#' @param n.imp
#' @param mydata original data
#'
#' @return t,vm,w.bar,B,m,r,lamda,RE
#' @export
#'
#' @examples
miceanalyze = function(formula,imputed.data =imputed.data,n,n.imp=5,mydata){
  c = colnames(mydata)
  se = matrix(0,n.imp,n)
  theta.mean = matrix(0,n.imp,n)
  theta.i = matrix(0,n.imp,n)
  m = n.imp
  for(i in 1:n.imp){
    i = i
    data = data.frame(imputed.data[i])
    colnames(data)[]<- c
    model = lm(formula,data = data)
    se[i,] = summary(model)$coefficients[,2]
    theta.i[i,] = summary(model)$coefficients[,1]
  }
  # within imputation variance
  W = 1/m*colSums(se^2)
  w.bar = 1/m*sum(W)
  # between imputation variance
  thetamean = 1/m*colSums(theta.i)
  thetai = colSums(theta.i)
  B = 1/(m-1)*sum((thetai - thetamean)^2)
  # T
  t = w.bar + (1+1/m)*B
  vm = (m-1)*(1+w.bar/(1+(1/m)*B))^2

  #ANANLYSIS
  r = (1+1/m)*B/w.bar
  lambda = (r+2/(vm+3))/(r+1)
  RE = (1+lambda/m)^(-1)
  return(list(t=t,vm=vm,w.bar = w.bar,B=B,m=m,r = r,lambda = lambda,RE=RE))
}



