source("packages.r")

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

ten_most_populous <- ten_most_populous |> 
  clean_names() |> 
  select(c(1, 2, 4)) |> 
  set_names("country", "population", "date")

ten_most_populous |> 
  mutate(
    population = parse_number(population)
  ) |> 
  ggplot(
    aes(population, fct_reorder(country, population))
  ) +
  geom_col(
    width = .05,
    fill = "#0EA52F"
  ) +
  geom_point(
    col = "#20562C",
    size = 3
  ) +
  geom_label_repel(
    aes(label = paste0(round(population/1e6, 1), "Million")),
    col = "#20562C",
    fill = "white",
  ) +
  labs(
    x = NULL,
    y = "Country",
    title = "Top Populated Countries"
  ) +
  theme_clean() +
  theme(
    axis.ticks.x = element_blank(),
    axis.text.x = element_blank(),
    axis.line.x = element_blank(),
    plot.title = element_text(hjust = .4, colour = "#17682F")
  )


## Bitcoin Prices
bc <- read_html("https://coinmarketcap.com/all/views/all/")
bc <- bc |> 
  html_nodes("table") |> 
  html_table()

bc <- bc[[3]]

bc <- bc |> 
  clean_names() |> 
  select(c(2:5))

bc |> 
  mutate(
    price = parse_number(price),
    market_cap = str_remove(market_cap, "\\$[0-9].[A-Z]")
  )
