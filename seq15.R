library(tidyverse)

# Le package tables
install.packages("tables")
library(tables)


mtcars %>%
  mutate_at(c("vs","cyl"),as.factor) %>%
  tabular( vs ~ cyl, .)

mtcars %>%
  mutate_at(c("vs","cyl","gear"),as.factor) %>%
  tabular(vs ~ cyl * gear, .)

mtcars %>%
  mutate_at(c("vs","cyl","gear"),as.factor) %>%
  tabular(vs ~ cyl + gear + 1, .)

mtcars %>%
  mutate_at(c("vs","cyl"),as.factor) %>%
  tabular(vs+1 ~
            Percent('all')
          *Format(purrr::partial(sprintf,"%.2f")())
          *Justify(r)
          *(cyl+1)
          , . )

mtcars %>%
  mutate_at(c("vs","cyl"),as.factor) %>%
  tabular(vs ~ cyl*mean*mpg, .)

install.packages("Hmisc")
library(Hmisc)

df <- data.frame(
  age= c( 20, 30, 40, 50, 60, 20, 30, 40, 50, 60),
  sexe= c("M","M","M","M","M","F","F","F","F","F"),
  poids=c( 1, 1, 1, 1, 3, 3, 1, 1, 1, 1),
  stringsAsFactors=TRUE
)

df %>% tabular(sexe ~
          age
        *(Heading(Moyenne)*wtd.mean*Arguments(w=poids)
          +Heading(Médiane)*wtd.quantile*Arguments(w=poids,p=.5)
        )
        ,.)

mtcars %>% 
  mutate_at(c("am","cyl"),as.factor) %>%
  tabular(am ~ mpg*mean*cyl, .) %>% # Fabrication du tableau
  Hmisc::html(.,"table1.html") # Ecriture sous forme de fichier html

r <- mtcars %>%
  mutate_at(c("am","cyl"),as.factor) %>%
  tabular(am ~ mpg*mean*cyl, .)

class(r)

df <- r%>%
  as.matrix()%>%
  as.data.frame()

# Exercice ----

tableau <- naissances%>%
  mutate_at(c('indnatm','indnatp'),as.factor)%>%
  tabular(Heading()*as.numeric(agemere)*Heading("Age moyen de la mère")*mean~
            Heading("indicateur de naissances mère")*indnatm*
            Heading("indicateur de naissances père")*indnatp, .)

tableau

verif<-naissances%>%
  select(agemere,indnatm,indnatp)%>%
  group_by(indnatm, indnatp)%>%
  summarise(age_moyen_mere=round(mean(as.numeric(agemere)),2))%>%
  as.data.frame()

verif
