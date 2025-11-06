install.packages("visdat")

library(visdat)
library(naniar)
library(ggplot2)
wykres1 <- vis_dat(dane) +
  theme(axis.text.x = element_text(hjust = 1),margin = margin(t = 10))+
  ggtitle("Wizualizacja danych z użyciem visdat") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
wykres1
wykres2 <- vis_miss(dane)+
  theme(axis.text.x = element_text(hjust = 1),margin = margin(t = 10))+
  ggtitle("Liczba brakujących wartości w zmiennych") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
wykres2
