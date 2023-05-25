chemin <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"
chemin_enquete <- file.path(chemin, "enquete.RDS")
enquete <- rio::import(chemin_enquete)


a <- enquete %>%
  mutate(
    Sexe = factor(
      Sexe,
      levels = c("H", "F"),
      labels = c("Homme", "Femme")
    ),
    Actif = factor(
      Actif,
      levels = c(TRUE, FALSE),
      labels = c("OUI", "NON")
    )
  ) %>%
  group_by(Actif, Sexe) %>%
  summarise(n = n())

a %>%
  spread(key = Sexe, value = n) %>%
  mutate(total = sum(Homme,Femme,na.rm=TRUE)) %>%
  mutate(part_femmes = round(Femme / total * 100, 1)) %>%
  arrange(desc(part_femmes))

# Exercice --------------------------------------------------------------------

chemin_poplegale <- file.path(chemin, "poplegale_6815b.sas7bdat")
p <- rio::import(chemin_poplegale) 

p %>%
  pivot_longer(
    cols = matches('PSDC|PMUN') ,
    names_to = "millesime",
    values_to = "pop"
  ) %>%
  group_by(DC) %>%
  filter(pop == max(pop)) %>% 
  mutate(annee = str_replace(millesime, 'PMUN', '20'),
         annee = str_replace(annee, 'PSDC', '19'),
         annee = as.numeric(annee)
         ) %>%
  dplyr::slice_sample(n=100) %>% 
  View()



# Exercice complémentaire --------------------------------------------------------

tab <- data.frame(
  dim = c("x", "y"),
  a = c(1, -1),
  b = c(2, -2),
  c = c(3, -3),
  d = c(4, -4),
  e = c(5, -5),
  f = c(6, -6)
)

tab %>% 
  pivot_longer(cols = -dim, names_to = "k") %>% 
  pivot_wider(names_from = "dim")

