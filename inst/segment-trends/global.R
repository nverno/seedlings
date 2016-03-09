### global.R --- 
## Filename: global.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 16:50:46 2016 (-0500)
## Last-Updated: Tue Mar  8 20:37:56 2016 (-0500)
##           By: Noah Peart
######################################################################
library(shiny)
library(shinydashboard)
library(data.table)
library(DT)
library(sjs)

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

## directory layout
ploc <- 'partials'
cloc <- 'controllers'

