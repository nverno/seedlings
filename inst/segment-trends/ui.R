### ui.R --- 
## Filename: ui.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:07:14 2016 (-0500)
## Last-Updated: Tue Mar  8 20:46:22 2016 (-0500)
##           By: Noah Peart
######################################################################
shinyUI(
  dashboardPage(
    dashboardHeader(title='Contour Segments'),
    dashboardSidebar(
      ## sidebarSearchForm('srchText', buttonId = 'srchButton',
      ##   label='Search columns (regex)...'),
      sidebarMenu(
        menuItem('Data', tabName='data', icon=icon('database')),
        menuItem("Substrates", tabName="substrates", icon=icon("bar"))
      )
    ),
    dashboardBody(
      flashPoint(),
      tabItems(
        tabItem('data', source(file.path(ploc, 'data_ui.R'), local=TRUE)$value),
        tabItem("substrates", source(file.path(ploc, "substrates_ui.R"), local=TRUE)$value)
      ),
      source(file.path(ploc, 'debug_ui.R'), local=TRUE)$value
    )
  )
)
