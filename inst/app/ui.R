
shinyUI(
  dashboardPage(
    dashboardHeader(title='Seedlings'),
    dashboardSidebar(
      sidebarSearchForm('srchText', buttonId = 'srchButton',
        label='Search columns (regex)...'),
      sidebarMenu(
        menuItem('Data', tabName='data', icon=icon('database')),
        menuItem('Tables', tabName='tabulate', icon=icon('table'))
      )
    ),
    dashboardBody(
      flashPoint(),
      singleton(tags$head(tags$script(src='collapse-box.js'))),
      source(file.path(uiloc, 'search_ui.R'), local=TRUE)$value,
      tabItems(
        tabItem('data', source(file.path(uiloc, 'data_ui.R'),
          local=TRUE)$value),
        tabItem('tabulate', source(file.path(uiloc, 'tabulate_ui.R'),
          local=TRUE)$value)
      ),
      source(file.path(uiloc, 'debug_ui.R'), local=TRUE)$value
    )
  )
)
