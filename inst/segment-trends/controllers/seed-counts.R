### seed-counts.R --- 
## Filename: seed-counts.R
## Description: 
## Author: Noah Peart
## Created: Wed Mar  9 16:28:53 2016 (-0500)
## Last-Updated: Wed Mar  9 16:30:43 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: "seed"

## Count seedlings by species
seedSpec <- reactive({
  seeds[YEAR == 1999 & STAT=="ALIVE" & HT < 100, .(Count=.N),
    by=c("CONTNAM", "STPACE", "SPEC")]
})
