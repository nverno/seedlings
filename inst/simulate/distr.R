## /* distr.R --- 
##' Filename: distr.R
##' Description: look at the distribution of coverage/counts
##' Author: Noah Peart
##' Created: Wed Feb 24 17:29:06 2016 (-0500)
##' Last-Updated: Wed Feb 24 20:17:53 2016 (-0500)
##'           By: Noah Peart
## */

##' ---
##' title: "Substrate samples"
##' ---

##---- setup, include=FALSE --------------------
library(knitr)
opts_chunk$set(message=FALSE, cache=FALSE, echo=TRUE)
library(data.table)
library(DT)
dtopts <- list(scrollX=TRUE)

library(seedsub)
subs <- copy(segsub)
seeds <- copy(segdata)
## /* end setup */

##' A bunch of the plots have multiple substrate samples in 1999 and some in 2003.  Perhaps
##' this can be used to get an idea of how much variation we should expect in the 
##' coverage percentages.  Also, how should the percentages be calculated - as the mean
##' of the three?
##' 
##' # Multiple substrate samples
##' 
##' Plots where we have multiple substrate samples in the same year:
##---- multiple-samples ----------------------------------------
mults <- subs[, .N, by=c("CONTNAM", "STPACE", "YEAR")][N > 1, ]
datatable(subs[mults, on=c("CONTNAM", "STPACE", "YEAR")], options=dtopts)
## /* end multiple-samples */

##' # Percent Cover
##' 
##---- ground-substrates ----------------------------------------
## Substrates on the ground
ground <- c("BLA5", "BLD5", "BSOIL", "RCK", "WATER", "WDG1", 
  "WDG5", "MSSG", "LITT", "LITC", "LITD", "LITM", "TIPA", "STPA", 
  "LITCRCK", "LITMRCK", "MSRCK", "MSBLA5", "MSWDG5")
grnd <- c("MSSG", "LITC", "LITD", "LITM")

dat <- subs[mults[YEAR == 1999, ], on=c("CONTNAM", "STPACE", "YEAR")]
dat[, GSUM := rowSums(.SD, na.rm=TRUE), .SDcols=grnd]
dat[, GSUM2 := rowSums(.SD, na.rm=TRUE), 
  .SDcols=setdiff(ground, c("LITM", "LITC", "LITD"))]
## /* end ground-substrates */
##' 
##' Using data from 1999, compare coverage sums only using the main substrates (
{{prettify(grnd)}}
##' ), with using all the available ground substrates (
{{prettify(ground)}}
##' )
##' 
##---- sum-box ----------------------------------------
par(mfrow = c(1, 2))
boxplot(dat[, GSUM2], main="1999 totals using\nALL substrates")
boxplot(dat[, GSUM], 
  main=sprintf("1999 totals using:\n%s", toString(grnd)))
## /* end sum-box */

##' Mean absolute difference in plots with multiple samples for the main substrates:
##---- cover-deviation ----------------------------------------
sds <- dat[, lapply(.SD, function(x) mean(abs(diff(x)))), .SDcols=grnd,
  by=c("CONTNAM", "STPACE")]
sds <- sds[mults[YEAR == 1999,], on=c("CONTNAM", "STPACE")][, YEAR := NULL][]
setnames(sds, "N", "Count")
datatable(sds)
## /* end cover-deviation */
