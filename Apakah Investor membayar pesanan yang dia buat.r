library(dplyr)
library(lubridate)
library(ggplot2)

df_bayar_per_minggu <- df_loan_invest %>% 
  filter(!is.na(order)) %>%
  mutate(tanggal = floor_date(marketplace, 'week')) %>% 
  group_by(tanggal) %>%
  summarise(persen_bayar = mean(!is.na(pay))) 

ggplot(df_bayar_per_minggu) +
  geom_line(aes(x = tanggal, y = persen_bayar)) +
  scale_y_continuous(labels = scales::percent) +
  theme_bw() + 
  labs(title = "Sekitar 95% membayar pesanannya. Di akhir mei ada outlier karena lebaran",
	   x = "Tanggal",
	   y = "Pesanan yang dibayar")
