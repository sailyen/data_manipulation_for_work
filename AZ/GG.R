##melting GG plot
GG <- read.csv("GG.csv",header = T)
names(GG)[1] <- "Country"

library(reshape)

GG_melt <- melt(GG, id = c("Country", "C_Code"))
write.csv(GG_melt, "GGM.csv")

##left join project and ggm
GGM <- read.csv("GGM.csv",header = T)
p1 <- read.csv("BANK_P1.csv",header = T)
names(GGM)[1] <- "Country"
names(p1)[1] <- "ID"
head(GGM)
head(p1)

library(sqldf)

ggm1 <- sqldf("SELECT p1.ID, p1.Reporting_Year, p1.Nation, p1.C_Code, GGM.Year, GGM.GG
               FROM p1
               LEFT JOIN GGM ON p1.C_Code = GGM.C_Code")
ggm2_post <- sqldf("SELECT *
               FROM ggm1
               WHERE Year>Reporting_Year
               AND Year <= Reporting_Year + 3")
ggm2_pre <- sqldf("SELECT *
                   FROM ggm1
                   WHERE Year >= Reporting_Year - 3
                   AND Year < Reporting_Year")
write.csv(ggm2_post, "ggm2_post.csv")
write.csv(ggm2_pre, "ggm2_pre.csv")
ggm3_post <- sqldf("
                   SELECT ID, Reporting_Year, Nation, C_Code, AVG(GG) AS POST_GDPGrowth
                   FROM ggm2_post
                   GROUP BY ID")
ggm3_pre <- sqldf("
                   SELECT ID, Reporting_Year, Nation, C_Code, AVG(GG) AS PRE_GDPGrowth
                   FROM ggm2_pre
                   GROUP BY ID")
write.csv(ggm3_post, "ggm3_post.csv")
write.csv(ggm3_pre, "ggm3_pre.csv")





