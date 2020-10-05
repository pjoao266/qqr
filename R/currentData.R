#' Get current data of the brazilian soccer championship
#'
#' Number of points, victories, defeats, ties and more info about the current brazilian soccer championship
#' @return  A data frame with the current information of the brazilian soccer championship
#' @encoding UTF-8
#' @import xml2
#' @import rvest
#' @import tidyverse
#' @export
currentData <- function(){
  site <- xml2::read_html("https://brasileirao.cbf.com.br/tabela-times")
  tabela <- site %>% rvest::html_table(fill = TRUE)
  tabela = tabela[[1]]
  col = colnames(tabela)
  col[2] = "Time"
  col[8] = "GC"
  col[9] = "GP"
  colnames(tabela) = col
  tabela = tabela %>% mutate(Recentes  = str_replace_all(Recentes,"\t",""),
                             Recentes  = str_replace_all(Recentes,"\n","")) %>%
    select(-15)
  return(tabela)
}
