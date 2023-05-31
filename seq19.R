## Diapos ----

SEP <- "\\.," # Le séparateur
v <- readLines(file.path(chemin,"mtcars1.csv"))
v[-1] %>% # On saute la ligne d'en-tête
  data.frame(X=., # Texte de la ligne
             ID=1:length(.), # Numéro de la ligne
             stringsAsFactors=FALSE) %>%
  mutate(W=str_split(X,SEP)) %>% # La colonne W est du type liste
  unnest(W) %>% # Une ligne par élément de W
  group_by(ID) %>% mutate(V=row_number()) %>% # Chaque ligne concerne un champ
  spread(V,W) %>% # Chaque ligne comporte tous les champs
  ungroup () %>% select(-ID) %>% # ID ne sert plus à rien
  {names(.)<- str_split(v[1],SEP)[[1]]; .} # Les noms des champs étaient en tête
