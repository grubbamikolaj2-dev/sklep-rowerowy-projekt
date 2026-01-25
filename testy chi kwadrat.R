library(dplyr)
library(broom)
library(knitr)
library(kableExtra)
library(purrr) # Do łatwego iterowania (mapowania)

# 1. Lista zmiennych kategorialnych, które chcemy sprawdzić
zmienne_do_analizy <- c("region", "home_owner", "gender", "marital_status", 
                        "education", "occupation", "commute_distance")

# 2. Funkcja wykonująca test i czyszcząca wynik dla jednej zmiennej
oblicz_chi <- function(zmienna, dane) {
  # Tworzymy tabelę krzyżową
  tabela <- table(dane[[zmienna]], dane$purchased_bike)
  
  # Liczymy test
  test <- chisq.test(tabela)
  
  # Zamieniamy na ładny format i dodajemy nazwę zmiennej
  tidy(test) %>%
    mutate(Cecha = zmienna) %>%
    select(Cecha, statistic, parameter, p.value)
}

# 3. Wykonanie pętli po wszystkich zmiennych i połączenie wyników
wyniki_zbiorcze <- map_df(zmienne_do_analizy, oblicz_chi, dane = dane2)

# 4. Formatowanie tabeli końcowej
wyniki_zbiorcze %>%
  # Dodajemy interpretację gwiazdkową (opcjonalnie)
  mutate(Istotnosc = case_when(
    p.value < 0.001 ~ "***",
    p.value < 0.01  ~ "**",
    p.value < 0.05  ~ "*",
    TRUE ~ "brak"
  )) %>%
  # Formatowanie p-value na ładny tekst (np. <0.001)
  mutate(p.value = format.pval(p.value, digits = 3, eps = 0.001)) %>%
  # Tworzenie tabeli
  kable(
    col.names = c("Badana Cecha", "Chi-kwadrat", "Stopnie swobody (df)", "P-value", "Istotność"),
    digits = 2,
    escape = FALSE, # Ważne dla kolorowania cell_spec
    caption = "Ranking czynników wpływających na zakup roweru (Test niezależności Chi-kwadrat)"
  ) %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = F) %>%
  column_spec(1, bold = TRUE) # Pogrubienie nazw zmiennych