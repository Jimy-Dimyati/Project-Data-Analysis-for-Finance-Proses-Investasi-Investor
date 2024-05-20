library(dplyr)
library(tidyr)
df_loan_invest %>%
  mutate(status_order = ifelse(is.na(order), 'not_order','order')) %>% 
  count(jumlah_view, status_order) %>% 
  spread(status_order, n, fill = 0) %>% 
  mutate(persen_order = scales::percent(order/(order + not_order)))
