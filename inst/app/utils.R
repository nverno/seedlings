### utils.R --- 
## Filename: utils.R
## Description: 
## Author: Noah Peart
## Created: Sat Jan 30 21:51:59 2016 (-0500)
## Last-Updated: Sat Jan 30 21:52:02 2016 (-0500)
##           By: Noah Peart
######################################################################
"%||%" <- function(a, b) if (is.null(a)) b else a
