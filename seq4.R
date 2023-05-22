naissances
naissances <- dplyr::as_tibble(naissances)
naissances

# Mutate 

naissances2 <- naissances %>% mutate(age2 = as.integer(agemere))
naissances2 %>% select(agemere, age2)

naissances2 <- naissances %>% 
  mutate(agemere_0 = agemere) %>% 
  mutate(agemere = as.integer(agemere))
naissances2 %>% select(agemere_0, agemere)

# ifelse

naissances %>% 
  mutate(sexe = ifelse(sexe == 1, yes = "garçon", no = "fille"))

# Casewhen

# Exercice ------------------------------------------------------------------

naissances %>% 
  mutate(
    tagemere = 
      case_when(
        agemere < 20 ~ "moins de 20 ans" , 
        agemere < 25  ~ "de 20 à moins de 25 ans" , 
        agemere < 35  ~ "de 25 à moins de 35 ans" ,
        T ~ "35 ans et plus"
      )
  ) -> toto

toto %>% select(agemere, tagemere)
toto %>% count(tagemere)

# is.na -------------------------------------------------------------------------

is.na(c("Marie","Yves",NA,"Jeanne"))

naissances %>%
  mutate(sexe = ifelse(sexe == '1',"garçon","fille")) %>% 
  filter(is.na(sexe))

enquete <- rio::import(file.path(chemin, "enquete.RDS"))
enquete %>% filter(is.na(Sexe))







