### server.R --- 
## Filename: server.R
## Description: 
## Author: Noah Peart
## Created: Sat Jan 30 21:52:57 2016 (-0500)
## Last-Updated: Mon Feb  1 20:33:49 2016 (-0500)
##           By: Noah Peart
######################################################################

shinyServer(function(input, output, session) {

  ## Source controllers
  controls <- c(
    ## 'menu',                           # dropdown menu
    'search',                            # search controls
    'data',                              # data importing
    ## 'single-var',                     # examine single variables
    'tabulate',  
    ## 'connect_afs',                    # connecting with AFS
    'debug'                              # add a debugging panel
  )
  for (i in controls) source(file.path(ctrlloc, paste0(i, '.R')), local=TRUE)
})
