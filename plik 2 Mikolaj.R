library(naniar)
podsumowanie <-kable(miss_summary(dane))
podsumowanie <- as.data.frame(podsumowanie)
