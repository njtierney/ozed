extract_rows_set_names <- function(raw_data, 
                                   row_numbers, 
                                   names = new_names) {

  educated_raw <- raw_data %>% 
    slice(row_numbers) %>% 
    set_names(names)
  

}
