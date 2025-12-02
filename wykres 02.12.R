
dane2$income_bin <- cut(dane2$income, 
                        breaks = seq(0, 180000, by = 20000), 
                        dig.lab = 10,
                        include.lowest = TRUE)


ggplot(dane2, aes(x = income_bin, fill = purchased_bike)) +
  geom_bar(position = "dodge", color = "white") + 
  scale_fill_manual(values = c("No" = "#E15759", "Yes" = "#76B7B2")) +
  labs(
    title = "Liczba zakupionych rowerów w zależności od przedziału zarobków",
    subtitle = "Rozkład decyzji zakupowych w grupach dochodowych",
    x = "Przedział zarobków (Income)",
    y = "Liczba klientów (Ilość)",
    fill = "Czy kupił rower?") +
  theme_minimal() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  )