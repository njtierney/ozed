# load packages for data analysis
library(tidyverse)
library(here)
library(readxl)
library(naniar)
library(visdat)
library(janitor)

# Read in the raw data
raw_data <- read_excel(
  path = "data/Education and work, 2023, Datacube 2 (Table 11).xlsx",
  sheet = "2014", 
  skip = 4, 
  n_max = 32,
  # use janitor::make_clean_names to turn `15-19-years` to "x15_19_years"
  .name_repair = make_clean_names
)

# clean up the silly names from excel
names(raw_data)
new_data_names_raw <- names(raw_data)
new_data_names_raw[1] <- "state_territory"
new_data_names <- new_data_names_raw

# subset the data down to the number of educated people section
raw_data
educated_2014_raw <- raw_data %>% 
  slice(4:11) %>% 
  set_names(new_data_names)

educated_2014_raw
educated_2014 <- educated_2014_raw %>% 
  pivot_longer(
    cols = -state_territory,
    names_to = "age_group",
    names_prefix = "x",
    names_pattern = "(.*)_years",
    values_to = "n_studying",
    values_transform = as.numeric
  ) %>% 
  arrange(
    state_territory,
    age_group
  )
  # remove larger 15_24/64/74 age bands
  filter(
      age_group != "15_24",
      age_group != "15_64",
      age_group != "15_74",
      age_group != "18_24",
      age_group != "25_64"
  )

# Population in age groups
population_2014_raw <- raw_data %>% 
  slice(24:31) %>% 
  set_names(new_data_names)

population_2014 <- population_raw %>% 
  pivot_longer(
    cols = -state_territory,
    names_to = "age_group",
    names_prefix = "x",
    names_pattern = "(.*)_years",
    values_to = "population",
    values_transform = as.numeric
  ) %>% 
  arrange(
    state_territory,
    age_group
  ) %>% 
  # remove larger 15_24/64/74 age bands
  filter(
    age_group != "15_24",
    age_group != "15_64",
    age_group != "15_74",
    age_group != "18_24"
    age_group != "25_64"
  )

# combine the data
# I guess it's only a study rather than the true numbers?
educated_population_2014 <- educated_2014 %>% 
  left_join(population_2014,
            by = c("state_territory", "age_group")) %>% 
  mutate(
    age_group = as_factor(age_group),
    prop_studying = n_studying/population,
    year = 2014
  ) %>% 
  relocate(
    year
  )

educated_population_2014

ggplot(educated_population_2014,
       aes(x = prop_studying,
           y = state_territory)) + 
  geom_col() + 
  facet_wrap(~age_group)
