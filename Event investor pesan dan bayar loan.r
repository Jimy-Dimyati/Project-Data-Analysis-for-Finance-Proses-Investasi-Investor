library(dplyr)
library(tidyr)

df_order_pay <- df_event %>%
					filter(nama_event %in% c('investor_order_loan', 'investor_pay_loan')) %>%
					spread(nama_event, created_at) %>%
					select(loan_id, 
  						   investor_id, 
  						   order = investor_order_loan, 
  						   pay = investor_pay_loan)
df_order_pay
