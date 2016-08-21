library(shiny)

shinyUI(fluidPage(

  #Create format and title
  fluidRow(
    column(8, offset=2,

           h1("E-Truck Business Case Calculator")
           )
    ),

  fluidRow(
    column(3,

           h3("Conventional Truck Info"),
           h5("Enter or select typical values for your conventional trucks."),

#Create inputs
           sliderInput(inputId = "VehLife",
                       label = "Vehicle Life (years)",
                       value = 10, min = 5, max = 20),
           
           numericInput(inputId = "VehDRange",
                        label = "Vehicle Daily Range (mi)",
                        value = 80),

        numericInput(inputId = "VehCapCost",
                  label = "Vehicle Capital Cost ($)",
                  value = 65000),

        numericInput(inputId = "VehMaintCost",
                   label = "Maintenance Cost ($/day)",
                   value = 0.35),
           
        numericInput(inputId = "DieselPrice",
                 label = "Diesel Fuel Price $/G",
                 value = 4.50),

        sliderInput(inputId = "Mpg",
                 label = "Fuel Efficiency (MPG)",
                 value = 2.0,
                 min = 1.0,
                 max = 15.0),

         sliderInput(inputId = "FuelEscRate",
                label = "Fuel Escalation Rate",
                value = 0.03,
                min = 0.00,
                max = 0.05)
        ),

column(3,
       
       h3("Electric Truck Info"),
       
       h5("Enter or select typical values for your electric trucks."),
       
       sliderInput(inputId = "EVVehLife",
                   label = "Vehicle Life (years)",
                   value = 10, min = 5, max = 20),
       
       numericInput(inputId = "EVVehDRange",
                    label = "Vehicle Daily Range (mi)",
                    value = 80),
       
       numericInput(inputId = "EVVehCapCost",
                    label = "Vehicle Capital Cost ($)",
                    value = 100000),

       numericInput(inputId = "EVInfCost",
                    label = "Infrastructure Costs ($)",
                    value = 10000),
       
       numericInput(inputId = "EVVehMaintCost",
                    label = "Maintenance Cost ($/day)",
                    value = 0.15),
       
       numericInput(inputId = "ElecPrice",
                    label = "Electricity Price $/kWh",
                    value = 1.8),
       
       sliderInput(inputId = "ElecEff",
                   label = "Efficiency (kWh/mi)",
                   value = 1.0,
                   min = 1.0,
                   max = 5.0),
       
       sliderInput(inputId = "ElecEscRate",
                   label = "Electricity Escalation Rate",
                   value = 0.02,
                   min = 0.00,
                   max = 0.05)
         ),

column(6,
       
       h4("Conventional Truck Total Lifetime Cost:"),
       
       h4(textOutput("LifeCost")),
       
       h4("Electric Truck Total Lifetime Cost:"),
       
       h4(textOutput("EVLifeCost")),
       
       plotOutput("CostPlot")
       
      )
)))

# plotOutput("CostPlot"))


# # #Electric Vehicle info
# # ElecInfCosts <-
# #   SmartMeters <-
# #   EVSE <-
# # ElecServUpCost <-
# #   PanelUpCost <-
# #   ConduitsCost <-
# #   TrenchingCost <-
# # LoadMgmtSftwCost <-
# # ConingencyCost <-
# #
# #
# # sliderInput()
# # MaxChargePower <-
# # VehMaintCostE <-
# # ElecCost <-
# # ElecEscRate <-
# #
# # checkboxInput()
# # InclDemCharge <- "Include Demand Charges"
# # selectInput()
# # DemCharg <- c(5,
# #               10,
# #               15,
# #               20,
# #               25)
# #
# # #Financial info
# # sliderInput()
# # CostofCap <-
# # StateEVIncent <-
# # FedEVIncent <-
# # EVInfIncent <-
# #
# # numericInput()
# # FleetSize <-
# #
# #
# # TotBattCost <-
# #   selectInput()
# #     BattCost <- c(300,
# #                   450,
# #                   600)
# #
# #   sliderInput()
# #     BattSize <-
# #
# #