# R coeur ---------------------------------------------------------------

str(naissances)
head(naissances)
head(naissances,n = 10)
tail(naissances)
tail(naissances,n = 1)

# dplyr -----------------------------------------------------------------

library(dplyr)
slice(naissances, 10:20)
select(naissances, agemere, agepere)
select(slice(naissances, 10:20), agemere, agepere)
summarise(naissances, 
          mean(as.numeric(agemere))
          )

# Pipe
naissances %>% slice(10:20) %>% select(agemere, agepere)

# distinct
naissances %>% distinct(indnatm)
naissances %>% distinct(indnatm, indnatp)

# Exercice -------------------------------------------------------------

tail(head(naissances, 11), 1)
naissances %>% head(11) %>% tail(1)
naissances %>% head(11) %>% tail(1) %>% select(amar)
naissances %>% distinct(agemere) %>% head(3)


base_cc_comparateur <- rio::import(file.path(bucket,"base_cc_comparateur.xlsx"),as.is=TRUE)