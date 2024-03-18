
read_raw_education_data <- function(year) {
  raw_data <- read_excel(
    path = here("data/Education and work, 2023, Datacube 2 (Table 11).xlsx"),
    sheet = year, 
    skip = 4, 
    n_max = 32,
    .name_repair = make_clean_names
  )

}
