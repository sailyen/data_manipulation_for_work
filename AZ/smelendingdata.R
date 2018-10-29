exr <- read.csv("EXR.csv", header = T)
names(exr)[1] <- "Country"
fas <- read.csv("FAS_L.csv", header = T)
names(fas)[1] <- "Country"
names(fas)[2] <- "Code"
names(fas)[4] <- "FAS_L"
summary(fas)
oecd <- read.csv("OECD_L.csv", header = T)
names(oecd)[1] <- "Code"
names(oecd)[3] <- "Year"
names(oecd)[4] <- "OECD_L"
summary(oecd)


library(sqldf)

sme <- sqldf("SELECT exr.Country, exr.Code, exr.Exchange_Rate, fas.Year, fas.FAS_L,oecd.OECD_L
      FROM exr
      LEFT JOIN fas on (exr.Code = fas.Code AND exr.Time = fas.Year)
      LEFT JOIN oecd on (exr.Code = oecd.Code AND exr.Time = oecd.Year)
      ")

write.csv(sme, "sme_left.csv")
