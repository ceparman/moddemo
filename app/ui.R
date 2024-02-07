## ui.R ##
#
box::use(
  shiny[...],
  shinydashboard[...]
  
)


ui <- 
dashboardPage(
  title = "TLG Studio",
  dashboardHeader(title = "TLG Studio"),
  
  
  dashboardSidebar(
    
    sidebarMenu(
      
      #menuItem("Project Configuration", tabName = "project", icon = icon("gear")),
      
      menuItemOutput("project"),
      
       hr(),
      menuItemOutput("tables"),
      menuItemOutput("listings"),
      menuItemOutput("graphs"),
      hr(),
      
      h5("Content"),
      fluidRow(
        column(3,actionButton("object_add", "Add")),
        column(3,actionButton("object_remove", "Remove")),
        column(3,actionButton("object_save", "Save"))
        
      ),
      bookmarkButton()

    )
    
    
  ),
  dashboardBody(
    
    
    
  uiOutput("ui_out")  
    
   
    
    
  )
)
