### debug.R --- 
## Filename: debug.R
## Description: 
## Author: Noah Peart
## Created: Mon Jan 25 19:32:44 2016 (-0500)
## Last-Updated: Mon Jan 25 19:33:03 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'debug'

## Print out debug info
debugShiny <- function(action) {
    debugVals$debugText <- isolate({
        if (action == 'sessionNames') {
            names(session$input)
        } else if (action == 'sessionValues') {
            sapply(names(session$input), function(x) input[[x]])
        } else
            tryCatch(eval(parse(text=input$debugInput)),
                     error=function(e) "Bad Things")
    })
}

output$debugOutput <- renderPrint({
    input$sessionNames; input$sessionValues; input$debug
    debugVals$debugText
})

debugVals <- reactiveValues(debugText="")

observeEvent(input$sessionNames, debugShiny('sessionNames'))
observeEvent(input$sessionValues, debugShiny('sessionValues'))
observeEvent(input$debug, debugShiny('debug'))

