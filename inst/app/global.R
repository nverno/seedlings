library(shiny)
library(shinydashboard)
library(shinyBS)
library(data.table)

## some github packages
library(sjs)  # 'nverno/sjs' for flashes
library(seedsub.mas)
source('utils.R')

## Data: use shorter names
contours <- c('seesapmas11', 'submas99c')
transects <- c('trseedmas11', 'trsubmas11c')
meta <- data(package='seedsub.mas')$results
datasets <- meta[,'Item']
datNames <- meta[,'Title']
datEnv <- getNamespace('seedsub.mas')

## shortended names
cseed <- copy(seesapmas11)
csub <- copy(submas99c)
tseed <- copy(trseedmas11)
tsub <- copy(trsubmas11c)

## directory layout
uiloc <- 'partials'
ctrlloc <- 'controllers'

## docloc <- '../docs'
## manloc <- '../man'

