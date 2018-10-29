dg <- read.csv("dg.csv", header = T, na.strings = "..")
head(dg)
names(dg)[1] <- "Country"

library(sqldf)
dgo <- na.omit(dg)
head(dgo)
dg_f <- sqldf("SELECT *
               FROM dgo
               GROUP BY code;")
head(dg_f)
write.csv(dg_f, "Debt to GDP ratio.csv")
