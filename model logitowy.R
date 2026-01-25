library(dplyr)


# 2. Przygotowanie danych (Preprocessing)
df_clean <- df %>%
  mutate(Purchased.Bike = as.factor(purchased_bike))%>%
  mutate(Education= as.factor(education))%>%
  mutate(Occupation= as.factor(occupation))

# Sprawdzenie struktury danych przed modelowaniem
str(df_clean)
# 3. Budowa Modelu Logitowego
model <- glm(Purchased.Bike ~ marital_status+gender+income +children +home_owner + cars + age +Education + Occupation, data = df_clean, family = binomial(link = "logit"))

# 4. Wyświetlenie wyników modelu
summary(model)

# 5. Obliczenie Ilorazu Szans (Odds Ratios)
or <- exp(coef(model))
print("Ilorazy Szans (Odds Ratios):")
print(or)

# 6. (Opcjonalnie) Ocena jakości modelu - Tabela pomyłek (Confusion Matrix)
prob <- predict(model, type = "response")
predicted_classes <- ifelse(prob > 0.5, "Yes", "No")
table(Predicted = predicted_classes, Actual = df_clean$Purchased.Bike)


# Wymagane pakiety
library(broom)
library(dplyr)
library(knitr)
library(kableExtra)

# 1. Wyciągnięcie uporządkowanych danych z modelu

wyniki_modelu <- tidy(model, conf.int = TRUE, exponentiate = TRUE)

# 2. Filtrowanie i formatowanie tabeli
tabela_istotne <- wyniki_modelu %>%
  filter(p.value < 0.05) %>%
  filter(term != "(Intercept)") %>%
  mutate(
    OR_Formatted = round(estimate, 2), # Zaokrąglenie OR
    CI_Formatted = paste0("[", round(conf.low, 2), " - ", round(conf.high, 2), "]"), # Ładne przedziały ufności
    p_value_Formatted = format.pval(p.value, digits = 3, eps = 0.001) # Formatowanie p-value (np. <0.001)
  ) %>%
  select(term, OR_Formatted, CI_Formatted, p_value_Formatted)

# 3. Generowanie eleganckiej tabeli
kable(tabela_istotne, 
      col.names = c("Zmienna", "Iloraz Szans (OR)", "95% Przedział Ufności", "P-value"),
      align = "lccc",
      caption = "Istotne statystycznie determinanty zakupu roweru (Model Logitowy)") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = F) %>%
  column_spec(2, bold = TRUE, color = "darkblue") %>% # Wyróżnienie kolumny z OR
  footnote(general = "OR > 1 oznacza wzrost szansy na zakup, OR < 1 oznacza spadek szansy.")