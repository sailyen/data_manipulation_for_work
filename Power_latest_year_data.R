a <- read.csv("Clearance time with inspection.csv", header = T)
head(a)
names(a)[1] <- "Country"

library(reshape2)
a_m <- melt(a, id = "Country")
head(a_m)
a_m$variable = substr(a_m$variable,2,5)
a_m_o <- na.omit(a_m)
head(a_m_o)

library(sqldf)
a_f <- sqldf("SELECT *
      FROM a_m_o
      GROUP BY Country")
head(a_f)
write.csv(a_f,"A.Clearance time with inspection.csv")

############################################################
b <- read.csv("Clearance time without inspect..csv", header = T)
head(b)
names(b)[1] <- "Country"

b_m <- melt(b, id = "Country")
head(b_m)
b_m$variable = substr(b_m$variable,2,5)
b_m_o <- na.omit(b_m)
head(b_m_o)

b_f <- sqldf("SELECT *
      FROM b_m_o
      GROUP BY Country")
head(b_f)
write.csv(b_f,"B.Clearance time without inspect..csv")

############################################################
c <- read.csv("Road density.csv", header = T)
head(c)
names(c)[1] <- "Country"

c_m <- melt(c, id = "Country")
head(c_m)
c_m$variable = substr(c_m$variable,2,5)
c_m_o <- na.omit(c_m)
head(c_m_o)

c_f <- sqldf("SELECT *
      FROM c_m_o
      GROUP BY Country")
head(c_f)
write.csv(c_f,"C.Road density.csv")


############################################################
d <- read.csv("Road km per capita.csv", header = T)
head(d)
names(d)[1] <- "Country"

d_m <- melt(d, id = "Country")
head(d_m)
d_m$variable = substr(d_m$variable,2,5)
d_m_o <- na.omit(d_m)
head(d_m_o)

d_f <- sqldf("SELECT *
      FROM d_m_o
      GROUP BY Country")
head(d_f)
write.csv(d_f,"D.Road km per capita.csv")


############################################################
e <- read.csv("Total length of paved roadways.csv", header = T)
head(e)
names(e)[1] <- "Country"

e_m <- melt(e, id = "Country")
head(e_m)
e_m$variable = substr(e_m$variable,2,5)
e_m_o <- na.omit(e_m)
head(e_m_o)

e_f <- sqldf("SELECT *
             FROM e_m_o
             GROUP BY Country")
head(e_f)
write.csv(e_f,"E.Total length of paved roadways.csv")


############################################################
f <- read.csv("Total length of road.csv", header = T)
head(f)
names(f)[1] <- "Country"

f_m <- melt(f, id = "Country")
head(f_m)
f_m$variable = substr(f_m$variable,2,5)
f_m_o <- na.omit(f_m)
head(f_m_o)

f_f <- sqldf("SELECT *
             FROM f_m_o
             GROUP BY Country")
head(f_f)
write.csv(f_f,"F.Total length of road.csv")
