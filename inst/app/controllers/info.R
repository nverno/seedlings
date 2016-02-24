### info.R --- 
## Filename: info.R
## Description: Display some info and link to document
## Author: Noah Peart
## Created: Mon Feb  1 21:26:30 2016 (-0500)
## Last-Updated: Mon Feb  1 21:46:19 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'info'

## Responds to change in data selection
## observeEvent(dat() {
  
## })

output$infoText <- renderUI({
  if (is.null(input$datGet) || input$datGet == 0L) {
    txt <- sprintf('<h1> %s </h1>', datDefault)
  }
})
