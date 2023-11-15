#' logistic regression
#'
#' @param formula math expression
#' @param data your data
#'
#' @return formula,coefficients,ite,fitted.values,residual,var,sigma_2.hat,residual.std.error
#' @export
#'
#' @examples
logistic = function(formula,data){
  if (class(formula) != "formula")
    stop("'formula' must be a formula")
  if (is.data.frame(data) != TRUE) {
    warning("'data' is changed to a data.frame")
    data = as.data.frame(data)
  }
  df <- data[complete.cases(data), all.vars(formula)]
  n=nrow(df)
  Y=df[,1]
  q=ncol(X)
  beta=rep(0,q)
  tol=0.00001
  epsilon=99
  ite_max=25
  ite=0
  while (epsilon > tol & ite <= ite_max){
    eta=X %*% beta
    mu=exp(eta)/(1+exp(eta))
    nu=mu*(1-mu)
    V=diag(x=as.vector(nu))
    Z=eta+solve(V) %*% (Y-mu);
    beta_new=solve(t(X) %*% V %*% X) %*% t(X) %*% V %*% Z
    epsilon = sqrt(t(beta_new-beta)%*%(beta_new-beta))
    beta=beta_new
    ite=ite+1
    beta_t=t(beta)
  }
  #fitted value
  fitted.values = X%*%beta

  # residuals
  residual = log(Y)-fitted.values

  # freedom degree of residuals
  rank.p <- length(beta)
  observations_count <- nrow(residual)
  residual.df <- observations_count - rank.p

  # Variance-covariance
  Var_beta = solve(t(X)%*% V %*% X)
  sigma_2.hat = diag(Var_beta)
  residual.std.error = sqrt(sigma_2.hat)
  return(list(
    formula=formula,
    coefficients = beta,
    ite= ite,
    fitted.values = fitted.values,
    residual =residual,
    var = Var_beta,
    sigma_2.hat=sigma_2.hat,
    residual.std.error = residual.std.error))
}


