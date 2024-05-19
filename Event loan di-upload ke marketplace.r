library(dplyr)

df_marketplace <- df_event %>% 
          					filter(nama_event == 'loan_to_marketplace') %>% 						
                    select(loan_id, marketplace = created_at) 
df_marketplace
