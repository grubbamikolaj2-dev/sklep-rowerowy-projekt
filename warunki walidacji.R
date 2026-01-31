###Warunki walidacji
#### ilościowe
cars, children, age - liczby całkowite, skokowe
children, income, cars, age, commute_distance -> >= 0
#### Jakościowe
##### binarne
home_owner - Yes, no
purchased bike <Yes, No>
martial_status <married, single>
gender <male,female>
##### Kategoryczne
education "Bachelors"           "Partial College"     "High School"         "Partial High School" "Graduate Degree" 
occupation "Skilled Manual" "Clerical"       "Professional"   "Manual"         "Management" 
region "Europe"        "Pacific"       "North America"

# Ładowanie bibliotek
library(ggplot2)
library(dplyr)
library(tidyr)

# Wczytanie danych (zakładając, że plik jest w katalogu roboczym)
df <- read.csv("czyste_dane.csv")

# Uporządkowanie kolejności zmiennej purchased_bike (żeby "Yes" było kolorem wyróżniającym)
df$purchased_bike <- factor(df$purchased_bike, levels = c("No", "Yes"))

# Ustawienie estetycznego motywu dla wszystkich wykresów
my_theme <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom"
  )

ggplot(df, aes(x = income, fill = purchased_bike)) +
  geom_density(alpha = 0.6) +
  scale_fill_manual(values = c("No" = "#999999", "Yes" = "#E69F00")) +
  labs(
    title = "Rozkład dochodu klientów w podziale na decyzję zakupową",
    subtitle = "Czy wyższy dochód zwiększa szansę na zakup?",
    x = "Roczny dochód",
    y = "Gęstość",
    fill = "Kupił rower?"
  ) +
  scale_x_continuous(labels = scales::comma) + # Formatowanie liczb
  my_theme

ggplot(df, aes(x = education, fill = purchased_bike)) +
  geom_bar(position = "fill") + # "fill" pokazuje proporcje (do 100%)
  scale_fill_manual(values = c("No" = "#999999", "Yes" = "#56B4E9")) +
  labs(
    title = "Prawdopodobieństwo zakupu roweru wg wykształcenia",
    x = "Poziom wykształcenia",
    y = "Procent klientów",
    fill = "Kupił rower?"
  ) +
  scale_y_continuous(labels = scales::percent) +
  coord_flip() + # Obrócenie dla czytelności etykiet
  my_theme