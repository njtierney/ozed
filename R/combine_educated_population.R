combine_educated_population <- function(education, population, year = 2014) {
  education %>%
    left_join(population, by = c("state_territory", "age_group")) %>%
    mutate(
      age_group = as_factor(age_group),
      prop_studying = n_studying / population,
      year = year
    ) %>%
    relocate(
      year
    )
}
