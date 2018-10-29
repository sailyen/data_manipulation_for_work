library(tidyr)
library(sqldf)

#HS2007 TO SAM53
htog6 <- read.csv("HS_6_GTAP.csv", header = T)
head(htog6)
gtos <- read.csv("GTAP_TO_SAM53.CSV", header = T)
head(gtos)
names(gtos)[1] <- "GTAP"

htos <- sqldf("SELECT htog6.HS, htog6.GTAP, gtos.SAM53
              FROM htog6
              LEFT JOIN gtos 
              ON htog6.GTAP = gtos.GTAP
              ")
summary(htos)
head(htos)

htos[which(htos$SAM53 == 4), ]
A_6d[which(A_6d$HS == 121291),]

############################################################




A1 <- read.csv("KA.csv", header = T)
A <- A1[, c(2,3,5,7,8)]
head(A)
names(A)[1] <- "Trade_Flow"
names(A)[3] <- "Commodity_code"
names(A)[4] <- "Trade_Value"
names(A)[5] <- "Netweight_kg"


A <- separate(data = A, col = "Commodity_code", into = c("Classification", "HS"), sep = "-")
A$HS_digit <- nchar(as.character(A$HS))
A_6d <- sqldf("SELECT *
              FROM A
              WHERE HS_digit = 6")
head(A_6d)

A_HS <- sqldf("SELECT *
              FROM A_6d
              LEFT JOIN htos
              ON A_6d.HS = htos.HS")
head(A_HS)

A_SAM <- sqldf("SELECT Reporter, SUM(Trade_Value) AS Trade_Value_us,
               SUM(Netweight_kg) AS Netweight_kg, 
               SUM(Trade_Value)/SUM(Netweight_kg) AS Value_per_kg, SAM53 
               FROM A_HS
               GROUP BY Reporter, SAM53")
A_SAM_O <- na.omit(A_SAM)
head(A_SAM_O)

write.csv(A_SAM_O, "KA_SAM53_v1.csv")
