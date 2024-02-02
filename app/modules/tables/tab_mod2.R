box::use(
  shiny[...]
)


ui <-  function(id ){
  ns <- NS(id)        
   fluidPage(

  
    h3("table 2"),
   uiOutput(ns("ui_out"))
)
}

server <- function(id) {
  moduleServer(
    id,
    function(input, output, session,name=NULL,data=NULL) {
  ns <- session$ns
  
  output$ui_out <- renderUI(
    
    tagList(
      h3("Module tab_mod2"),
      h3(paste("Id is ",id))
    )
    
  )
    
    
    }
)}