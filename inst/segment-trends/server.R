### server.R --- 
## Filename: server.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:11:19 2016 (-0500)
## Last-Updated: Wed Mar  9 19:11:24 2016 (-0500)
##           By: Noah Peart
######################################################################
shinyServer(function(input, output, session) {

  ## Source controllers
  controls <- c(
    ## 'menu',                           # dropdown menu
    ## 'search',                         # search controls
    "data",                              # data importing
    "basal-vs-seeds",                    # basal area/seedling counts
    "substrates",                        # substrates
    "debug"                              # add a debugging panel
  )
  for (i in controls) source(file.path(cloc, paste0(i, '.R')), local=TRUE)
})
