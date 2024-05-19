library(dplyr)

df_event %>%
	group_by(nama_event) %>%
	summarise(jumlah_event = n(), 
			  loan = n_distinct(loan_id), 
			  investor = n_distinct(investor_id))
