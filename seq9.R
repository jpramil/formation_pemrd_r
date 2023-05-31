# La fonction data.frame

superheros <- data.frame(
  nom=c("Magneto","Storm","Batman","Joker","Catwoman","Hellboy"),
  type=c("mechant","gentil","gentil","mechant","mechant","gentil"),
  role=c("mutant","mutante","heros","heros","heroine","heros"),
  stringsAsFactors=FALSE)

# La fonction read.table

superheros <- read.table(text=
                           " nom type role
Magneto mechant mutant
Storm gentil mutante
Batman gentil heros
Joker mechant heros
Catwoman mechant heroine
Hellboy gentil heros", header=TRUE, stringsAsFactors=FALSE)


# Exercice 9.1 ----

situat <- read.table(text=
"code,libellé
S,Salarié
NS,Non salarié
NA,Inactif
ND,Indéterminé", header=TRUE,stringsAsFactors=FALSE, sep=',', na.strings = "")


# Suite diapo ----

# Le nombre de colonnes
# Ou mieux : ncol(superheros)
length(superheros)

# Le contenu d’une colonne
superheros $ nom

# Le nombre de lignes
# Ou mieux nrow(superheros)
length(superheros $ nom)

superheros $ nom [ 3 ]

# Un exemple - Utiliser une table de nomenclature

SEXE <- read.table(header=TRUE,text=
                     "code libellé
1 garçon
2 fille")

naissances %>%
  as_tibble() %>%
  mutate(sexe2=factor(sexe,levels=SEXE$code,labels=SEXE$libellé)) %>%
  select(sexe2,everything())

# Exercices ---- 

# 9.2

head(situat)

naissances%>%
  as_tibble()%>%
  mutate(situatmr2=factor(situatmr,levels=situat$code,labels=situat$libellé))%>%
  select(situatmr,situatmr2)%>%
  group_by(situatmr,situatmr2)%>%
  summarise(nombre_naissances=n())
  
naissances%>%
  as_tibble()%>%
  mutate(situatmr1=ifelse(is.na(situatmr)==TRUE,"NA",situatmr))%>%
  mutate(situatmr2=factor(situatmr1,levels=situat$code,labels=situat$libellé))%>%
  group_by(situatmr1,situatmr2)%>%
  summarise(nombre_naissances=n())

# 9.3

table_depreg<- rio::import(file.path(chemin,"dep2017r.dbf"))%>%
  select(DEP,NCC_REG)

naissances%>%
  mutate(nom_region=factor(depnais,levels=table_depreg$DEP,labels=table_depreg$NCC_REG))%>%
  group_by(nom_region)%>%
  summarise(nombre_naissances=n())


