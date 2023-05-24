# Fonctions count, summarise ----------------------

naissances %>% count()

naissances %>% 

tab_naissances %>%
  filter((depnais=="86")
         &(agemere>40)
         &(amar=="0000")
         &(sexe=="2")) %>% count()

tab_naissances %>%
  filter(((depnais=="16")|(depnais=="18"))
         &(agemere>40)
         &(amar=="0000")
         &(sexe=="2")) %>% count()