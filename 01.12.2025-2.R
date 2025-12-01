
library(readr)
library(dplyr)
library(tidyr)
library(kableExtra)



# Wybieram zmienne jakościowe
dane_cat <- dane2 %>% select(where(~ is.character(.x) || is.factor(.x)))

#  Obliczenie częstości i procentów — wszystko w jednej pętli
wynik <- data.frame()

for (colname in names(dane_cat)) {
  
  # tabela częstości
  t <- as.data.frame(table(dane_cat[[colname]], useNA = "ifany"))
  colnames(t) <- c("kategoria", "liczba")
  
  # dodanie procentów
  t$procent <- round(100 * t$liczba / sum(t$liczba), 2)
  
  # dodanie nazwy zmiennej
  t$zmienna <- colname
  
  # łączenie wyników
  wynik <- rbind(wynik, t)
}

#  Uporządkowanie kolumn
wynik <- wynik %>% select(zmienna, kategoria, liczba, procent)

#  Tabela kableExtra
wynik %>%
  kable("html",
        caption = "Statystyki opisowe dla zmiennych jakościowych (częstości)",
        digits = 2) %>%
  kable_styling(
    bootstrap_options = c("striped", "hover", "condensed"),
    full_width = FALSE,
    position = "center"
  ) %>%
  scroll_box(height = "500px")
