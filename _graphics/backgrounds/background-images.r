library(tidyverse)
library (ambient)

theme_void() %+replace% theme(
  legend.position="none",
  panel.background = element_rect(fill="#000000"),
  plot.margin=unit(c(-0.5, -1, -0.5, -1), 'cm')
) -> th

render <- function(par, save = FALSE) {
  set.seed(par$seed)
  
  dots <- tibble()
  
  for (i in 1:par$lines) {
    line <- tibble(
      row = i,
      x = runif(n = par$dots_per_line, min = -pi, max = pi),
      y = sin(x)
    )
    
    bind_rows(dots, line) -> dots
  }
  
  dots %>% mutate(
    y = y * par$line_wave + row * sin(x/2 + pi/2) * par$envelope_wave
  ) -> dots
  
  curl_noise <- curl_noise(
    generator = gen_simplex,
    seed = par$seed,
    frequency = par$curl_freq,
    x = dots$x,
    y = dots$y
  )
  
  dots %>% mutate(
    x = x + curl_noise$x * par$curl_x * y,
    y = y + curl_noise$y * par$curl_y * y
  ) -> dots
  
  dots %>%
    ggplot(aes(x = x, y = y)) +
    geom_point(color = "white", shape = ".", alpha = 0.4) +
    xlim(min(dots$x) - par$padding, max(dots$x) + par$padding) +
    ylim(min(dots$y) - par$padding, max(dots$y) + par$padding) +
    th -> plot
  
  if (save) {
    ggsave(
      filename = paste0("lines-", par$seed, ".jpg"),
      path = "render",
      plot = plot,
      width = 3840,
      height = 2160,
      units = "px"
    )
  }
}

for(s in c(7, 21)) {
  render(list(
    seed = s,
    lines = 36,
    dots_per_line = 1500,
    line_wave = 0.5,
    envelope_wave = 0.1,
    curl_freq = 0.3,
    curl_x = 0.5,
    curl_y = 0.8,
    padding = 1,
    xlim = c(-5, 5),
    ylim = c(-2, 4)
  ), save = TRUE)
}