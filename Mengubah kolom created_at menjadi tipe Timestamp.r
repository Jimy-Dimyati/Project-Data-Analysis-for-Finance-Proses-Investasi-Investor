library(lubridate)

df_event$created_at <- ymd_hms(df_event$created_at)
dplyr::glimpse(df_event)
