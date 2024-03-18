prepare_population <- function(raw_data_2014) {


  # Population in age groups
  population_2014_raw <- extract_rows_set_names(
    raw_data_2014, 
    row_numbers = 24:31,
    names = new_names
  )
  
  population_2014 <- pivot_longer_population(population_2014_raw)
  

}
