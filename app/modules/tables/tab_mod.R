box::use(
  shiny[...]
)


ui <-  function(id ){
  ns <- NS(id)        
   fluidPage(

  
    h3("table"),
   uiOutput(ns("ui_out"))
)
}

server <- function(id,name=NULL,data=NULL) {
  moduleServer(
    id,
    function(input, output, session) {
  ns <- session$ns
  
  output$ui_out <- renderUI(
    
    tagList(
      h3("Module tab_mod"),
      h3(paste("Id is ",id)),
      h3(nrow(data()))
    )
    
  )
    
    
    }
)}