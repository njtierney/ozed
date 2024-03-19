prepare_education <- function(raw_data) {

  # clean up the silly names from excel
  new_names <- extract_education_col_names(raw_data)
  
  # subset the data down to the number of educated people section
  educated_2014_raw <- extract_rows_set_names(
    raw_data_2014, 
    row_numbers = 4:11,
    names = new_names
  )
  
  educated_2014 <- pivot_longer_educated(educated_2014)
  
  educated
  

}
