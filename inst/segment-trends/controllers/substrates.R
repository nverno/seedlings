### substrates.R --- 
## Filename: substrates.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:47:43 2016 (-0500)
## Last-Updated: Wed Mar  9 16:41:08 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'sub'

## Barplot of percent covers, grouped by sample, split by substrate type
## Data selection:
## - plot, year, contour, aspcl, elevcl
## Graph Controls:
## - stacked / side
## - viridis colors
output$subBar <- plotly::renderPlotly({
  if (input$subDat > 0) {
    isolate({
      yr <- if (input$subYear == "All") unique(subs$YEAR) else input$subYear
      conts <- if (input$subCont == "All") unique(subs$CONTNAM) else input$subCont
      pace <- if (input$subPace == "All") unique(subs$STPACE) else input$subPace
      asp <- if (input$subAsp == "All") unique(subs$ASPCL) else input$subAsp
      elev <- if (input$subElev == "All") unique(subs$ELEVCL) else input$subElev
      dat <- cover[YEAR %in% as.integer(yr) & CONTNAM %in% conts & 
                    STPACE %in% as.integer(pace) & 
                    ASPCL %in% asp & ELEVCL %in% elev]
    })
    dat[, Sample := 1:.N]
    dat <- melt(dat, measure.vars=ground, variable.name="Substrate", value.name="Percent")[
      !(YEAR %in% c(1999, 2003) & Substrate=="LITT") & Percent > 0]
    p <- ggplot(dat, aes(Substrate, Percent))
    
    ## color by sample if only looking at one plot and one YEAR
    p <- if (uniqueN(dat[, .(CONTNAM, STPACE, YEAR)]) == 1L) {
           p + geom_bar(stat="identity", position=input$subBarPos, 
             aes(fill=factor(Sample))) +
             scale_fill_viridis("Sample", option=input$subFill, discrete=TRUE) +
             ggtitle(sprintf("%s, Pace %g, Year %g", dat[,unique(CONTNAM)], 
               dat[,unique(STPACE)], dat[,unique(YEAR)]))
    } else p + geom_bar(stat="identity", aes(fill=factor(Substrate))) +
        scale_fill_viridis("Substrate", option=input$subFill, discrete=TRUE) +
        ggtitle(sprintf("Cumulative Substrate Percentages across\n%g Plots and %g Years",
          uniqueN(dat[, .(CONTNAM, STPACE)]), uniqueN(dat[,.(YEAR)])))
    
    p + theme_bw()
  } else ggplot(data.frame(x=1, y=1), aes(x, y)) + geom_point(color="transparent")
})


################################################################################
##
##                                 Observers
##
################################################################################
observeEvent(input$subReset, {
  updateSelectInput(session, "subYear", selected="All")
  updateSelectInput(session, "subCont", selected="All")
  updateSelectInput(session, "subPace", selected="All")
  updateSelectInput(session, "subAsp", selected="All")
  updateSelectInput(session, "subElev", selected="All")
})

## Update the data selection panel to only allow available options
observe({
  input$subYear; input$subCont; input$subAsp; input$subElev;
  
  yr <- if (input$subYear == "All") unique(subPlots$YEAR) else input$subYear
  conts <- if (input$subCont == "All") unique(subPlots$CONTNAM) else input$subCont
  asp <- if (input$subAsp == "All") unique(subPlots$ASPCL) else input$subAsp
  elev <- if (input$subElev == "All") unique(subPlots$ELEVCL) else input$subElev
  dat <- subPlots[YEAR %in% as.integer(yr) & CONTNAM %in% conts & 
                    ASPCL %in% asp & ELEVCL %in% elev]

  updateSelectInput(session, "subCont", selected=input$subCont,
    choices=c("All", dat[,unique(CONTNAM)]))
  updateSelectInput(session, "subPace", selected=input$subPace,
    choices=c("All", dat[,unique(STPACE)]))
  updateSelectInput(session, "subAsp", selected=input$subAsp,
    choices=c("All", dat[,unique(ASPCL)]))
  updateSelectInput(session, "subElev", selected=input$subElev,
    choices=c("All", dat[,unique(ELEVCL)]))
})
