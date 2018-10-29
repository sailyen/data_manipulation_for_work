idct <- read.csv("IDCT.csv", header = T)
sme_1 <- read.csv("sme_1.csv", header = T)
sme_2 <- read.csv("sme_2.csv", header = T)
sme_3 <- read.csv("sme_3.csv", header = T)
names(idct)[1] <- "Country"
names(sme_1)[1] <- "Country"
names(sme_2)[1] <- "Country"
names(sme_3)[1] <- "Country"

SA <- sme_1[, c(1,2)]
SB <- sme_1[, c(1,3)]
SC <- sme_1[, c(1,4)]
SD <- sme_1[, c(1,5)]
SE <- sme_1[, c(1,6)]

SF <- sme_2[, c(1,2)]
SG <- sme_2[, c(1,3)]
SH <- sme_2[, c(1,4)]
SI <- sme_2[, c(1,5)]
SJ <- sme_2[, c(1,6)]

SK <- sme_3 

library(sqldf)

iSA <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SA ON idct.Country = SA.Country")
iSA <- iSA[, c(1,3)]
names(iSA)[2] <- "value"  
iSA$indicator <- "SME_A"
iSA$sector <- "SME"


iSB <- sqldf("SELECT *
             FROM idct
             LEFT JOIN 
             SB ON idct.Country = SB.Country")
iSB <- iSB[, c(1,3)]
names(iSB)[2] <- "value" 
iSB$indicator <- "SME_B"
iSB$sector <- "SME"


iSC <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SC ON idct.Country = SC.Country")
iSC <- iSC[, c(1,3)]
names(iSC)[2] <- "value" 
iSC$indicator <- "SME_A"
iSC$sector <- "SME"


iSD <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SD ON idct.Country = SD.Country")
iSD <- iSD[, c(1,3)]
names(iSD)[2] <- "value" 
iSD$indicator <- "SME_D"
iSD$sector <- "SME"


iSE <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SE ON idct.Country = SE.Country")
iSE <- iSE[, c(1,3)]
names(iSE)[2] <- "value" 
iSE$indicator <- "SME_E"
iSE$sector <- "SME"


iSF <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SF ON idct.Country = SF.Country")
iSF <- iSF[, c(1,3)]
names(iSF)[2] <- "value" 
iSF$indicator <- "SME_F"
iSF$sector <- "SME"


iSG <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SG ON idct.Country = SG.Country")
iSG <- iSG[, c(1,3)]
names(iSG)[2] <- "value" 
iSG$indicator <- "SME_G"
iSG$sector <- "SME"


iSH <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SH ON idct.Country = SH.Country")
iSH <- iSH[, c(1,3)]
names(iSH)[2] <- "value" 
iSH$indicator <- "SME_H"
iSH$sector <- "SME"


iSI <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SI ON idct.Country = SI.Country")
iSI <- iSI[, c(1,3)]
names(iSI)[2] <- "value" 
iSI$indicator <- "SME_I"
iSI$sector <- "SME"


iSJ <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SJ ON idct.Country = SJ.Country")
iSJ <- iSJ[, c(1,3)]
names(iSJ)[2] <- "value" 
iSJ$indicator <- "SME_J"
iSJ$sector <- "SME"


iSK <- sqldf("SELECT *
             FROM idct
             LEFT JOIN SK ON idct.Country = SK.Country")
iSK <- iSK[, c(1,3)]
names(iSK)[2] <- "value" 
iSK$indicator <- "SME_K"
iSK$sector <- "SME"


idct_SME <- rbind(iSA, iSB, iSC, iSD, iSE, iSF, iSG, iSH, iSI, iSJ, iSK)
write.csv(idct_SME, "idct_SME.csv")

