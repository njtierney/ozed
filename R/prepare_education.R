#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param raw_data_2014
#' @return
#' @author njtierney
#' @export
prepare_education <- function(raw_data_2014) {

  # clean up the silly names from excel
  new_names <- extract_education_col_names(raw_data_2014)
  
  # subset the data down to the number of educated people section
  educated_2014_raw <- extract_rows_set_names(
    raw_data_2014, 
    row_numbers = 4:11,
    names = new_names
  )
  
  educated_2014 <- pivot_longer_educated(educated_2014_raw)
  
  educated_2014
  

}