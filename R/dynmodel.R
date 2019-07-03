as.focei.dynmodel <- function(object, uif, pt=proc.time(), ..., data, nobs2=0){
    .env <- new.env(parent=emptyenv());
    .env$nobs2  <- nobs2;
    .env$method <- "dynmodel"
    ## FIXME theta tanslation; For now use initial estimates
    .inits <- uif$focei.inits;
    .env$method <- "SAEM";
    .env$uif <- uif;
    .fixed <- uif$focei.fixed
    .env$theta <- data.frame(lower= uif$focei.lower, theta=.inits$THTA, upper=uif$focei.upper,
                             fixed=.fixed[seq_along(.inits$THTA)],
                             row.names=uif$focei.names);
    .env$fullTheta <- setNames(.inits$THTA, uif$focei.names)
    .env$omega <- NULL;
    .env$etaObf <- NULL;
    .env$noLik <- FALSE;
    ## FIXME supply objective function value.
    .env$objective <- 0;
    ## FIXME .ctl translation
    ## For now just assume foceiControl with no iterations
    .ctl <- foceiControl();
    .ctl$.covMethod <- "";
    .ctl$maxOuterIterations <- 0;
    .ctl$maxInnerIterations  <- 0;
    fit <- foceiFit.data.frame(data=data,
                               inits=.inits,
                               PKpars=uif$theta.pars,
                               ## par_trans=fun,
                               model=uif$rxode.pred,
                               pred=function(){return(nlmixr_pred)},
                               err=uif$error,
                               lower=uif$focei.lower,
                               upper=uif$focei.upper,
                               thetaNames=uif$focei.names,
                               etaNames=uif$eta.names,
                               etaMat=NULL,
                               env=.env,
                               fixed=.fixed,
                               skipCov=TRUE,
                               control=.ctl)
    return(fit);
}
