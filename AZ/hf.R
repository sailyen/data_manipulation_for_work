idct <- read.csv("IDCT.csv", header = T)
HF_1 <- read.csv("HF_1.csv", header = T)
HF_2 <- read.csv("HF_2.csv", header = T)
HF_3 <- read.csv("HF_3.csv", header = T)
HF_4 <- read.csv("HF_4.csv", header = T)
HF_5 <- read.csv("HF_5.csv", header = T)
names(idct)[1] <- "Country"
names(HF_1)[1] <- "Country"
names(HF_2)[1] <- "Country"
names(HF_3)[1] <- "Country"
names(HF_4)[1] <- "Country"
names(HF_5)[1] <- "Country"

HA <- HF_1
HB <- HF_2[,c(1,2)]
HC <- HF_2[,c(1,3)]
HD <- HF_3
HE <- HF_4
HF <- HF_5

library(sqldf)

iHA <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HA ON idct.Country = HA.Country")
iHA <- iHA[, c(1,3)]
names(iHA)[2] <- "value"  
iHA$indicator <- "HF_A"
iHA$sector <- "HF"

iHB <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HB ON idct.Country = HB.Country")
iHB <- iHB[, c(1,3)]
names(iHB)[2] <- "value"  
iHB$indicator <- "HF_B"
iHB$sector <- "HF"

iHC <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HC ON idct.Country = HC.Country")
iHC <- iHC[, c(1,3)]
names(iHC)[2] <- "value"  
iHC$indicator <- "HF_C"
iHC$sector <- "HF"

iHD <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HD ON idct.Country = HD.Country")
iHD <- iHD[, c(1,3)]
names(iHD)[2] <- "value"  
iHD$indicator <- "HF_D"
iHD$sector <- "HF"

iHE <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HE ON idct.Country = HE.Country")
iHE <- iHE[, c(1,3)]
names(iHE)[2] <- "value"  
iHE$indicator <- "HF_E"
iHE$sector <- "HF"

iHF <- sqldf("SELECT *
             FROM idct
             LEFT JOIN HF ON idct.Country = HF.Country")
iHF <- iHF[, c(1,3)]
names(iHF)[2] <- "value"  
iHF$indicator <- "HF_F"
iHF$sector <- "HF"

idct_HF <- rbind(iHA,iHB,iHC, iHD,iHE,iHF)
write.csv(idct_HF,"idct_HF.csv")
