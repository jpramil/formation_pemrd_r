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



# Suite diapo ----



# Exercices ---- 
