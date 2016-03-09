### debug_ui.R --- 
## Filename: debug_ui.R
## Description: 
## Author: Noah Peart
## Created: Tue Mar  8 19:10:18 2016 (-0500)
## Last-Updated: Tue Mar  8 19:10:35 2016 (-0500)
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
