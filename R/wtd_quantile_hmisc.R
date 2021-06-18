hmisc_wtd_quantile <- function (x, weights = NULL, probs = c(0, 0.25, 0.5, 0.75, 1), 
                                type = c("quantile", "(i-1)/(n-1)", "i/(n+1)", "i/n"), normwt = FALSE, 
                                na.rm = TRUE) 
{
  if (!length(weights)) 
    return(quantile(x, probs = probs, na.rm = na.rm))
  type <- match.arg(type)
  if (any(probs < 0 | probs > 1)) 
    stop("Probabilities must be between 0 and 1 inclusive")
  nams <- paste(format(round(probs * 100, if (length(probs) > 
                                              1) 2 - log10(diff(range(probs))) else 2)), "%", sep = "")
  # remove missing weights/obs or zero-valued weights
  i <- is.na(weights) | weights == 0
  if (any(i)) {
    x <- x[!i]
    weights <- weights[!i]
  }
  
  # sum of weights at each value of var
  w <- Hmisc::wtd.table(x, weights, na.rm = na.rm, normwt = normwt, 
                        type = "list")
  x <- w$x
  wts <- w$sum.of.weights
  n <- sum(wts)
  order <- 1 + (n - 1) * probs # quantiles of weight dist
  low <- pmax(floor(order), 1)
  high <- pmin(low + 1, n)
  order <- order%%1
  allq <- approx(cumsum(wts), x, xout = c(low, high), method = "constant", 
                 f = 1, rule = 2)$y
  k <- length(probs)
  quantiles <- (1 - order) * allq[1:k] + order * allq[-(1:k)]
  names(quantiles) <- nams
  return(quantiles)
  
    
}


