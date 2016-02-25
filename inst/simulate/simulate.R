## /* simulate.R --- 
##' Filename: simulate.R
##' Description: 
##' Author: Noah Peart
##' Created: Wed Feb 24 19:19:47 2016 (-0500)
##' Last-Updated: Wed Feb 24 19:21:39 2016 (-0500)
##'           By: Noah Peart
## */

##' ---
##' title: "Simulate Some Data"
##' ---
##---- setup, echo=FALSE, include=FALSE --------------------
library(knitr)
opts_chunk$set(message=FALSE, cache=FALSE, echo=TRUE)
library(data.table)
library(DT)
dtopts <- list(scrollX = TRUE)

## cleaned data
library(seedsub)
subs <- copy(segsub)
seeds <- copy(segdata)

## /* end setup */
