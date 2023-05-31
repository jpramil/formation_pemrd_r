# Statistiques par groupe de modalités : group_by

naissances %>% count(indnatm)

# ou : 
naissances %>%
  group_by(indnatm) %>%
  mutate(agemere=as.integer(agemere)) %>%
  summarise(moyenne=mean(agemere), et=sd(agemere))

# La fonction group_by

naissances %>%
  group_by(substring(agemere,1,1)) %>%
  summarise(n=n())

# group_by et filter

p <- rio::import(file.path(chemin,"poplegale_6815d.RDS"))
p %>%
  group_by(d) %>%
  filter( PMUN15==max(PMUN15) )

# group_by et mutate

p %>% group_by(d) %>%
  mutate(PMUN15tot=sum(PMUN15,na.rm=TRUE))

# Trier : arrange

naissances %>%
  group_by(indnatm,indnatp) %>%
  summarise(nb=n()) %>%
  arrange( desc(nb) )  

# Accéder à une ligne d'un groupe par sa position : row_number

p %>% group_by(d) %>%
  arrange(desc(PMUN15)) %>%
  filter(row_number()==1)

# La fonction ungroup

naissances %>%
  group_by(indnatm,indnatp) %>%
  summarise(n=n())

naissances %>%
  group_by(indnatm,indnatp) %>%
  summarise(n=n()) %>%
  ungroup() -> comptages # Le résultat est « comptages », sans index

# Exercices ---------------------------------------------------

naissances %>%
  group_by(depnais)%>%
  summarise(nombre_naissance=n(),age_moyen_mere=mean(as.numeric(agemere)))%>%
  head(5) # 5 premiers résultats

 naissances %>% 
  group_by(depnais) %>% summarise(n=n()) %>%
  filter(n==max(n))
 
naissances %>%
  group_by(depnais) %>%
  mutate(nombre_naissance_dep=n())%>%
  group_by(depnais,sexe,nombre_naissance_dep)%>%
  summarise(nombre_naissance_sexe=n())%>%
  mutate(ratio=nombre_naissance_sexe/nombre_naissance_dep)%>%
  ungroup()%>% # faire le test sans cette ligne pour montrer importance d'enlever le group_by
  filter(ratio==max(ratio))
 


