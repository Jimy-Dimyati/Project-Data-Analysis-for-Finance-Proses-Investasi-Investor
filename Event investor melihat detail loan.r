library(dplyr)

df_view_loan <- df_event %>% 
					filter(nama_event == 'investor_view_loan') %>% 
					group_by(loan_id, investor_id) %>% 
					summarise(jumlah_view = n(), 
							  pertama_view = min(created_at), 
							  terakhir_view = max(created_at))
df_view_loan
