### substrates_ui.R --- 
## Filename: substrates_ui.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 20:36:58 2016 (-0500)
## Last-Updated: Tue Mar  8 22:52:22 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: "sub"
## Barplot of percent covers, grouped by sample, split by substrate type
## Data selection:
## - plot, year, contour, aspcl, elevcl
subDataUI <- tagList(
  helpText("These controls restrict available plots"),
  selectInput("subYear", "Year", c("All", subs[,unique(YEAR)])),
  selectInput("subAsp", "Aspect", c("All", subs[,unique(ASPCL)])),
  selectInput("subElev", "Elev", c("All", subs[,unique(ELEVCL)])),
  br(),
  selectInput("subCont", "Contour", c("All", subs[,unique(CONTNAM)])),
  selectInput("subPace", "Pace", c("All", subs[,unique(STPACE)])),
  fluidRow(
    column(6, actionButton("subReset", "Reset")),
    column(6, actionButton("subDat", "Submit"))
  )
)

subBarUI <- tagList(
  selectInput("subFill", "Color", c("viridis"="D","magma"="A","inferno"="B","plasma"="C")),
  selectInput("subBarPos", "Bars", c("stacked"="stack", "side-by-side"="dodge"))
)

fluidPage(
  box(title="Data",
    width=3, status="primary", solidHeader=TRUE,
    subDataUI
  ),
  box(
    width=9,
    plotly::plotlyOutput("subBar")
  ),
  box(title="Graph", width=3,
    subBarUI
  )
)
