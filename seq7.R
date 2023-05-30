# Jeu de données

pops <- data.frame(
  DC=c("16015","17300","79191","86194"),
  PMUN15=c(42081,75404,58952,87918),
  PMUN10=c(41613,75170,57325,87697),
  PMUN06=c(42096,77196,58066,88776),
  PSDC99=c(43171,76584,56663,83448),
  PSDC90=c(42876,71094,57012,78894),
  PSDC82=c(46197,75840,58203,79350),
  PSDC75=c(47221,75367,62267,81313),
  PSDC68=c(47822,73347,48469,70681))

pops

# Sélectionner des colonnes Les fonctions select

select(pops,PSDC99,DC)

select(pops,-PSDC99,-PSDC90,-PSDC82,-PSDC75,-PSDC68)

select(pops,DC,matches("^PSDC"))

select(pops,matches("^PSDC"),everything())

# Sélectionner des colonnes sur une caractéristique des données

select_if( pops, is.numeric )

select_if( pops, function(x) any(x>80000) )

# Sous le capot R est vectorisé

42

pops$PMUN15

f <- function(x) x>80000
f(pops$PMUN15)

# Sélectionner des colonnes de façon indirecte

VARS <- c("DC","PMUN15")
select(pops,VARS)

select_at(pops,VARS)

# Renommer des colonnes

rename(pops,commune=DC, pop=PMUN15) %>% colnames()

rename_if(pops,is.numeric,str_to_lower) %>% colnames()

rename_at(pops,VARS,str_to_lower) %>% colnames()

rename_all(pops,str_to_lower) %>% colnames()

# Calculer sur un ensemble de colonnes

mutate_at(pops,vars(matches("^PMUN")),function(x) x>80000)

mutate_if(pops,is.numeric,function(x) x>80000)

summarise_at(pops,vars(matches("^PMUN")),list(Minimum=min,Maximum=max))

filter_at(pops,vars(matches("^PMUN")),any_vars(.>80000))

filter_if(pops,is.numeric,all_vars(.>80000))
