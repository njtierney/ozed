source("packages.R")
## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

study_years <- as.character(2014:2023)
year_label <- paste0("education_", study_years)
educated_population <- map(
  .x = study_years,
  .f = \(x) read_educated_population(x)
) |>
  setNames(year_label)

educated_names <- file.path(
  "data",
  "messy",
  paste0(names(educated_population), ".csv")
)

walk2(educated_population, educated_names, \(x, y) write_csv(x, file = y))

dirty_up_data <- function(
  education_data,
  age_sep = c("-", "--", "---"),
  missing_rep = -99
) {
  education_data |>
    mutate(
      age_group = str_replace_all(
        age_group,
        "_",
        sample(x = age_sep, size = n(), replace = TRUE)
      ),
      prop_studying = set_prop_miss(prop_studying, 0.1),
      prop_studying = replace_na_with(prop_studying, missing_rep)
    )
}

# now make this slightly different in terms of NAs for each of the three years
education_2014 <- read_csv("data/tidy/education_2014.csv") |>
  dirty_up_data()

education_2015 <- read_csv("data/tidy/education_2015.csv") |>
  dirty_up_data()

education_2016 <- read_csv("data/tidy/education_2016.csv") |>
  dirty_up_data()

# change the data messyness
education_2017 <- read_csv("data/tidy/education_2017.csv") |>
  dirty_up_data(age_sep = c(";", ":", "::"), missing_rep = -1)

education_2018 <- read_csv("data/tidy/education_2018.csv") |>
  dirty_up_data(age_sep = c(".", ".."), missing_rep = 9999)

education_2019 <- read_csv("data/tidy/education_2019.csv") |>
  dirty_up_data(age_sep = c("|", "||"), missing_rep = Inf)

# write the data out

write_raw_education <- function(data, year) {
  csv_path <- file.path("data", "raw", paste0("raw_education_", year, ".csv"))
  write_csv(data, csv_path)
}

write_raw_education(education_2014, 2014)
write_raw_education(education_2015, 2015)
write_raw_education(education_2016, 2016)
write_raw_education(education_2017, 2017)
write_raw_education(education_2018, 2018)
write_raw_education(education_2019, 2019)
