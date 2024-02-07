
# browser()
# 
# #options("box_path" = getwd())
# 
 box::use(
   shiny[...],
   shinydashboard[...],
#   tools[file_path_sans_ext]
#  # modules /tables / xyplot_mod
 )


#add modules to box environment
# 
# fld <- "modules/tables"
# 
# browser()
# 
# fns <- tools::list_files_with_exts(fld, "R") |> 
#   tools::file_path_sans_ext() |>
#   lapply(str2lang)
# 
# browser()
# 
# options("box_path" = "cloud/project")
# 
# ## call box::use with the the newly created list
# do.call(box::use, fns)
# 




#'@export
tabItemsl <- function (...) 
{
  lapply(..., shinydashboard:::tagAssert, class = "tab-pane")
  div(class = "tab-content", ...)
}  

#'@export
load_all_tables <- function(tables,data) {
  
  n <- length(tables)
  
  if (n >0) {
    
    for (i in 1:n){
      
      mod <- tables[[i]]$type
      
      config <-tables[[i]]$config
      
      config <-     do.call(get(mod)$server, list(id=paste0("table",i),data=data, config= config ) )
      
    }
    
  }
  
return(T)  
}  


#'@export
load_project <- function(project,data){
  
 
#Load project settings


#load tables

table_load <- load_all_tables(project$tables,data)    
  
#load graphs  
  
#load listing  
  
  

return(T)  
  
}