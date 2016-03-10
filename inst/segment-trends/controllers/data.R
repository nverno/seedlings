### data.R --- 
## Filename: data.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:16:45 2016 (-0500)
## Last-Updated: Wed Mar  9 23:27:51 2016 (-0500)
##           By: Noah Peart
######################################################################
## prefix: 'dat'

output$datSeeds <- DT::renderDataTable({
  datatable(seeds, options = list(scrollX=TRUE))
})

output$datSubs <- DT::renderDataTable({
  datatable(subs, options = list(scrollX=TRUE))
})

output$datGps <- DT::renderDataTable({
  datatable(gps, options = list(scrollX=TRUE))
})

output$datPrism <- DT::renderDataTable({
  datatable(prism, options = list(scrollX=TRUE))
})


