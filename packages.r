#install.packages("pacman")

pacman::p_load(rvest, XML, RJSONIO, tidyverse, janitor)
url <- "https://en.wikipedia.org/wiki/World_population"

## Paragraphs ------------------
read_html(url) |> 
  html_nodes("p") |>
  html_text()

## Hyperlinks -----------------------------------------
read_html(url) |> 
  html_nodes("a")

## Tables ---------------------------------------------
read_html(url) |> 
  html_nodes("table")

ten_most_populous <- read_html(url) |> 
  html_nodes("table") %>%
  `[[`(5) |> 
  html_table()

ten_most_populous |> 
  clean_names()
