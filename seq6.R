library(stringr)
p <- rio::import(file.path(chemin,"poplegale_6815b.sas7bdat"))

# Slides ---------------------------------------------------------------
p %>% filter(str_detect(DC,"^97"))
p %>% select(matches("C$"))
naissances %>% select(matches("age.ere"))
p %>% select(matches("\\d\\d$"))
p %>% select(matches("^[DP]"))
p %>% select(matches("^[^DP]")) %>% colnames()
p %>% filter(str_detect(NCC,"ts?$")) %>% View()

p %>% filter(str_detect(NCC,"te*$")) %>% View()
p %>% filter(str_detect(NCC,"te+$")) %>% View()

p %>% filter(str_detect(NCC,"Marie|Jean|Pierre"))
p %>% select(matches("^(PSDC|PMUN)"))
p %>% filter(str_detect(NCC,"(te?)+"))
p %>% filter(str_detect(NCC,"(.)\1"))

p %>% mutate(
  NCC2=str_replace(
    NCC,
    "^Saint(?=e-)",
    str_to_upper)
  ) %>% 
  View()

p %>% 
  mutate(
    x=str_replace(
      NCC,
      "^Saint(?!e-)",
      str_to_upper)
    ) %>% 
  View()

p %>% 
  mutate(
    NCC2=str_replace(
      NCC,
      "(?<=Saint)e-",
      str_to_upper)
    ) %>% 
  View()

p %>% 
  mutate(
    NCC2=str_replace(
      NCC,
      "(?<!Saint)e-",
      str_to_upper)
    ) %>%
  View()

# Exercice ---------------------------------------------------------------

# Sans regex
p %>% filter(
  substr(NCC,1,5) == "Saint" & 
    (substr(NCC,6,6) == "-" | substr(NCC,6,7) == "e-")
  )  %>% 
  View()

# Avec regex
p %>% filter(str_detect(NCC, "^Sainte?-")) %>% View()







