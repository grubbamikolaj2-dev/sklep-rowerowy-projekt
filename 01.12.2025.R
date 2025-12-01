library(psych)
raport <-
  list("Wysokość zarobków" =
         list("Min"= ~ min(income),
              "Max"= ~ max(income),
              "Kwartyl dolny"= ~ quantile(income,0.25),
              "Mediana"= ~ round(median(income),2),
              "Kwartyl górny"= ~ quantile(income,0.75),
              "Średnia"= ~ round(mean(income),2),
              "Odch. std."= ~ round(sd(income),2),
              "IQR"= ~ round(iqr(income),2),
              "Odchylenie ćwiartkowe"=~round(iqr(income)/2,2),
              "Odch. std. w %"=~round((sd(income)/mean(income)),2),
              "Odch. ćwiartkowe w %"=~round((iqr(income)/median(income)),2),
              "Skośność"=~round(skew(income),2),
              "Kurtoza"=~round(kurtosi(income),2)
         ))
tabela<-summary.table(raport)



#income zrobić w przedziałach i ile było tak i ile nie w przedziale