library(usethis)
library(credentials)
## set your name and email
usethis::use_git_config(user.name = "Shreyank Gupta",
                        user.email = "shreyank0108@outlook.com")

## create a personal access token for auth
#usethis::create_github_token()

credentials::set_github_pat("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")