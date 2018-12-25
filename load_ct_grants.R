##Load CT grants data
load_ct_grants <- function(years){
  
  library(data.table)
  library(stringr)
  
  #string <- stringr::str_c("~/Desktop/David/Projects/CT_data/CT-Grants-FY",years,".csv")
  string <- stringr::str_c("http://transparency.ct.gov/DATA/CT-Grants-FY",years,".csv")

  ct_grants <- lapply(string,fread)

  ct_first <- do.call("rbind",ct_grants[c(3,6:9)])
  setnames(ct_first,c("YEAR","VENDOR","AGENCY","GRANT","AMOUNT"))

  ct_second <- do.call("rbind",ct_grants[c(4:5)])
  setnames(ct_second,c("YEAR","AGENCY","VENDOR","GRANT","AMOUNT"))
  ct_second[,c("YEAR","VENDOR","AGENCY","GRANT","AMOUNT")]

  ct_third <- do.call("rbind",ct_grants[c(2:3)])
  setnames(ct_third,c("YEAR","VENDOR","AGENCY","GRANT","AMOUNT"))

  ct_fourth <- do.call("rbind",ct_grants[1])[,-c("FUND_DESC")]
  setnames(ct_fourth,c("YEAR","VENDOR","AGENCY","GRANT","AMOUNT"))

  ct_grants <-  rbind(ct_first,ct_second,ct_third,ct_fourth) %>% 
    janitor::clean_names()
 return(ct_grants)
}