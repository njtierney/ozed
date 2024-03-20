library(tidyverse)
library(here)
library(readxl)
library(naniar)
library(visdat)
library(janitor)
## Load your R files
source("R/combine_educated_population.R")
source("R/extract_education_col_names.R")
source("R/extract_rows_set_names.R")
source("R/pivot_longer_educated.R")
source("R/pivot_longer_population.R")
source("R/prepare_education.R")
source("R/prepare_population.R")
source("R/read_educated_population.R")
source("R/read_raw_education_data.R")

educated_population_2014 <- read_educated_population(year = "2014")

ggplot(educated_population_2014,
       aes(x = prop_studying,
           y = state_territory)) + 
  geom_col() + 
  facet_wrap(~age_group)


