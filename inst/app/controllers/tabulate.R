### tabulate.R --- 
## Filename: tabulate.R
## Description: Create tables
## Author: Noah Peart
## Created: Mon Feb  1 20:13:05 2016 (-0500)
## Last-Updated: Mon Feb  1 21:26:12 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'tab'

## Haven't combined datasets yet
## tabDat <- reactive({
##   input$tabDat
##   isolate({
##     if (is.null(input$tabDat)) return(dat())
##     dat()
##   })
## })

output$tabOut <- DT::renderDataTable({
  input$tabGet
  if (!is.null(input$tabGet) && input$tabGet > 0) {
    isolate({
      if (length(input$tabAgg) < 1L) {
        flash(session, text='Must have a variable to aggregate', type='danger')
        return()
      }
      if (!length(input$tabGroup)) {
        tab <- dat()[, .N, by=c(input$tabAgg)]
        setnames(tab, 'N', 'Count')
        return(tab)
      }
      lh <- paste(input$tabGroup, collapse='+')
      rh <- paste(input$tabAgg, collapse='+')
      form <- as.formula(paste(lh, '~', rh))
      dcast(data=dat(), formula=form, fill=0L)
    })
  }
}, options=list(scrollX=TRUE))

## Observers to update column names
observeEvent(dat(), {
  updateSelectizeInput(session, inputId='tabGroup',
    choices=names(dat()))
  updateSelectizeInput(session, inputId='tabAgg',
    choices=names(dat()))
})
