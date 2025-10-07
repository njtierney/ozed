source("packages.R")
## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

educated_population_2014 <- read_educated_population(year = "2014")

ggplot(educated_population_2014, aes(x = prop_studying, y = state_territory)) +
  geom_col() +
  facet_wrap(~age_group)
