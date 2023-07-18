library(dplyr)

## Compare the mass of male and female human star wars characters
## null: Average mass of male and female characters is the same.
## alt: One of the characters weighs more, or averages are diff.

swHumans <- starwars |>
  filter(species == "Human", mass > 0)

swMales <- swHumans |>
  filter(sex == "male")

swFemales <- swHumans |>
  filter(sex == "female") 

t.test(swMales$mass, swFemales$mass, paired = F, alternative = "two.sided")

##ANOVA

anova_results <- aov(data = iris, Sepal.Length ~ Species)
summary(anova_results)

TukeyHSD(anova_results)
#?TukeyHSD

sigwid <- aov(data = iris, Sepal.Width ~ Species)
summary(sigwid)

TukeyHSD(sigwid)

## Starwars
head(starwars)
unique(starwars$species)

##which 5 species are the most common 
top5spec <- starwars |>
  summarize(.by = species,
            count = sum(!is.na(species))) |>
  slice_max(count, n = 3)
top5spec