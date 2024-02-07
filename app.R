#app.R

rm(list = ls(box:::loaded_mods),envir = box:::loaded_mods)
options("box_path" = getwd())

box::use(
shiny[...],
shinydashboard[...],
tools[file_path_sans_ext],
dplyr[case_when],
purrr[map_chr],
jsonlite[read_json],
app / ui,
app / modules / project,
app / utils 
)


#add modules to box environment

fld <- "app/modules/tables"

fns <- tools::list_files_with_exts(fld, "R") |> 
    tools::file_path_sans_ext() |>
     lapply(str2lang)
  
## call box::use with the the newly created list
do.call(box::use, fns)





ui <- ui$ui


server <- function(input, output) { 
  

proj_config <- reactiveVal ( read_json("project_config.json") )  


#Run project UI

project$server("project")






#setup data

data <- reactiveVal(iris)


#Read in stored tables this will trigger the menu update

current_tables <- reactiveVal( read_json("saved_tables.json")$tables ) 


#Reactive to hold modules return values

mod_return_val <- reactiveValues()

#Initialize app with existing tables

#Run the modules for stored tables

#don't want his to be reactive, only runs at startup

project_start <- read_json("project_config.json")

#load <- utils$load_project(project=project_start,data=data)


#tables <-read_json("saved_tables.json")$tables

#load project module


#main project page  

project_item <- list( project = tabItem(tabName = "project", 
                                        project$ui(id="project"))
)

#tables

current_start_tables <- read_json("saved_tables.json")$tables 
n <- length(current_start_tables)


if(  n> 0) {
  table_items <- lapply(1:n, function(i) {
    tabItem(tabName = paste0("table", i) ,
            do.call(get(current_start_tables[[i]]$type)$ui, list(id =  paste0("table", i))))
  })
  
  
  for (i in 1:n){
  mod <- project_start$tables[[i]]$type
  
  config <- project_start$tables[[i]]$config
  
  cofig <- do.call(get(mod)$server, list=())
  
  
  #figures    
  
  figure_items <- list()    
  
  #listing items
  
  listing_tems <- list()
  
  utils$tabItemsl(c(project_item,table_items))
  
} 


















#Update menu to match current table list

  output$tables <- renderMenu({
    
    n <- length(current_tables())
    if( n >0) {  
      
      items <- lapply(1:n,function(i){
        menuSubItem(current_tables()[[i]]$title,
                    tabName = paste0("table",i), icon = icon("table"))
      }
      )
      
      #print(length(items))
      return(menuItem("Tables",
                      do.call(tagList, items)))
    } else{ return(menuItem("Tables",icon = icon("table")))}
    
    
  })
  
  
  
  
  observeEvent(input$object_add, {
    

    
    showModal(modalDialog(title = "Add Object",size = "xl" ,
                       tagList(
                        fluidRow(
                          column(6,uiOutput("object_select_type") ) ,  
                          column(6, uiOutput("object_select_id") )
                           ),
                        fluidRow(column(6,textInput("table_title","Title"))),
                        actionButton("add_object",label = "Add Object")
                       ) 
                  )
    
                
              )
    
  }) 
    
  table_objects <- reactive({
    

    map_chr(list.files("app/modules/tables"),file_path_sans_ext)
    
#    names(tlgs[[tolower(input$object_type)]])
    
  })  
    
    
   
  output$object_select_type <- renderUI({
    
    
    tagList(
    
    selectInput("object_type",label = "Object Type",
                choices = c("Table","Listing","Figure") 
                )
  )
    
  })  
     
    
  output$object_select_id <- renderUI({
    
    req( input$object_type)
    tagList(
      
      selectInput("object_id",label = paste( input$object_type," ID"),
                  choices =table_objects() 
      )
    )
    
  })  
  
  
  
observeEvent(input$add_object,{

  switch( input$object_type,
          
          "table"   =  add_table(input,current_tables),
          
          "listing" = "",
          
          "graph"   = ""
             
             
             )
  
  
  
  add_table(input,current_tables)
  
  
  browser()
  
  removeModal()
  
  
  
})    
  
  
add_table <- function(input,current_tables) {
  
  
  n <- length(current_tables() ) +1
  
#  #  call module
  
##  mod <-   tlgs[[tolower(input$object_type)]][[input$object_id]]$call
  
# # do.call(get(mod)$server, list(id=paste0(tolower(input$object_type),n) ) ) 
  
#  # mod_test$server(paste0("table",n) )
  

  
  mod <-input$object_id 
  
  
  do.call(get(mod)$server, list(id=paste0("table",n),data=data ) )

  
  
  #add to current table, reactive will update menu 
  current_tables( c(current_tables(),
                    
                    list( newtable = list( type = input$object_id,
                                           title = input$table_title,
                                            config=list()))
  ))
  
  
  
}  

  

  
  output$ui_out <- renderUI( {
    
    
#Build tab items list     

#main project page  
    
project_item <- list( project = tabItem(tabName = "project", 
                        project$ui(id="project"))
)
 
#tables

current_tables <- current_tables()
n <- length(current_tables)


  if(  n> 0) {
    table_items <- lapply(1:n, function(i) {
      tabItem(tabName = paste0("table", i) ,
              do.call(get(current_tables[[i]]$type)$ui, list(id =  paste0("table", i))))
    })

 
#figures    
       
figure_items <- list()    

#listing items

listing_tems <- list()
    
utils$tabItemsl(c(project_item,table_items))

} 
  



  
    
  })
  
  #tableServer("table1")
  #tableServer("table2")
  
  onStop(function() {
    rm(list = ls())
  })
  
############## NOT  USED YET ################  
  
  
  output$listings <- renderMenu({
    
    return(menuItem("Listings", icon = icon("list")))
    
    # n <- length(current_listings())
    # if( n >0) {  
    #   
    #   items <- lapply(1:n,function(i){
    #     menuSubItem(current_listings()[[i]]$name,
    #                 tabName = paste0("table",i))
    #   }
    #   )
    #   
    #   #print(length(items))
    #   return(menuItem("Tables",
    #                   do.call(tagList, items)))
    # } else{ return(menuItem("Tables"))}
    # 
    
  })
  
  output$graphs <- renderMenu({
    
    return(menuItem("Graphs", icon = icon("signal")))
    
    # n <- length(current_listings())
    # if( n >0) {  
    #   
    #   items <- lapply(1:n,function(i){
    #     menuSubItem(current_listings()[[i]]$name,
    #                 tabName = paste0("table",i))
    #   }
    #   )
    #   
    #   #print(length(items))
    #   return(menuItem("Tables",
    #                   do.call(tagList, items)))
    # } else{ return(menuItem("Tables"))}
    # 
    
  })
  
  
  
}

shiny::shinyApp(ui,server)