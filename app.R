load("dataframe.RData")
ipack(packs)

library(shiny)


ui <- fluidPage(
   
   
   titlePanel(
     h1("Trade of coffee tea,mate and spices in Uruguay.")
     ),
   
   
   sidebarLayout(
     
     sidebarPanel(
       
       selectInput(
         "commodity",
         "Choise Commodity:", 
         choices = c(names( table(datos$Commodity) ) ),
         multiple = TRUE)
       
       ),
     
     mainPanel(
       plotlyOutput("timeseries")
       )
      #mainP
     
     )
   #sdL
   
  
   
   )
#FluidPage


server <- function(input, output) {
  
  commodityInput<-reactive({input$commodity})
  
   
   output$timeseries <- renderPlotly({
     
     
     if (is.null(commodityInput())){
       ggplotly(
         aggregate(Quantity ~ Year + Commodity ,data=datos,sum) %>% 
           ggplot(aes(
             x=Year,
             y=Quantity,
             group=Commodity)) + geom_line()
       )
       
     }
     else
     {
       
     ggplotly(
       aggregate(Quantity ~ Year + Commodity ,data=datos,sum) %>% 
         filter(Commodity%in%commodityInput()) %>%
         ggplot(aes(
           x=Year,
           y=Quantity,
           group=Commodity)) + geom_line()
     )
   }
     
     
   })
   
   
   
}#server


shinyApp(ui = ui, server = server)

