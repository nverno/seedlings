### debug_ui.R --- 
## Filename: debug_ui.R
## Description: 
## Author: Noah Peart
## Created: Mon Jan 25 19:33:49 2016 (-0500)
## Last-Updated: Mon Jan 25 19:33:55 2016 (-0500)
##           By: Noah Peart
######################################################################
fluidRow(
    tagList(
        textInput('debugInput', "Debug input:", ''),
        fluidRow(
            column(2, actionButton('debug', 'Debug')),
            column(2, actionButton('sessionNames', 'Names')),
            column(2, actionButton('sessionValues', 'Values'))
        ),
        verbatimTextOutput('debugOutput')
    )
)
