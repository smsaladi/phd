# Preface {.unnumbered .unlisted}

## Dedication {.unnumbered .unlisted}

## Acknowledgements {.unnumbered .unlisted}

"On the shoulders of giants"

## Land Acknowledgement {.unnumbered .unlisted}

## Colophon {.unnumbered .unlisted}

<!-- from Mastering Shiny: https://github.com/hadley/mastering-shiny/blob/master/introduction.Rmd#L174-L207 -->

This book was written in [RStudio](http://www.rstudio.com/ide/) using [bookdown](http://bookdown.org/).
The [website](http://shyam-saladi.org/phd) is hosted with [Github Pages](https://pages.github.com), and automatically updated after every commit by [Github Actions](https://github.com/features/actions).
The complete source is available from [GitHub](https://github.com/smsaladi/phd).

This version of the book was built with `r R.version.string` and the following packages:

```{r, echo = FALSE, include=FALSE}
library(tidyverse)
ruler <- function(width = getOption("width")) {
  x <- seq_len(width)
  y <- dplyr::case_when(
    x %% 10 == 0 ~ as.character((x %/% 10) %% 10),
    x %% 5 == 0  ~ "+",
    TRUE         ~ "-"
  )
  cat(y, "\n", sep = "")
  cat(x %% 10, "\n", sep = "")
}
```

```{r, echo = FALSE, results="asis"}
library(tidyverse)

deps <- desc::desc_get_deps()
pkgs <- sort(deps$package[deps$type == "Imports"])

pkgs <- sessioninfo::package_info(pkgs, dependencies = FALSE)
df <- tibble(
  package = pkgs$package,
  version = pkgs$ondiskversion,
  source = gsub("@", "\\\\@", pkgs$source)
)
knitr::kable(df, format = "markdown")
```

```{r, include = FALSE}
ruler()
```
