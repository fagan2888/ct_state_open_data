##Load CT payments
load_ct_payments <- function(years){
  
  library(data.table)
  library(stringr)
  
  #string <- stringr::str_c("~/Desktop/David/Projects/CT_data/CT-Payments-FY",years,".csv")
  string <- stringr::str_c("http://transparency.ct.gov/DATA/CT-Payments-FY",years,".csv")

  ct_pays <- lapply(string,fread)
  setnames(ct_pays[[1]],c("FISCAL_YEAR","AGENCY_DESCRIPTION","PAYEE_NAME","SCHEDULED_PAY_DT","TOT_MONETARY_AMT"))
  setnames(ct_pays[[2]],c("FISCAL_YEAR","AGENCY_DESCRIPTION","PAYEE_NAME","SCHEDULED_PAY_DT","TOT_MONETARY_AMT"))
  setnames(ct_pays[[5]],c("FISCAL_YEAR","AGENCY_DESCRIPTION","PAYEE_NAME","SCHEDULED_PAY_DT","TOT_MONETARY_AMT"))
  ct_pays <-  do.call("rbind",ct_pays) %>% 
    janitor::clean_names()
  
  return(ct_pays)
}