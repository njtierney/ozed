source("packages.R")
## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

raw_data_2014 <- read_raw_education_data(year = "2014")

educated_2014 <- prepare_education(raw_data_2014)

population_2014 <- prepare_population(raw_data_2014)

# combine the data
educated_population_2014 <- combine_educated_population(
  education = educated_2014,
  population = population_2014,
  year = 2014
)

educated_population_2014

ggplot(educated_population_2014,
       aes(x = prop_studying,
           y = state_territory)) + 
  geom_col() + 
  facet_wrap(~age_group)


