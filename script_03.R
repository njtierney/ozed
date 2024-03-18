source("packages.R")
## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

study_years <- as.character(2014:2023)
educated_population <- map_dfr(.x = study_years,
                               .f = \(x) read_educated_population(x))

educated_population

ggplot(educated_population_2014,
       aes(x = prop_studying,
           y = state_territory)) + 
  geom_col() + 
  facet_wrap(~age_group)

ggplot(educated_population,
       aes(x = year,
           y = state_territory)) + 
  geom_col() + 
  facet_wrap(~age_group)


