library(dplyr)


# 2. Przygotowanie danych (Preprocessing)
df_clean <- df %>%
  mutate(Purchased.Bike = as.factor(purchased_bike))%>%
  mutate(Education= as.factor(education))%>%
  mutate(Occupation= as.factor(occupation))

# Sprawdzenie struktury danych przed modelowaniem
str(df_clean)
table(df_clean)
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