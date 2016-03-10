### ui.R --- 
## Filename: ui.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:07:14 2016 (-0500)
## Last-Updated: Wed Mar  9 19:13:07 2016 (-0500)
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
        menuItem("BA vs. seeds", tabName="baVseed"),
        menuItem("Substrates", tabName="substrates")
      )
    ),
    dashboardBody(
      flashPoint(),
      tabItems(
        tabItem('data', source(file.path(ploc, 'data_ui.R'), local=TRUE)$value),
        tabItem("baVseed", source(file.path(ploc, "basal-vs-seeds_ui.R"), local=TRUE)$value),
        tabItem("substrates", source(file.path(ploc, "substrates_ui.R"), local=TRUE)$value)
      ),
      source(file.path(ploc, 'debug_ui.R'), local=TRUE)$value
    )
  )
)
