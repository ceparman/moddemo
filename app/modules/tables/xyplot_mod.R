box::use(
  shiny[...],
  ggplot2[...]
)


ui <-  function(id ){
  ns <- NS(id)        
  fluidPage(
  
  titlePanel("X-Y plot"),
  
  fluidRow(
    
    column(3, uiOutput(ns("inputs"))),
    column(9, plotOutput(ns("graph_out")))
  ),
  

  
)

}

server <- function(id,name=NULL,data=NULL,config=NULL) {
  moduleServer(
    id,
    function(input, output, session) {
  ns <- session$ns


  current_config <-reactive({
    
   list(xcol=input$xcol,ycol=input$ycol) 
    
    
  })
  
  
  output$inputs <- renderUI({

    tagList(
      
      selectInput(ns("xcol"),label = "X Axis",
                  choices = c("Sepal.Length" ,"Sepal.Width",  "Petal.Length",
                              "Petal.Width"),selected = config$xcol),
    
    selectInput(ns("ycol"),label = "Y Axis",
                choices = c("Sepal.Length" ,"Sepal.Width",  "Petal.Length",
                            "Petal.Width"),selected = config$ycol
                
    )
    )  
    
  })
  
  
  
  output$graph_out <- renderPlot ({
    input$xcol
    input$ycol
    req(input$xcol,input$ycol)
   
    ggplot(data=data(), aes_string(input$xcol,input$ycol) )+ 
      geom_point() 
    
  }
    
  )
   
#  config <- reactive({list(xcol=input$xcol,ycol=input$ycol) })
  
   
  return(current_config)    
    }
  

  
)}