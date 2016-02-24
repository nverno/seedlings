### search_ui.R --- 
## Filename: search_ui.R
## Description: UI for search.R
## Author: Noah Peart
## Created: Sat Jan 23 18:18:09 2016 (-0500)
## Last-Updated: Sat Jan 23 18:19:06 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'srch'

srchUI <- tagList(
    fluidRow(
        box(title='Search Results', id='search-box',
            status='primary',
            verbatimTextOutput('srchResText'),
            width=12, collapsible = TRUE, collapsed=TRUE)
    )
)
