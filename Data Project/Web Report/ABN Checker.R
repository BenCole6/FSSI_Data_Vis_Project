ABN_Keybreaker <- read_excel("Web Report/VCOSS Data/ABN Keybreaker.xlsx")

ABN_Checker <- function(ABN_No) {
  
  sumproduct <- c()
  
  for(position in 1:nchar(ABN_No)) {
    
    number <- as.numeric(substr(ABN_No, position, position))  
    
    if(position == 1) {
      
      number <- as.numeric(number - 1)
      
    }
    
    product <- (number * ABN_Keybreaker$Weighting[position])
    
    sumproduct <- sum(sumproduct, product)
    
  }
  
  if(sumproduct %% 89 == 0) {
    
    Check <- "Valid ABN"
    
  } else {
    
    Check <- "Invalid ABN"
    
  }
  
  return(Check)
  
}

ABN_Check <- function(ABN_vector) {
  
  sapply(ABN_vector, ABN_Checker)
  
}

VCOSS_ACNC_16 <- mutate(VCOSS_ACNC_16,
                        ABN_Validation = ABN_Check(abn))

write_csv(VCOSS_ACNC_16,
          "VCOSS Cleaned ACNC Data 2016 - ABN Check.csv")

Invalid_ABNs_16 <- filter(VCOSS_ACNC_16,
                          ABN_Validation == "Invalid ABN")

write_csv(Invalid_ABNs_16,
          "Invalid ABNs 2016.csv")


VCOSS_ACNC_17 <- mutate(VCOSS_ACNC_17,
                        ABN_Validation = ABN_Check(abn))

write_csv(VCOSS_ACNC_17,
          "VCOSS Cleaned ACNC Data 2017 - ABN Check.csv")

Invalid_ABNs_17 <- filter(VCOSS_ACNC_17,
                          ABN_Validation == "Invalid ABN")

write_csv(Invalid_ABNs_17,
          "Invalid ABNs 2017.csv")


