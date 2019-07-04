as.focei.dynmodel <- function(object, uif, pt=proc.time(), ..., data, nobs2=0){
    .env <- new.env(parent=emptyenv());
    .model <- RxODE::rxSymPySetupPred(uif$rxode.pred,
                                      function(){return(nlmixr_pred)},
                                      uif$theta.pars,
                                      uif$error,
                                      grad=FALSE,
                                      pred.minus.dv=TRUE, sum.prod=FALSE, #control$sumProd,
                                      theta.derivs=FALSE, optExpression=TRUE, #control$optExpression,
                                      run.internal=TRUE, only.numeric=TRUE)
    ## summary(.model$pred.only)
    ## Required elements are:
    ## $parFixedDf
    ## $parFixed
    ## $covMethod
    ## $objf
    ## $parFixed
    ## $fixef
    ## $cov
    ## $uif
    ## $logLik
    ## $nobs
    ## Need $model for simulations

    ## Required checks
    ## plot(obj)
    ## setOfv(obj) ## fail
    ## ranef(obj) ## fail

    ## Data
    ## ID, PRED, RES, WRES

    ## optional
    ## $seed for mcmc
    ## $parHist
    ## $parHistStacked

    ## .parFixedDf <- data.frame("Estimate", "SE", "%RSE"
    ##                           "Back-transformed", "CI Lower", "CI Upper")
    ## .parFixed <- "Parameter" "Est."     "SE" "%RSE" "Back-transformed(95%CI)"
}
