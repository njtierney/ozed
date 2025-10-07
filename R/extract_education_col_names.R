extract_education_col_names <- function(raw_data) {
  new_data_names_raw <- names(raw_data)
  new_data_names_raw[1] <- "state_territory"
  new_data_names <- new_data_names_raw
  new_data_names
}
