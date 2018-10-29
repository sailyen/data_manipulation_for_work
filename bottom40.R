f20 <- read.csv("f20.csv", header = T)
head(f20)
names(f20)[1] <- "code"

library(reshape2)


f20_m <- melt(f20, id = "code")
head(f20_m)

library(sqldf)

f20_m$variable = substr(f20_m$variable,2,5)
head(f20_m)
f20_m_o <- na.omit(f20_m)
head(f20_m_o)
f20_f <- sqldf("SELECT *
      FROM f20_m_o
      GROUP BY code;")
head(f20_f)
write.csv(f20_f, "alice_f20.csv")

######s20

s20 <- read.csv("s20.csv", header = T)
head(s20)
names(s20)[1] <- "code"

s20_m <- melt(s20, id = "code")
head(s20_m)


s20_m$variable = substr(s20_m$variable,2,5)
head(s20_m)
s20_m_o <- na.omit(s20_m)
head(s20_m_o)
s20_f <- sqldf("SELECT *
               FROM s20_m_o
               GROUP BY code;")
head(s20_f)
write.csv(s20_f, "alice_s20.csv")

bottom40 <- sqldf("SELECT *
                  FROM f20_f
                  JOIN s20_f ON f20_f.code = s20_f.code")
head(bottom40)

names(bottom40)[2] <- "year_f"
names(bottom40)[3] <- "first20"
names(bottom40)[5] <- "year_s"
names(bottom40)[6] <- "second20"
bottom40 <- bottom40[,-4]

bottom40$value = bottom40$first20 + bottom40$second20

write.csv(bottom40, "alice_bottom40.csv")
