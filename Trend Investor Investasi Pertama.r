library(dplyr)
library(lubridate)
library(ggplot2)

df_investor_pertama_invest <- df_event %>% 
  filter(nama_event == 'investor_pay_loan') %>%
  group_by(investor_id) %>% 
  summarise(pertama_invest = min(created_at)) %>% 
  mutate(tanggal = floor_date(pertama_invest, 'week')) %>% 
  group_by(tanggal) %>% 
  summarise(investor = n_distinct(investor_id)) 

ggplot(df_investor_pertama_invest) +
  geom_line(aes(x = tanggal, y = investor)) +
  theme_bw() + 
  labs(title = "Ada tren kenaikan jumlah investor invest, namun turun drastis mulai Maret 2020",
	   x = "Tanggal",
	   y = "Investor Pertama Invest")
