### data_ui.R --- 
## Filename: data_ui.R
## Description: UI for import data
## Author: Noah Peart
## Created: Wed Jan 27 18:47:51 2016 (-0500)
## Last-Updated: Mon Feb  1 20:07:53 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'dat'

datPanel <- fluidPage(
  box(title = 'Datasets',
    width=3,
    selectInput('dat', 'Data', choices=setNames(datasets, datNames),
      selected='submas99c'),
    actionButton('datGet', 'Update')
  ),
  box(title='Table',
    width=9,
    DT::dataTableOutput('datTable'))
)

## Return when sourced
tagList(
  datPanel
)
