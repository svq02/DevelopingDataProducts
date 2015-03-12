################################################################################
##
## @file        ui.R
##
## @brief       Widgets and layout for sample shiny web app
##
##
## Copyright &copy; 2015 Seth A. Veitzer
## Please do not plagarize
##
################################################################################

shinyUI(pageWithSidebar(
  headerPanel('Proton Stopping Power'),
  sidebarPanel(
    ('Select Target Materials'), hr(),
    checkboxInput("checkBoxHydrogen", label = "Hydrogen", value = FALSE),
    checkboxInput("checkBoxAdipose", label = "Adipose Tissue", value = FALSE),
    checkboxInput("checkBoxBone", label = "Compact Bone", value = FALSE),
    checkboxInput("checkBoxLead", label = "Lead", value = FALSE),
    checkboxInput("checkBoxMuscle", label = "Striated Muscle", value = FALSE),
    checkboxInput("checkBoxWater", label = "Liquid Water", value = FALSE),
    hr(), hr(),
    checkboxInput("checkBoxMean", label = "Mean Stopping Power", value = FALSE),
    br(), hr(),
    checkboxInput("logAxes", label = "Show log axes", value = TRUE),
    hr(),
    actionButton('resetPlot', 'Reset Plot')
  ),
  mainPanel(
h1('Introduction'),
p('Proton Stopping Power is a measure of how fast a proton loses energy when
traveling in a particular material. When a charged particle like a proton moves
through a solid, gas, or liquid material, it loses energy through collisions
with the material nuclei and electrons in the material. The rate at which energy
is lost depends on the energy of the charged particle, and the properties of the
particular material. The rate at which energy is lost to the material is called
the Stopping Power'),

p('A plot of the stopping power vs. particle energy always has a peak, at which
most of the energy is lost, called the Bragg Peak. Typically, nealy all of a
particle\'s energy is deposited in a small physical region due to the Bragg peak.
This is especially useful in medical applications such as proton cancer
therapies, where a beam of protons can be tuned so that most of the energy of
the beam is delivered to a specific point, say a tumor, while very little energy
is deposited outside of that area. This technique allows for proton therapies to
treat tumors in sensitive areas such as eyes where traditional radiation
therapies can not be used.'),

h1('WebApp Documentation'),
strong("Don\'t worry about the science of stopping power!"),
('The purpose of this web app
is to demonstrate how to create a reactive shiny web app using R, not to produce
new science.  To use this app, select one or more target materials from the
check boxes on the side panel. This will plot the proton stopping power over a
range of energies for that material.  You can look at the stopping powers on a
log-log scale by checking the appropriate check box on the side panel. 
Clicking the "Reset Plot" button will reset the plot to its original state. 
In order to see the Bragg peak in more detail, unselect the "Log Axes" checkbox.'),

p('Selecting the "Mean Stopping Power" check box will compute the average 
stopping power of all the materials that are currently selected in real-time,
and display the results of the server calculation in the plot window. This is a
display of reactive output as a result of server calculations.'),

    plotOutput('plot'),

h1('Data Source Reference'),
('The stopping power data used here was scraped from the'),
a(href="http://www.nist.gov/pml/data/star/index.cfm", target="_blank", "NIST website"),
('that tabulates stopping powers for protons, electrons, and helium atoms (alpha particles).
You can find additional information on the physics of stopping powers, applications in
materials and accelerator science, as well as information about the models and experiments
that go into building the data tables at that website.')
  )
))
