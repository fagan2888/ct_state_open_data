
load_ct_pensions <- function(years) {

  string <- stringr::str_c("~/Desktop/David/Projects/CT_data/CT-Pensions-CY",years,".csv")
  ct_pension <- lapply(string,fread)
  ct_pension <- do.call("rbind",ct_pension)[,
                TOTAL_AMT := as.numeric(tm::removePunctuation(stringr::str_remove(TOTAL_AMT,"\\..*")))] %>%
  janitor::clean_names()
return(ct_pension)
}