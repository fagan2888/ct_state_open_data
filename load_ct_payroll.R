##Employee comp expense 2010-2017
load_ct_payroll <- function(years) {
  
  #Load data from transparency.ct.gov
  #string <-str_c("~/Desktop/David/Projects/CT_data/CT-Payroll-Earns-FY",years,".csv")
  string <-str_c("http://transparency.ct.gov/DATA/CT-Payroll-Earns-FY",years,".csv")
  ct <- lapply(string,fread)

  ct_first <- do.call("rbind",ct[1:5])[
    ,c("AGENCY","ACCOUNT_DESCRIPTION","DEPT_DESCRIPTION"):=NULL]
  setnames(ct_first,"EARNINGS_AMT","EARNINGS")
  ct_second <- do.call("rbind",ct[c(6,7,9)])[
    ,c("ACCOUNT_DESCRIPTION","DEPT_DESCRIPTION") := NULL]
  ct_third <- ct[[8]][,c("DEPT_DESCRIPTION","ACCOUNT_DESCRIPTION"):=NULL]
  ct <- rbind(ct_first,ct_second,ct_third) %>%
    janitor::clean_names()
return(ct)
}