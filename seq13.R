# Package ggformula
install.packages("ggformula")
library(ggformula)

mtcars %>%
  gf_dhistogram(~ wt) %>%
  gf_dens(~ wt)

head(diamonds)

# distribution variable discrète

diamonds %>% count(cut)

diamonds %>% gf_bar(~cut)

# distribution variable continue

diamonds %>% mutate(x=cut(price,seq(0,20000,by=1000))) %>% count(x)

diamonds %>% gf_histogram(~price)

# distribution lissée de la variable continue

diamonds %>%
  gf_dens(~price) %>%
  gf_dens(~price, bw=1000, color="red")

## Exercice 13.1 ----

naissances%>%
  count(agemere)

# histogramme de la variable caractère

naissances%>%
  gf_bar(~agemere)

# conversion de la variable en facteur

naissances_2<-as_tibble(naissances)%>%
  arrange(agemere)%>% #faire test sans cette ligne pour montrer importance d'ordonner valeurs
  mutate(agemere_qualitative=as_factor(agemere))

naissances_2%>%
  count(agemere_qualitative)

naissances_2%>%
  gf_bar(~agemere_qualitative)


## Suite diapo ----

# Affichage nuage de points

diamonds %>% gf_point( price ~ carat )

diamonds %>% gf_boxplot( price ~ cut )

head(economics,n=3)

economics %>% gf_line( unemploy ~ date )

diamonds %>%
  sample_n(size = 500) %>%
  gf_point(price ~ carat, colour=~cut) %>%
  gf_labs(
    title="Lien entre prix et poids des diamants",
    caption="Source ggplot2",
    x="Poids en carats",
    y="Prix en dollars") %>%
  gf_refine(
    scale_y_continuous(breaks=c(0,9000,18000))) %>%
  gf_theme(theme_bw())

## Exercice 13.2 ----

covid <- rio::import(file.path(chemin,"covid-hospit-2023-01-24-19h03.csv"))
covid <- as_tibble(covid)

covid_22<-covid%>%
  filter(sexe==0&dep=='22')

covid_22%>%
  gf_line(hosp~jour)%>%
  gf_labs(
    title="Évolution des hospitalisations du Covid-19 au cours du temps dans les Côtes d'Armor",
    caption="Source: DATA.GOUV",
    x="Date",
    y="Hsopitalisation cas Covid-19"
  )%>%
  gf_refine(
    scale_x_date(breaks="3 month", date_labels = "%b %Y")
  )

# Sauvegarde du dernier graphique créé

ggsave("mngraphique.png",
       width = 12, height = 8, unit = "cm", dpi = 300)

## Suite diapo ----

# Sauvegarde d'un graphique stocké

graphique_22_covid<-covid_22%>%
  gf_line(hosp~jour)%>%
  gf_labs(
    title="Évolution des hospitalisations du Covid-19 au cours du temps dans les Côtes d'Armor",
    caption="Source: DATA.GOUV",
    x="Date",
    y="Hospitalisation cas Covid-19"
  )%>%
  gf_refine(
    scale_x_date(breaks="3 month", date_labels = "%b %Y")
  )

ggsave("mngraphique.png",plot=graphique_22_covid,
       width = 12, height = 8, unit = "cm", dpi = 300)

naissances %>%
  select(agepere,agemere) %>%
  gather(parent,age) %>%
  count(parent,age) %>%
  mutate(n=ifelse(parent=="agepere",-n,n),
         parent=factor(parent,levels=c("agepere","agemere"),labels=c("Père","Mère"))) %>%
  gf_col(n ~ age,
         fill = ~parent) %>% 
  gf_refine(scale_y_continuous(labels = abs), 
            coord_flip())


r <- mtcars %>% gf_histogram(~wt)

class(r)

lengths(r)

install.packages("patchwork")
library(patchwork)
g1 <- mtcars %>% gf_histogram(~mpg)
g2 <- mtcars %>% gf_histogram(~wt)
g3 <- mtcars %>% gf_point(wt ~ mpg)

(g1 | g2) / g3

## Exercice récapitulatif ----

serie_emploi <- rio::import(file.path(chemin,"Serie_d_emploi.RDS"))
serie_emploi <- as_tibble(serie_emploi)

head(serie_emploi)


