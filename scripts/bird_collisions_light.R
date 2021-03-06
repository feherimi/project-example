# Joins collisions, bird, and McCormick Place light data 
# Creates rds with all data

# Source: Winger BM, Weeks BC, Farnsworth A, Jones AW, Hennen M, Willard DE (2019) 
#         Data from: Nocturnal flight-calling behaviour predicts vulnerability to 
#         artificial light in migratory birds. Dryad Digital Repository. 
#         https://doi.org/10.5061/dryad.8rr0498

# Author: Sara Altman
# Version: 2019-05-07

# Libraries
library(tidyverse)

# Parameters
  # Bird data file
file_birds <- here::here("data/birds.rds")
  # Collisions data file
file_collisions <- here::here("data/collisions.rds")
  # McCormick Place light data file
file_light_mp <- here::here("data/light_mp.rds")
  # Output file
file_out <- here::here("data/bird_collisions_light.rds")

#===============================================================================

birds <-
  file_birds %>% 
  read_rds()

light_mp <-
  file_light_mp %>% 
  read_rds()

file_collisions %>% 
  read_rds() %>% 
  left_join(birds, by = c("genus", "species")) %>% 
  left_join(light_mp, by = "date") %>% 
  select(-num_collisions) %>% 
  arrange(genus, species, date) %>% 
  write_rds(file_out)
