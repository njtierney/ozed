library(tidyverse)
library(here)
library(readxl)
library(naniar)
library(visdat)
library(janitor)

source("R/read_raw_education_data.R")
raw_data_2014 <- read_raw_education_data(year = "2014")

source("R/prepare_education.R")
educated_2014 <- prepare_education(raw_data_2014)

source("R/prepare_population.R")
population_2014 <- prepare_population(raw_data_2014)

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
