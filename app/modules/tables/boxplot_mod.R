box::use(
  shiny[...],
  ggplot2[...]
)


ui <-  function(id ){
  ns <- NS(id)        
  fluidPage(
  
  titlePanel("XBox plot"),
  
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
      
      selectInput(ns("var"),label = "Variable",
                  choices = c("Sepal.Length" ,"Sepal.Width",  "Petal.Length",
                              "Petal.Width"),selected = config$xcol)
                
  
    )  
    
  })
  
  
  
  output$graph_out <- renderPlot ({

    req(input$var)
   
    ggplot(data() ) +
      geom_boxplot(aes_string(input$var)  )
    
    
  }
    
  )
   
#  config <- reactive({list(xcol=input$xcol,ycol=input$ycol) })
  
   
  return(current_config)    
    }
  

  
)}