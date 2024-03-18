pivot_longer_educated <- function(educated_raw) {

  pivot_longer(
    data = educated_raw,
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
    ) %>% 
    # remove larger 15_24/64/74 age bands
    filter(
      age_group != "15_24",
      age_group != "15_64",
      age_group != "15_74",
      age_group != "18_24",
      age_group != "25_64"
    )
  

}
