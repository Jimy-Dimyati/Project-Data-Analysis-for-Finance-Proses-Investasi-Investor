library(dplyr)
library(lubridate)
library(ggplot2)

df_lama_bayar_per_minggu <- df_loan_invest %>% 
  filter(!is.na(pay)) %>%
  mutate(tanggal = floor_date(order, 'week'),
         lama_bayar = as.numeric(difftime(pay, order, units = "hour"))) %>% 
  group_by(tanggal) %>%
  summarise(lama_bayar = median(lama_bayar)) 

ggplot(df_lama_bayar_per_minggu) +
  geom_line(aes(x = tanggal, y = lama_bayar)) +
  theme_bw() + 
  labs(title = "Waktu pembayaran trennya cenderung memburuk, 2x lebih lama dari sebelumnya",
	   x = "Tanggal",
	   y = "waktu di pesanan dibayar (jam)")
