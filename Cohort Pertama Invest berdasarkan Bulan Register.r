library(dplyr)
library(lubridate)
library(tidyr)

df_register_per_investor <- df_event %>%
  filter(nama_event == 'investor_register') %>% 
  rename(tanggal_register = created_at) %>%  
  mutate(bulan_register = floor_date(tanggal_register, 'month'))  %>%  
  select(investor_id, tanggal_register, bulan_register) 

df_pertama_invest_per_investor <- df_event %>%
  filter(nama_event == 'investor_pay_loan') %>% 
  group_by(investor_id) %>% 
  summarise(pertama_invest = min(created_at)) 

df_register_per_investor %>% 
  left_join(df_pertama_invest_per_investor, by = 'investor_id') %>% 
  mutate(lama_invest = as.numeric(difftime(pertama_invest, tanggal_register, units = "day")) %/% 30) %>%  
  group_by(bulan_register, lama_invest) %>% 
  summarise(investor_per_bulan = n_distinct(investor_id)) %>% 
  group_by(bulan_register) %>% 
  mutate(register = sum(investor_per_bulan)) %>% 
  filter(!is.na(lama_invest)) %>% 
  mutate(invest = sum(investor_per_bulan)) %>% 
  mutate(persen_invest = scales::percent(invest/register)) %>% 
  mutate(breakdown_persen_invest = scales::percent(investor_per_bulan/invest)) %>%  
  select(-investor_per_bulan) %>%  
  spread(lama_invest, breakdown_persen_invest) 
