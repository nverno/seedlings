### setup.R --- 
## Filename: setup.R
## Description: some global data prep
## Author: Noah Peart
## Created: Wed Mar  9 16:38:35 2016 (-0500)
## Last-Updated: Sat Mar 12 00:45:28 2016 (-0500)
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

## Normalize counts using 'SDSP' and 'DSDSP' columns
## Notes: 
## - Missing SGLEN for ME2020 pace 900, but no SDSP[1-2] in this plot
unique(seeds[YEAR==1989 & !is.na(HT) & is.na(SGLEN), ])
sglens <- unique(seeds[!is.na(SGLEN), .(CONTNAM, STPACE)])
unique(seeds[,.(CONTNAM, STPACE)])[!sglens, on=names(sglens)]

unique(seeds[!is.na(SDSP1) & YEAR == 1999 & is.na(SGLEN), ])
  .(CONTNAM, STPACE, SDSP1, SGDSP)])

seed_counts <- function(size, data=seeds) {
  ## unnormalized counts
  data[STAT == "ALIVE" & HT < size, TMP := .N, by=c(pid, consts, "SPEC", "YEAR")]
  data[, SGLEN1 := unique(na.omit(SGLEN)), by=c(pid, consts, "YEAR")]
  data[!is.na(TMP) & SPEC == SDSP1 & is.na(SGLEN), ]
}
seedSpec <- seeds[STAT=="ALIVE" & HT < 100, .(COUNT=.N), by=c(pid, consts, "SPEC", "YEAR")]
seedPlots <- unique(seeds[YEAR == 1999,.(CONTNAM, STPACE)])

data[, tst := length(na.omit(unique(SGLEN))), by=c(pid, "YEAR")][tst > 1]
nrow(data[tst<1])

data[, tst := length(na.omit(unique(SGLEN))), by=c(pid)]



################################################################################
##
##                               Missing data
##
################################################################################
## Prefix: "no"
noPrism <- unique(prismSpec[!seedSpec, .(CONTNAM, STPACE, YEAR), on=c(pid, consts, "YEAR")])
noSeed <- unique(seedSpec[!prismSpec, .(CONTNAM, STPACE, YEAR), on=c(pid, consts, "YEAR")])
