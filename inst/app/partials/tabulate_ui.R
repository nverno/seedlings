### tabulate_ui.R --- 
## Filename: tabulate_ui.R
## Description: UI for tabulate
## Author: Noah Peart
## Created: Mon Feb  1 20:13:46 2016 (-0500)
## Last-Updated: Mon Feb  1 21:16:34 2016 (-0500)
##           By: Noah Peart
######################################################################
## Prefix: 'tab'

## Common variables
cnames <- intersect(names(csub), names(cseed))
tnames <- intersect(names(tsub), names(tseed))
txt <- HTML(sprintf(
  "<ul>
    <li><b>Contours:</b> %s</li>
    <li><b>Transects:</b> %s</li>
  </ul>", 
  toString(tags$pre(toString(cnames))),
  toString(tags$pre(toString(tnames)))))

## Tabulating one variable by any amout of others
tabInput <- tagList(
  fluidRow(
    column(4,
      box(title='Shared variables between seedling/substrate data:',
        width=NULL,
        status='primary',
        solidHeader = TRUE,
        helpText(txt)
      ),
      box(title='Choose variables:',
        width=NULL,
        status='primary',
        solidHeader=TRUE,
        ## selectInput('tabDat', 'Data:', choices=c('Contours'=contours, 'Transects'=transects)),
        selectizeInput('tabGroup', 'Grouping Variables:', 
          names(csub), multiple =TRUE),
        selectizeInput('tabAgg', 'Aggregated Variables:', 
          names(csub), multiple=TRUE),
        actionButton('tabGet', 'Submit', icon=icon('send'), style='color:green;')
      )),
    column(8,
      box(title='Table:',
        width=NULL,
        DT::dataTableOutput('tabOut'))
      )
  )
)


