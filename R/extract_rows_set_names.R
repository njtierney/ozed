#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param raw_data_2014
#' @param row_numbers
#' @param names
#' @return
#' @author njtierney
#' @export
extract_rows_set_names <- function(raw_data, 
                                   row_numbers, 
                                   names = new_names) {

  educated_raw <- raw_data %>% 
    slice(row_numbers) %>% 
    set_names(new_data_names)
  

}
