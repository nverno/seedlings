### setup.R --- 
## Filename: setup.R
## Description: some global data prep
## Author: Noah Peart
## Created: Wed Mar  9 16:38:35 2016 (-0500)
## Last-Updated: Wed Mar  9 19:17:41 2016 (-0500)
##           By: Noah Peart
######################################################################
pid <- c("CONTNAM", "STPACE")
consts <- c("ELEVCL", "ASPCL")

################################################################################
##
##                                Substrates
##
################################################################################
## Prefix: "sub"
## Ground and aerial substrates
ground <- c("BLA5", "BLD5", "BSOIL", "RCK", "WATER", "WDG1", "WDG5", "MSSG", "LITT", "LITC",
  "LITD", "LITM", "TIPA", "STPA", "LITCRCK", "LITMRCK", "MSRCK", "MSBLA5", "MSWDG5")
aerial <- c("WDA1", "WDA5", "MSWDA1", "MSWDA5")

## Add a summed ground cover column
subs[, GSUM := rowSums(.SD, na.rm=TRUE), .SDcols = ground]
subs[YEAR %in% c(1999, 2003), GSUM := GSUM - LITT]  # remove LITT if LITC, LITD, LITM

## Coverage percentages for ground substrates
cover <- subs[, lapply(.SD, function(x) x/subs[["GSUM"]]), .SDcols = ground]
cover <- cbind(subs[, .(PID, CONTNAM, STPACE, YEAR, QPOS, ASPCL, ELEVCL)], cover)

## Plots sampled across years
subPlots <- unique(subs[,.(CONTNAM, STPACE, YEAR, ASPCL, ELEVCL)])

################################################################################
##
##                                  Prisms
##
################################################################################
## prefix: "prism"
prismSpec <- prism[,.(BA=sum(CTP)), by=c(pid, consts, "SPEC","YEAR")]
prismTotal <- prism[,.(BA=sum(CTP)), by=c(pid, consts, "YEAR")]

################################################################################
##
##                               Seed/Saplings
##
################################################################################
## Prefix: "seed"
seedSpec <- seeds[STAT=="ALIVE" & HT < 100, .(COUNT=.N), by=c(pid, consts, "SPEC", "YEAR")]
seedPlots <- unique(seeds[YEAR == 1999,.(CONTNAM, STPACE)])

################################################################################
##
##                               Missing data
##
################################################################################
## Prefix: "no"
noPrism <- unique(prismSpec[!seedSpec, .(CONTNAM, STPACE, YEAR), on=c(pid, consts, "YEAR")])
noSeed <- unique(seedSpec[!prismSpec, .(CONTNAM, STPACE, YEAR), on=c(pid, consts, "YEAR")])
