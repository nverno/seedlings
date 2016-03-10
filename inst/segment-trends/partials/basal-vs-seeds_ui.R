### basal-vs-seeds_ui.R --- 
## Filename: basal-vs-seeds_ui.R
## Description: 
## Author: Noah Peart
## Created: Wed Mar  9 19:05:13 2016 (-0500)
## Last-Updated: Wed Mar  9 19:15:49 2016 (-0500)
##           By: Noah Peart
######################################################################
## prefix: "ba"

baUI <- tagList(
  div(class="radio-inline", 
    radioButtons("baYear", "Year", intersect(prism[, unique(YEAR)], seeds[,unique(YEAR)]))
  )
)

fluidPage(
  box(status="primary", width=3, baUI),
  box(title="Seedling (<100) Counts vs Total Basal Area (prisms)",
    plotOutput("baTotal"))
)
