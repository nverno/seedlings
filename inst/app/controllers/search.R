### search.R --- 
## Filename: search.R
## Description: Controllers for searching dashboard
## Author: Noah Peart
## Created: Sat Jan 23 17:56:56 2016 (-0500)
## Last-Updated: Sat Jan 23 19:03:42 2016 (-0500)
##           By: Noah Peart
######################################################################
## Search input
## prefix: 'srch'
srchResults <- eventReactive(input$srchButton, {
    res <- grep(input$srchText, names(dat()), value=TRUE, ignore.case = TRUE, perl=TRUE)
    if (!length(res)) '' else res
})

output$srchResText <- renderPrint( srchResults() )

observeEvent(input$srchButton, {
    session$sendCustomMessage(type='collapse-search', 'search-box')
})
