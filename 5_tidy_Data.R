#install.packages("tidyr")
#install.packages("janitor")
#install.packages("dplyr")

library(tidyr)
library(janitor)
library(dplyr)

starwars
clean_names(starwars, case = "small_camel")
clean_names(starwars, case = "screaming_snake")
new_starwars <- clean_names(starwars, case = "upper_lower")

clean_names(new_starwars)

starwarswomen <- select(arrange(filter(starwars, sex == "female"), birth_year), name, species)
starwarswomen <- starwars |>
  filter(sex == "female") |>
  arrange(birth_year) |>
  select(name, species)
starwarswomen

slice_max(starwars, height, n = 1, by = species, with_ties = F)

table4a

tidy4a <- pivot_longer(table4a,
             cols = c("1999", "2000"),
             names_to = "year",
             values_to = "cases")
table4b
tidy4b <- pivot_longer(table4b,
             cols = c("1999", "2000"),
             names_to = "year",
             values_to = "population")

table2

pivot_wider(table2,
            names_from = type,
            values_from = count)

table3

separate(table3,
         rate, 
         into = c("cases", "population"),
         sep = "/")

table5
tidy_table5 <- unite(table5,
      c("century", "year"),
      sep = "") |>
  separate(rate,
           into = c("cases", "population"),
           sep = "/")

new_data <- data.frame(country = "USA", year = "1999", cases = "1024", population = "200000000")
bind_rows(tidy_table5, new_data)
