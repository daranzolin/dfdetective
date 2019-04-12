
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dfdetective

Column names are sometimes opaque. And sometimes there are hundreds of
them. The goal of `dfdetective` is to scour data frames when you have
only a vague idea what you’re looking for. The functions are mostly thin
wrappers around combinations of `lapply()...unique()...grep()`.

## Installation

You can install the released version of dfdetective from GitHub via:

``` r
remotes::install_github("daranzolin/dfdetective")
```

### Example A: You want to search all rows to match a pattern.

``` r
library(dfdetective)
library(fivethirtyeight)
library(dplyr)

find_unique_vals(antiquities_act, "chaco")
#> # A tibble: 3 x 3
#>   col_name    unique_values                                 n_unique_values
#>   <chr>       <chr>                                                   <int>
#> 1 current_na… Devils Tower National Monument, El Morro Nat…             151
#> 2 original_n… "NA, Petrified Forest National Monument, Cha…              67
#> 3 action      Established, Enlarged, Deleted, Diminished, …              62

agencies <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-15/agencies.csv")
find_unique_vals(agencies, "^B$")
#> # A tibble: 1 x 3
#>   col_name unique_values n_unique_values
#>   <chr>    <chr>                   <int>
#> 1 class    D, C, B                     3
```

### Example B: You want to find columns with n unique variables

This is especially useful when searching for binary
variables.

``` r
find_n_unique_vals(comic_characters, 2:4) # You can pass a numeric vector to the n_unique argument
#> # A tibble: 3 x 3
#>   col_name  unique_values                                   n_unique_values
#>   <chr>     <chr>                                                     <int>
#> 1 publisher Marvel, DC                                                    2
#> 2 align     Good Characters, NA, Bad Characters, Reformed …               4
#> 3 alive     Living Characters, Deceased Characters, NA                    3
```

### Example C: You know the column names and you want to check the unique values

``` r
get_unique_vals(san_andreas, contains("worry")) #you can pass classic dplyr select helpers, e.g. starts_with(), contains(), etc.
#> # A tibble: 2 x 3
#>   col_name    unique_values                                 n_unique_values
#>   <chr>       <chr>                                                   <int>
#> 1 worry_gene… Not at all worried, Somewhat worried, Not so…               5
#> 2 worry_bigo… Not so worried, Very worried, Somewhat worri…               5
```
