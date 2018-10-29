unemp_ne <- read.csv("Un_emp_na_es.csv",header = T, na.strings = "..")
head(unemp_ne)
names(unemp_ne)[1] <- "Country"
names(unemp_ne)[2] <- "Code"

library(reshape2)

unemp_ne_m <- melt(unemp_ne,id = c("Country", "Code"))
head(unemp_ne_m)
unemp_ne_m$year <- substr(unemp_ne_m$variable,2,5)
unemp_ne_m <- unemp_ne_m[,-3]
names(unemp_ne_m)[3] <- "Unemployment Rate"
unemp_ne_o <- na.omit(unemp_ne_m)
head(unemp_ne_o)

library(sqldf)

unemp <- sqldf("SELECT *
               FROM unemp_ne_o
               GROUP BY code
               ORDER BY Code")

head(unemp)
write.csv(unemp, "Unemployment.csv")

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
