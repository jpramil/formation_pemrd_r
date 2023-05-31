library(tidyverse)

# Fonctions count, summarise ----------------------

naissances %>% count()

naissances %>% 
  summarise (comptage=n())

# Premières statistiques : distributions

naissances %>%
  summarise(q1_mere = quantile(as.numeric(agemere), 0.25),
            mediane_mere = median(as.numeric(agemere)),
            q3_mere = quantile(as.numeric(agemere), 0.75))

naissances %>%
  summarise(min_mere = min(as.numeric(agemere)),
            max_mere = max(as.numeric(agemere)))

# Premières statistiques : comptages (1/2)

naissances %>%
  summarise( jumeaux=sum( nbenf=="2" ) )

naissances %>%
  summarise( jumeaux=sum( nbenf="2" ) ) # test ne fonctionnant pas

# Premières statistiques : comptages (2/2)

naissances %>%
  count(nbenf)

# Les statistiques pondérées : Le package Hmisc

# Construction du jeu d’essai 5 lignes et 2 colonnes (age, poids)
# data.frame : fabrication d’un data frame
# c : construction d’un vecteur
df <- data.frame(age=c(20,30,40,50,60), poids=c(1,1,1,1,3))

install.packages("Hmisc")
library(Hmisc)

df %>% summarise(quartile1=wtd.quantile(age,w=poids,probs=.25),
                 mediane=wtd.quantile(age,w=poids,probs=.5),
                 moyenne=wtd.mean(age,w=poids))

# la fonction filter

naissances %>%
  filter((depnais == '86') & (indnatm == '1')) %>%
  summarise(nombre_naissances_vienne = n())

naissances %>%
  filter(depnais %in% c('79','85','86'))


# Exercices ---------------------------------------

naissances %>%
  filter((depnais=="14")
         &(as.numeric(agemere)>40)
         &(amar=="0000")
         &(sexe=="2")) %>% count()

naissances %>%
  filter(((depnais=="16")|(depnais=="18"))
         &(as.numeric(agemere)>40)
         &(amar=="0000")
         &(sexe=="2")) %>% count()
