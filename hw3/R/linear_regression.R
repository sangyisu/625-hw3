
#' linear regression
#'
#' @param formula the  expression of linear regression formula
#' @param data our data
#'
#' @return formula, residuals.descript,Coefficients,CI,residual.std.error,residual.df,R_squared,Adjusted.R_squared,F.value,df,pvalue.f,fittedvalues,residual.
#' @export
#'
#' @examples example.r
linear_regression <- function(formula, data) {
  if (class(formula) != "formula")
    stop("'formula' must be a formula")
  if (is.data.frame(data) != TRUE) {
    warning("'data' is changed to a data.frame")
    data = as.data.frame(data)
  }
  newdata <- data[complete.cases(data), all.vars(formula)]

  Y <- newdata[, 1]
  variables <- model.matrix(formula, data = newdata)

  #estimate beta
  beta.hat <- solve(t(variables) %*% variables) %*% t(variables) %*% Y

  # Y.hat
  fittedvalues <- variables %*% beta.hat
  # residual
  residual <- Y - fittedvalues

  # freedom degree of residuals
  rank.p <- length(beta.hat)
  observations_count <- nrow(residual)
  residual.df <- observations_count - rank.p

  # use OLS
  ssy <- t(Y) %*% (diag(observations_count) - matrix(rep(1, observations_count ^ 2), observations_count, observations_count) / observations_count) %*% Y
  sse <- t(residual) %*% residual
  ssr <- ssy - sse

  #sigma^2.hat
  sigma_2.hat <- as.numeric(sse / residual.df)
  residual.std.error <- sqrt(sigma_2.hat)
  estimate.std.error <- sqrt(diag(as.matrix(solve(t(variables) %*% variables)) * sigma_2.hat))

  # t-value and degree freedom of t
  t.value <- beta.hat / estimate.std.error
  t.df <- pt(abs(t.value), df = residual.df)
  p.t <- 2 * (1 - t.df)
  # CI
  CI <- as.numeric(beta.hat) + cbind(-1 * estimate.std.error * t.df, estimate.std.error * t.df)

  # R^2
  R_squared <- as.numeric(ssr / ssy)
  Adjusted.R_squared <- as.numeric(1 - (sse / residual.df) / (ssy / (observations_count - 1)))
  # F-value
  F.value <- as.numeric((ssr / (rank.p - 1)) / (sse / residual.df))
  p.f <- pf(F.value, rank.p - 1, residual.df, lower.tail = FALSE)
  degreefreedom <- c(rank.p - 1, residual.df)
  coefficient <- data.frame(beta = beta.hat, Std.Error = estimate.std.error, t.value, p.t)
  residual.descript <- fivenum(residual)

  return(
    list(
      formula,
      residuals.descript = residual.descript,
      Coefficients = coefficient,
      CI = CI,
      residual.std.error = residual.std.error,
      residual.df = residual.df,
      R_squared = R_squared,
      Adjusted.R_squared = Adjusted.R_squared,
      F.value = F.value,
      df = degreefreedom,
      pvalue.f = p.f,
      fittedvalues = fittedvalues,
      residual = residual
    )
  )
}


