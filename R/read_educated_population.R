read_educated_population <- function(year = "2014") {

  raw_data <- read_raw_education_data(year = year)
  
  educated <- prepare_education(raw_data)
  
  population <- prepare_population(raw_data)
  
  # combine the data
  educated_population <- combine_educated_population(
    education = educated,
    population = population,
    year = year
  )
  
  educated_population

}
