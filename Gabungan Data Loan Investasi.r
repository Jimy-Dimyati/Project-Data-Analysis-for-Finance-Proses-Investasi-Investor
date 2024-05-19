library(dplyr)

df_loan_invest <- df_marketplace %>% 
					left_join(df_view_loan, by = 'loan_id') %>% 
					left_join(df_order_pay, by = c('loan_id','investor_id'))
df_loan_invest
