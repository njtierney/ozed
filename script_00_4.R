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
# I guess it's only a study rather than the true numbers?
educated_population_2014 <- educated_2014 %>%
  left_join(population_2014, by = c("state_territory", "age_group")) %>%
  mutate(
    age_group = as_factor(age_group),
    prop_studying = n_studying / population,
    year = 2014
  ) %>%
  relocate(
    year
  )

educated_population_2014

ggplot(educated_population_2014, aes(x = prop_studying, y = state_territory)) +
  geom_col() +
  facet_wrap(~age_group)
