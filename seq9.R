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


# Exercices ------------------------------------

library(readr)
poplegale_6815 <- read_delim("poplegale_6815.csv",delim=" "
                             ,col_types=cols(
                               DC = col_character(),
                               NCC = col_character(),
                               PMUN15 = col_double(),
                               PMUN10 = col_double(),
                               PMUN06 = col_double(),
                               PSDC99 = col_double(),
                               PSDC90 = col_double(),
                               PSDC82 = col_double(),
                               PSDC75 = col_double(),
                               PSDC68 = col_double()
                             )) %>% mutate_at(vars(matches("^P")),as.integer)
head(poplegale_6815)


poplegale_6815_bis <- read.csv("poplegale_6815.csv", encoding="UTF-8", sep="")
head(poplegale_6815_bis)