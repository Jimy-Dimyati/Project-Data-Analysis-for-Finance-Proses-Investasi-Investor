library(dplyr)
library(lubridate)
library(tidyr)

df_investasi_per_investor <- df_event %>%
  filter(nama_event == 'investor_pay_loan') %>%
  rename(tanggal_invest = created_at) %>%
  select(investor_id, tanggal_invest)

df_pertama_invest_per_investor %>%
  mutate(bulan_pertama_invest = floor_date(pertama_invest, 'month')) %>%
  inner_join(df_investasi_per_investor, by = 'investor_id') %>%
  mutate(jarak_invest = as.numeric(difftime(tanggal_invest, pertama_invest, units = "day")) %/% 30) %>%
  group_by(bulan_pertama_invest, jarak_invest) %>%
  summarise(investor_per_bulan = n_distinct(investor_id)) %>%
  group_by(bulan_pertama_invest) %>%
  mutate(investor = max(investor_per_bulan)) %>%
  mutate(breakdown_persen_invest = scales::percent(investor_per_bulan/investor)) %>%
  select(-investor_per_bulan) %>%
  spread(jarak_invest, breakdown_persen_invest) %>%
  select(-`0`)
