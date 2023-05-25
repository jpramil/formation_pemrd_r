library(lubridate)

serie_d_emploi <- rio::import(file.path(chemin,"Serie_d_emploi.RDS"))
serie_d_emploi <- serie_d_emploi %>% mutate(Date = ymd(Date_string))
serie_d_emploi %>% head()

serie_d_emploi %>% mutate(
  Annee = year(Date),
  Trimestre = quarter(Date),
  Mois = month(Date),
  Jour = day(Date)
) %>% head()

date_debut <- ymd("2011-05-01")
date_fin <- ymd("2013-01-03")
intervalle <- interval(date_debut, date_fin)
str(intervalle)

serie_d_emploi %>% filter(Date %within% intervalle)


serie_d_emploi %>%
  arrange(Date) %>%
  group_by(Dept) %>%
  mutate(evol = Effectif - lag(Effectif)) %>%
  filter(str_detect(Dept,"^86"))


# Exercice ----------------------------------------------------------------

covid <- rio::import(file.path(chemin,"covid-hospit-2023-01-24-19h03.csv"))
covid <- as_tibble(covid)

covid %>%
  filter(sexe == 0) %>%
  mutate(jour = as.Date(jour)) %>% 
  group_by(dep, jour) %>% 
  summarise(hosp = sum(hosp)) %>% # année déjà triée 
  mutate(evol = hosp - lag(hosp)) %>% 
  mutate(annee = lubridate::year(jour)) 











