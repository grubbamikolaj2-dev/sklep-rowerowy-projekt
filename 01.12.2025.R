library(psych)
raport <-
  list("Cena w PLN" =
         list("Min"= ~ min(price_PLN),
              "Max"= ~ max(price_PLN),
              "Kwartyl dolny"= ~ quantile(price_PLN,0.25),
              "Mediana"= ~ round(median(price_PLN),2),
              "Kwartyl górny"= ~ quantile(price_PLN,0.75),
              "Średnia"= ~ round(mean(price_PLN),2),
              "Odch. std."= ~ round(sd(price_PLN),2),
              "IQR"= ~ round(iqr(price_PLN),2),
              "Odchylenie ćwiartkowe"=~round(iqr(price_PLN)/2,2),
              "Odch. std. w %"=~round((sd(price_PLN)/mean(price_PLN)),2),
              "Odch. ćwiartkowe w %"=~round((iqr(price_PLN)/median(price_PLN)),2),
              "Skośność"=~round(skew(price_PLN),2),
              "Kurtoza"=~round(kurtosi(price_PLN),2)
         ))
tabela<-summary_table(mieszkania, summaries = raport, by = c("rooms"))

knitr::kable(tabela,
             digits = 2,
             align = "lcccc",
             caption="Tabela 1. Mieszkania we Wrocławiu - ceny w PLN wg liczby pokoi.",
             col.names = c("Statystyka","1 pokój", "2 pokoje", "3 pokoje", "4 pokoje")) 

#income zrobić w przedziałach i ile było tak i ile nie w przedziale