box::use(
  shiny[...]
)


ui <-  function(id ){
  ns <- NS(id)        
   fluidPage(

  
    h3("project"),
   uiOutput(ns("ui_out"))
)
}

server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
  ns <- session$ns
  
  output$ui_out <- renderUI(
    
    tagList(
      h3("Project Tab"),
      h3(paste("Id is ",id))
    )
    
  )
    
    
    }
)}