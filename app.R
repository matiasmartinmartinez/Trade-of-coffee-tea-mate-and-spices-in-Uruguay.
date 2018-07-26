load("dataframe.RData")
ipack(packs)

library(shiny)


ui <- fluidPage(
   
   
   titlePanel(
     h1("Trade of coffee tea,mate and spices in Uruguay.")
     ),
   
   
   sidebarLayout(
     
     sidebarPanel(
       selectInput()
       ),
     mainPanel(
       plotlyOutput("kg")
       )
      #mainP
     
     )
   #sdL
   
   
   
   )
#FluidPage


server <- function(input, output) {
   
   output$kg <- renderPlotly({
     ggplotly(
       aggregate(Quantity ~  Commodity , data = datos, sum) %>% filter(Commodity!="Mate")%>%
         arrange(desc(Quantity)) %>% 
         head(10) %>%
         ggplot(
           aes(
             x= reorder( Commodity, -Quantity),
             y= Quantity))+
         geom_bar(
           stat="identity") + 
         theme(
           axis.text.x  = 
             element_blank()) + 
         labs(
           x="Commodity"
         )
     )
     
   })
   
   
   
}#server


shinyApp(ui = ui, server = server)

