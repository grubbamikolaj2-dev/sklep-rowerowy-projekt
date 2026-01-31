#Dane brakujące
install.packages("naniar")
library(naniar)

n_miss(dane)
#W całej ramce danych znajduje się 31 brakujących wartości
n_complete(dane)
#Całkowita liczba kompletnych obserwacji to 12 969
prop_miss(dane)
#Proporcja braków wynosi jedynie 0.24%
pct_miss(dane)
#Najwięcej brakujących wartości jest w kolumnie Cars (9), następnie Children (8), Age (8) i Income (6). Reszta zmiennych nie ma żadnych braków

miss_var_summary(dane)
miss_case_table(dane) 
#97,1% przypadków (971 obserwacji) nie ma żadnych braków 

vis_miss(dane)
gg_miss_upset(dane)

