idct <- read.csv("IDCT.csv", header = T)
SL <- read.csv("SME_L.csv", header = T)
SM <- read.csv("SME_M.csv", header = T)
SN <- read.csv("SME_N.csv", header = T)
SO <- read.csv("SME_O.csv", header = T)

names(idct)[1] <- "Country"
names(SL)[1] <- "Country"
names(SM)[1] <- "Country"
names(SN)[1] <- "Country"
names(SO)[1] <- "Country"

library(sqldf)

iSL <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SL ON idct.Country = SL.Country")
iSL <- iSL[, c(1,3)]
names(iSL)[2] <- "value"  
iSL$indicator <- "SME_L"
iSL$sector <- "SME"


iSM <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SM ON idct.Country = SM.Country")
iSM <- iSM[, c(1,3)]
names(iSM)[2] <- "value"  
iSM$indicator <- "SME_M"
iSM$sector <- "SME"


iSN <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SN ON idct.Country = SN.Country")
iSN <- iSN[, c(1,3)]
names(iSN)[2] <- "value"  
iSN$indicator <- "SME_N"
iSN$sector <- "SME"


iSO <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SO ON idct.Country = SO.Country")
iSO <- iSO[, c(1,3)]
names(iSO)[2] <- "value"  
iSO$indicator <- "SME_O"
iSO$sector <- "SME"

idct_SME_add <- rbind(iSL, iSM, iSN, iSO)
write.csv(idct_SME_add, "idct_SME_add.csv")