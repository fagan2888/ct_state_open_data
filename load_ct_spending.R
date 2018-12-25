##Retrieve CT spending data

load_ct_spending <- function(years) {
  
  library(data.table)
  library(stringr)
  
  #string <- stringr::str_c("/Users/davidlucey/Desktop/David/Projects/CT_data/CT-Expenditures-FY",years,".csv")
  string <- stringr::str_c("http://transparency.ct.gov/DATA/CT-Expenditures-FY",years,".csv")
  
  
  ct_spend <- lapply(string,fread)

  ct_first <- ct_spend[[1]]
  setnames(ct_first,c("FISCAL_YEAR","AGENCY_DESCR","DEPT_DESCR","FUND_DESCR", "LINE_ITEM_DESCR","ACCOUNT_DESCR","TOTAL_AMOUNT"),c("YEAR","AGENCY","DEPT","FUND","LINE_ITEM","ACCOUNT","TOTAL"))

  setnames(ct_spend[[2]],"FISCAL_YEAR1","FISCAL_YEAR")
  ct_second <- do.call("rbind",ct_spend[c(2,4)])
  setnames(ct_second,c("FISCAL_YEAR","AGENCY_DESCRIPTION","DEPT_DESCRIPTION","FUND_DESCRIPTION","LINE_ITEM_DESCRIPTION","ACCOUNT_DESCRIPTION","TOTAL_AMT"),c("YEAR","AGENCY","DEPT","FUND","LINE_ITEM","ACCOUNT","TOTAL"))

  ct_third <- rbind(ct_spend[[3]],ct_spend[[5]])
  ct_third[,AGENCY:=NULL]
  setnames(ct_third,c("FISCAL_YEAR","AGENCY_DESCRIPTION","DEPT_DESCRIPTION","FUND_DESCRIPTION","LINE_ITEM","ACCOUNT_DESCRIPTION","EXPENDED_AMOUNT"),c("YEAR","AGENCY","DEPT","FUND","LINE_ITEM","ACCOUNT","TOTAL"))

  ct_fourth <- do.call("rbind",ct_spend[c(6:9)])
  setnames(ct_fourth,c("FISCAL_YEAR","AGENCY_DESCRIPTION","DEPT_DESCRIPTION","FUND_DESCRIPTION","LINE_ITEM_DESCRIPTION","ACCOUNT_DESCRIPTION","TOTAL_AMT"),c("YEAR","AGENCY","DEPT","FUND","LINE_ITEM","ACCOUNT","TOTAL"))

  ct_spend <- rbind(ct_first,ct_second,ct_third,ct_fourth)
  ct_spend <- janitor::clean_names(ct_spend)
  ct_spend$account <- trimws(ct_spend$account)

  return(ct_spend)
}