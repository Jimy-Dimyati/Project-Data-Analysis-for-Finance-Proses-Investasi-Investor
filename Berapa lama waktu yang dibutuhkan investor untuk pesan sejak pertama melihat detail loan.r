library(dplyr)
library(tidyr)
df_loan_invest %>%
  filter(!is.na(order)) %>% 
  mutate(lama_order_view = as.numeric(difftime(order, pertama_view, units = "mins"))) %>% 
  group_by(jumlah_view) %>% 
  summarise_at(vars(lama_order_view), funs(total = n(), min, median, mean, max)) %>% 
  mutate_if(is.numeric, funs(round(.,2)))
