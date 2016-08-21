library(shiny)
require(ggplot2)
require(scales)

shinyServer( 
  function(input, output) { 
      
#####
#Conventional Trucks    
#####
    
    #Calculate lifetime fuel cost
      output$LifeCost <- renderText({
        
        TotFuelCost <- rep(0, input$VehLife)
        
#Loop through each year of vehicle life, incrementing fuel price and summing fuel cost
        for (i in 1:input$VehLife){
          
          TotFuelCost[i] <- ((365 * (input$VehDRange / input$Mpg) * input$DieselPrice) * ((1 + input$FuelEscRate) ^ (input$VehLife - i)))
        }
        
        #Add lifetime fuel cost to lifetime maintenance and capital costs
        dollar((input$VehLife * 365 * input$VehMaintCost) + input$VehCapCost + sum(TotFuelCost))
      
  })
 
#####
#Electric Trucks    
#####     
      
      #Calculate lifetime fuel cost
      output$EVLifeCost <- renderText({
        
        TotElecCost <- rep(0, input$EVVehLife)
      
        #Loop through each year of vehicle life, incrementing fuel price and summing fuel cost
        for (i in 1:input$EVVehLife){
          
          TotElecCost[i] <-
            ((365 * (input$EVVehDRange * input$ElecEff) * input$ElecPrice) *
               (1 + input$ElecEscRate) ^ input$EVVehLife - i)
                }
                
        #Add lifetime fuel cost to lifetime maintenance, infrastructure, and capital costs        
        dollar((input$EVVehLife*365*input$EVVehMaintCost) + input$EVVehCapCost+sum(TotElecCost) + input$EVInfCost)
        
      })
      
      #Plot cumulative cost per year
      
      output$CostPlot <- renderPlot({
        
        #####
        ##Conventional trucks
        #####
        
        #Create empty vectors
        TotFuelCost <- rep(0, input$VehLife)
        
        Years <- 1:input$VehLife
        
        #Loop through each year of vehicle life, incrementing fuel price
        for (i in 1:input$VehLife){
          
          TotFuelCost[i] <- ((365 * (input$VehDRange / input$Mpg) * input$DieselPrice) *
                               ((1 + input$FuelEscRate) ^ (input$VehLife - i)))
        }
        
        #Vector with cumulative sum of fuel costs
        TotFuelCostCum <- cumsum(TotFuelCost)
        
        #Vector with cumulative sum of maintenance costs
        VehMaintCost <- cumsum(input$VehLife * 365 * input$VehMaintCost)
        #         
        #         #Vector with cumulative sum of fuel, maintenance, and capital costs
        TotCostCum <- TotFuelCostCum + 
          VehMaintCost +
          input$VehCapCost 
        
        #####
        ##Electric trucks
        #####  
        
          #Create empty vectors
          TotElecCost <- rep(0, input$EVVehLife)
          
          EVYears <- 1:input$EVVehLife
          
          #Loop through each year of vehicle life, incrementing fuel price 
          for (i in 1:input$EVVehLife){
            
            TotElecCost[i] <- 
              ((365 * (input$EVVehDRange * input$ElecEff) * input$ElecPrice) *
                 (1 + input$ElecEscRate) ^ input$EVVehLife - i)
          
        }
        
          #Vector with cumulative sum of fuel costs
          TotElecCostCum <- cumsum(TotElecCost)
          
          #Vector with cumulative sum of maintenance costs
          EVVehMaintCost <- cumsum(input$EVVehLife * 365 * input$EVVehMaintCost)
                   
          #Vector with cumulative sum of fuel, maintenance, and capital costs
          EVTotCostCum <- TotElecCostCum + 
            EVVehMaintCost +
            input$EVVehCapCost 
       
        
        #Join year and cost data
        plotdata <- cbind(as.data.frame(Years), as.data.frame(TotCostCum))
        
        #Join year and cost data
        EVplotdata <- cbind(as.data.frame(EVYears), as.data.frame(EVTotCostCum))
        
        #Plot joined data
        ggplot(data=plotdata, aes(x=plotdata[,1],y=plotdata[,2], color="Conventional")) + 
          geom_line(size=2) + 
          geom_line(data=EVplotdata, mapping=aes(x=EVplotdata[,1], y=EVplotdata[,2], color = "Electric"), size =2) + 
          expand_limits(x = 1, y = 0) +
          labs(x="Years", y="Cumulative Lifetime Cost ($)", title = "Cumulative Lifetime Cost") +
          scale_colour_manual(values=c("orange","green")) +
          theme(legend.title=element_blank()) +
          scale_x_continuous(breaks=seq(0,max(input$VehLife, input$EVVehLife, 1))) + 
          scale_y_continuous(labels = dollar)

})
})

