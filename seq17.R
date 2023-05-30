chemin <- "https://minio.lab.sspcloud.fr/jpramil/formation_pemrdr"
path <- file.path(chemin, "nais2017.parquet")

arrow::read_parquet(path)%>%
  .[.$depnais=="86", c("depnais","agemere")]

lire1 <- 
  function(Dep){
    arrow::read_parquet(path)%>%
  .[.$depnais==Dep, c("depnais","agemere")]
  }

lire1("86")%>%
  count()

lire1("22")%>%
  count()

lire_et_compter <-
  function(Dep) {
    temp <- lire1(Dep)
    print(count(temp))
    as_tibble(temp)
  }

b <- lire_et_compter("86")

head(b)

"86" %>% lire1() %>% {print(count(.)); as_tibble(.)}

## Exercice 17.1 ----

# Package ggformula
install.packages("ggformula")
library(ggformula)
library(rio)

covid <- rio::import(file.path(chemin,"covid-hospit-2023-01-24-19h03.csv"))
covid <- as_tibble(covid)

graphique_covid<- function(var_dep){
  covid %>%
  filter(dep==var_dep,sexe==0)%>%
  gf_line(hosp~jour)%>%
  gf_labs(
    title=paste0("Évolution des hospitalisations du Covid-19 au cours du temps dans le département ",var_dep),
    caption="Source: DATA.GOUV",
    x="Date",
    y="Hospitalisation cas Covid-19"
  )%>%
  gf_refine(
    scale_x_date(breaks="3 month", date_labels = "%b %Y")
  )
}

graphique_covid("22")
graphique_covid("14")

## Suite diapo ----

lireN <- 
  function(...){
    arrow::read_parquet(path)%>%
      .[.$depnais %in% c(...), c("depnais","agemere")]
  }

lireN('13','17')%>%
  count(depnais)

ldf <- Map(lire1, c("16","17"))

str(ldf)

Map(count, ldf)

df <- Reduce(bind_rows, ldf)
str(df)

## Exercice 17.2 ----

Map(graphique_covid,c("971","972","973"))

