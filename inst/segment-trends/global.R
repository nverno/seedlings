### global.R --- 
## Filename: global.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 16:50:46 2016 (-0500)
## Last-Updated: Wed Mar  9 19:03:07 2016 (-0500)
##           By: Noah Peart
######################################################################
library(shiny)
library(shinydashboard)
library(data.table)
library(DT)
library(sjs)

library(lattice)
library(ggplot2)
library(viridis)
library(plotly)

## data packages
library(seedsub)   # segdata, segsub
library(prisms)    # prism
library(moosegps)  # allplots

## data
seeds <- copy(segdata)
subs <- copy(segsub)
prism <- copy(prism)
gps <- copy(allplots)
source("controllers/setup.R")  # some data prep

## directory layout
ploc <- 'partials'
cloc <- 'controllers'

