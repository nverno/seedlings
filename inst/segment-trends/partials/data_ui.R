### data_ui.R --- 
## Filename: data_ui.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:13:23 2016 (-0500)
## Last-Updated: Tue Mar  8 19:29:55 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'dat'

datPanel <- fluidPage(
  box(title = "Datasets",
    width=12, "The four loaded datasets for contour segments: seedling/sapling locations, prism basal area estimates, substrate coverage, and gps location data."
  ),
  box(title = 'Segment Seedling Data',
    width=9,
    status="primary", solidHeader=TRUE, 
    DT::dataTableOutput("datSeeds")
  ),
  box(title='Prism Data',
    width=3, status="primary", solidHeader=TRUE,
    DT::dataTableOutput("datPrism")
  ),
  box(title="Substrate data",
    width=9, status="primary", solidHeader=TRUE,
    DT::dataTableOutput("datSubs")
  ),
  box(title="GPS data",
    width=3, status="primary", solidHeader=TRUE,
    DT::dataTableOutput("datGps")
  )
)

## Return when sourced
tagList(
  datPanel
)
