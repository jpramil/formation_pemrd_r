superheros <- read.table(
  h = TRUE,
  text =
    " nom type sexe editeur
      Magneto mechant homme Marvel
      Storm gentil femme Marvel
      Mystique mechant femme Marvel
      Batman gentil homme DC
      Joker mechant homme DC
      Catwoman mechant femme DC
      Hellboy gentil homme 'Dark Horse Comics'"
)

editeurs <- read.table(
  h = TRUE,
  text =
    "editeur annee_creation fondateur
     DC 1934 'Malcolm Wheeler-Nicholson'
     Marvel 1939 'Martin Goodman'
     Image 1992 NA"
)

library(dplyr)
inner_join(superheros,editeurs)
inner_join(superheros,editeurs,by="editeur")
left_join(superheros,editeurs)
full_join(superheros,editeurs)
anti_join(superheros,editeurs)
library(tidyr)
superheros2 <- superheros %>% select(-editeur)
crossing(superheros2,editeurs) %>% View()



# Exercice ----------------------------------------------------------------

chemin <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"
chemin_cc <- file.path(chemin, "base_cc_comparateur.xlsx")

# Importation d'un xlsx
base_cc <- rio::import(chemin_cc, skip = 5, sheet = "COM")

chemin_reg <- file.path(chemin, "reg2014.dbf")
base_reg <- rio::import(chemin_reg)

recap_cc <-
  base_cc %>%
  group_by(REG) %>%
  summarise(naiss = sum(NAISD20),
            deces = sum(DECESD20))

full <- recap_cc %>%
  full_join(base_reg, by = c("REG" = "REGION"))
View(full)

# Codes des nouvelles régions
anti <- recap_cc %>%
  anti_join(base_reg, by = c("REG" = "REGION")) 
View(anti)

nouvelles_reg <- anti$REG  

semi <- recap_cc %>%
  semi_join(base_reg, by = c("REG" = "REGION")) 

reg_persist <- semi$REG

tab_anciennes_reg <- full %>% 
  filter(!REG %in% c(reg_persist,nouvelles_reg))




# Fuzzyjoin -------------------------------------------------------------------


textes <- data.frame(
  texte = stringr::str_split(
    " Ce qui précède comporte une grave restriction :
l'appariement ne peut se faire que sur égalité de colonnes
Si on veut quelque chose de plus général pour des cas plus spécifiques
il faut se tourner vers d'autres packages
dont le package **fuzzyjoin** qui va être illustré sur un exemple particulier,
mais qui offre de nombreuses autres possibilités.",
    '\n'
  )[[1]]
)
exprs <- data.frame(expr=c("\\bcolonnes?\\b","\\bpackages?\\b"))

install.packages("fuzzyjoin")
library(fuzzyjoin)
library(stringr)

fuzzy_inner_join(textes, exprs, by=c("texte"="expr"), match_fun=str_detect)

library(tidyr)
crossing(textes,exprs) %>% filter(str_detect(texte,expr))



# bind_rows

a <- mtcars %>% filter(cyl==6) %>% select(hp,gear)
b <- mtcars %>% filter(cyl==8)
a %>% bind_rows(b)

# bind_cols

c <- data.frame(alea=runif(nrow(b),1,10))
b %>% bind_cols(c)
