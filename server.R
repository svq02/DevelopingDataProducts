################################################################################
##
## @file        server.R
##
## @brief       Server functions for reactive app
##
##
## Copyright &copy; 2015 Seth A. Veitzer
## Please do not plagarize
##
################################################################################
      
#required libraries
library(shiny)

#load all data
stopping <- read.csv('stopping.csv', sep=' ')
nRows <- dim(stopping)[1]

shinyServer(
  function(input, output, session) {
    col <- rainbow(6)
    legend <- NULL
    legendCols <- NULL
# does not include mean checkbox
    checkBoxes = c('checkBoxHydrogen', 'checkBoxAdipose', 'checkBoxBone', 'checkBoxLead', 'checkBoxMuscle', 'checkBoxWater')
    materials = c('Hydrogen', 'Adipose Tissue', 'Compact Bone', 'Lead', 'Striated Muscle', 'Liquid Water')

# Render a plot of stopping power when check boxes are selected
    output$plot <- renderPlot({ 
# Reset the sums for calculating the mean
      sum <- rep(0.0, nRows)
      nBoxesChecked <- 0
      if (input$logAxes) {
        log <- 'xy'; xlim <- c(1e-3,1e4); ylim <- c(1,1e4) 
      } else {
        log <- ''; xlim <- c(0,2); ylim <- c(0,4000)
      }
      plot(stopping[,1],stopping[,1], type='n', xlim=xlim, ylim=ylim, log=log, 
           xlab='Proton Kinetic Energy (MeV)', 
           ylab='Stopping Power (Mev cm^2/g)', main='Total Stopping Power')
      for (i in 1:length(checkBoxes)) {
# Only plot if the checkbox is checked
        if (input[[checkBoxes[i]]]) {
          lines(stopping[,1],stopping[,i+1], lwd=3, col=col[i])
          legend <- c(legend, materials[i]); legendCols <- c(legendCols, col[i])
          sum <- sum + stopping[,i+1]
          nBoxesChecked <- nBoxesChecked + 1
        }
      }
# plot the mean if the box is checked and not the only checked box
      if (input[['checkBoxMean']]) {
        if (sum(sum) != 0.0) {
          lines(stopping[,1],sum/nBoxesChecked, lwd=3, col='black')
        legend <- c(legend, 'Mean Stopping Power'); legendCols <- c(legendCols, 'black')
        }
      }

# print the legend depending on what is being displayed and log axes or not
      if (length(legend) != 0) {
        if (input$logAxes) {
          legend(1e3, 3000, legend, lty=1, lwd=3, col=legendCols)
        } else {
          legend(1, 3000, legend, lty=1, lwd=3, col=legendCols)
        }
      }
    })

# reset check boxes if the button is pushed
    observe({
      if (input$resetPlot > 0) {
        for (i in 1:length(checkBoxes)) {
          updateCheckboxInput(session=session, checkBoxes[i], value=FALSE)
        }
        updateCheckboxInput(session=session, inputId="checkBoxMean", value=FALSE)
        updateCheckboxInput(session=session, inputId="checkBoxHydrogen", value=FALSE)
        updateCheckboxInput(session=session, inputId="logAxes", value=TRUE)
      }
    })

  }
)



