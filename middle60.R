library(reshape2)
library(sqldf)

####second20
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

#####third20
t20 <- read.csv("t20.csv", header = T)
head(t20)
names(t20)[1] <- "code"

t20_m <- melt(t20, id = "code")
head(t20_m)


t20_m$variable = substr(t20_m$variable,2,5)
head(t20_m)
t20_m_o <- na.omit(t20_m)
head(t20_m_o)
t20_f <- sqldf("SELECT *
               FROM t20_m_o
               GROUP BY code;")
head(t20_f)
write.csv(t20_f, "alice_t20.csv")

#####fourth20
fo20 <- read.csv("fo20.csv", header = T)
head(fo20)
names(fo20)[1] <- "code"

fo20_m <- melt(fo20, id = "code")
head(fo20_m)


fo20_m$variable = substr(fo20_m$variable,2,5)
head(fo20_m)
fo20_m_o <- na.omit(fo20_m)
head(fo20_m_o)
fo20_f <- sqldf("SELECT *
               FROM fo20_m_o
               GROUP BY code;")
head(fo20_f)
write.csv(fo20_f, "alice_fo20.csv")

######join

middle60 <- sqldf("SELECT *
                  FROM s20_f
                  JOIN t20_f ON t20_f.code = s20_f.code
                  JOIN fo20_f ON fo20_f.code = s20_f.code")
head(middle60)
middle60 <- middle60[,c(-4,-7)]
names(middle60)[2] <- "year_s"
names(middle60)[4] <- "year_t"
names(middle60)[6] <- "year_fo"

names(middle60)[3] <- "second20"
names(middle60)[5] <- "third20"
names(middle60)[7] <- "fourth20"
head(middle60)

middle60$value <- middle60$second20 + middle60$third20 + middle60$fourth20
write.csv(middle60, "alice_middle60.csv")
