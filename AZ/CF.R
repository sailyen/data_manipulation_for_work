idct <- read.csv("IDCT.csv", header = T)
CA <- read.csv("CF_1.csv", header = T)
CB <- read.csv("CF_2.csv", header = T)

names(idct)[1] <- "Country"
names(CA)[1] <- "Country"
names(CB)[1] <- "Country"

library(sqldf)

iCA <- sqldf("SELECT *
             FROM idct
             LEFT JOIN CA ON idct.Country = CA.Country")
iCA <- iCA[, c(1,3)]
names(iCA)[2] <- "value"  
iCA$indicator <- "CF_A"
iCA$sector <- "CF"


iCB <- sqldf("SELECT *
             FROM idct
             LEFT JOIN CB ON idct.Country = CB.Country")
iCB <- iCB[, c(1,3)]
names(iCB)[2] <- "value"  
iCB$indicator <- "CF_B"
iCB$sector <- "CF"

idct_cf<- rbind(iCA, iCB)
write.csv(idct_cf, "idct_CF.csv")


