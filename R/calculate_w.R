# calculate weights using residuals from different model objects

calculate_w <- function(model_object, treatment, data) { 
  
  if (class(model_object)!="fixest" & class(model_object)!="lm") {
    cat("WARNING: Model object is not of class 'lm' or 'fixest'\n")
  }
  
  if (class(model_object)=="fixest") {
    # only select observations that weren't automatically dropped during regression
    obs <- data[-model_object$obsRemoved,]
    # model regressing treatment on all covs
    d_tilde_form <- reformulate( 
      termlabels = all.vars(model_object$fml)[-c(1,which(all.vars(model_object$fml)==treatment))],
      response = treatment
    )
    # squared residuals from regression
    d_tilde <- lm(d_tilde_form, data = obs)$residuals^2
  }
  
  if (class(model_object)=="lm") {
    # only select observations that weren't automatically dropped during regression
    obs <- model_object$model
    
    d_tilde_form <- reformulate(
      termlabels = all.vars(model_object$terms[[3]])[-which(all.vars(model_object$terms[[3]])==treatment)],
      response = treatment
    )
    
    d_tilde <- lm(d_tilde_form, data = obs)$residuals^2
  }
  return(d_tilde)
}



# to-do

# - make compatible with lm_robust object
# - d_tilde_form for objects where FEs are entered seperately