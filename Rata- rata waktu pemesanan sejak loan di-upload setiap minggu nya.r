library(dplyr)
library(lubridate)
library(ggplot2)

df_lama_order_per_minggu <- df_loan_invest %>% 
  filter(!is.na(order)) %>%
  mutate(tanggal = floor_date(marketplace, 'week'),
         lama_order = as.numeric(difftime(order, marketplace, units = "hour"))) %>% 
  group_by(tanggal) %>%
  summarise(lama_order = median(lama_order)) 

ggplot(df_lama_order_per_minggu) +
  geom_line(aes(x = tanggal, y = lama_order)) +
  theme_bw() + 
  labs(title = "Rata-rata lama order pada tahun 2020 lebih lama daripada 2019",
	   x = "Tanggal",
	   y = "Waktu di marketplace sampai di-pesan (jam)")
