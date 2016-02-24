### data.R --- 
## Filename: data.R
## Description: Import data
## Author: Noah Peart
## Created: Wed Jan 27 18:47:31 2016 (-0500)
## Last-Updated: Mon Feb  1 20:10:59 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'dat'

## data loaded via package seedsub.mas
dat <- reactive({
  if (input$datGet) {
    get(input$dat, datEnv)
  } else {
    submas99c
  }
})

output$datTable <- DT::renderDataTable({
  DT::datatable(dat(), options=list(scrollX=TRUE))
})
