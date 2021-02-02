## Script to create Figure 1 in manuscript

fig1 <- read_csv("data/fig1_count-data.csv")
forcats::as_factor(fig1$year)

fig1_plot <- ggplot2::ggplot(fig1, x = year, y = count) +
  geom_segment(aes(x = year, xend = year, y = 0, yend = count),
               color = "#666666") +
  geom_point(aes(x = year, y = count), color = "#18abf5", size = 3) +
  scale_x_discrete(limits = fig1$year) +
  coord_cartesian(ylim = c(0, 10)) +
  scale_y_continuous(breaks = seq(0, 10, 2)) +
  xlab("Year") +
  ylab("Number of Experiments")
fig1_plot

fig1_plot +
  theme_bw() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    # axis.title.x = element_text(face = "bold"),
    # axis.title.y = element_text(face = "bold")
  )
