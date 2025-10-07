library(tidyverse)
library(here)
library(readxl)
library(naniar)
library(visdat)
library(janitor)

source("R/read_raw_education_data.R")
raw_data_2014 <- read_raw_education_data(year = "2014")

source("R/extract_education_col_names.R")
# clean up the silly names from excel
new_names <- extract_education_col_names(raw_data_2014)

source("R/extract_rows_set_names.R")
# subset the data down to the number of educated people section
educated_2014_raw <- extract_rows_set_names(
  raw_data_2014,
  row_numbers = 4:11,
  names = new_names
)

source("R/pivot_longer_educated.R")
educated_2014 <- pivot_longer_educated(educated_2014_raw)

# Population in age groups
population_2014_raw <- extract_rows_set_names(
  raw_data_2014,
  row_numbers = 24:31,
  names = new_names
)

source("R/pivot_longer_population.R")
population_2014 <- pivot_longer_population(population_2014_raw)

# combine the data
source("R/combine_educated_population.R")
educated_population_2014 <- combine_educated_population(
  education = educated_2014,
  population = population_2014,
  year = 2014
)

educated_population_2014

ggplot(educated_population_2014, aes(x = prop_studying, y = state_territory)) +
  geom_col() +
  facet_wrap(~age_group)
