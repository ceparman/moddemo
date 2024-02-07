box::use(
  shiny[...]
)


ui <-  function(id ){
  ns <- NS(id)        
   fluidPage(

  
    h3("project"),
   uiOutput(ns("ui_out")),
   actionButton(ns("browse"),"Browse")
)
}

server <- function(id,project_data,mod_return_val) {
  moduleServer(
    id,
    function(input, output, session) {
  ns <- session$ns

  output$ui_out <- renderUI({
  
    tagList(
      h3("Project Tab"),
      h3(paste("Id is ",id))
      )
    
  })
    
observeEvent(input$browse,
             browser())  
  
  
    
    }
)}