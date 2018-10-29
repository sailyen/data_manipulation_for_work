sr <- read.csv("sme_omit.csv", header = T)

summary(sr)

sr_o <- na.omit(sr)
summary(sr_o)

write.csv(sr_o,"sr_o.csv")
#######################################################
#find all the proj with 2 IFC intervention 

sme_c <- read.csv("smedots.csv",header = T)n
names(sme_c)[1] <- "clientid"
library(sqldf)

sme_count <- sqldf("SELECT clientid, COUNT(clientid) as NumInv
      FROM sme_c
      GROUP BY clientid")

sme_c_2al <- sqldf("SELECT *
                   FROM sme_count
                   WHERE NumInv > 1")

sme_c_2 <- sqldf("SELECT *
                   FROM sme_count
                   WHERE NumInv = 2")

sme_2 <- sqldf("SELECT *
               FROM sme_c
               INNER JOIN sme_c_2 
               ON sme_c.clientid = sme_c_2.clientid")

sme2 <- sme_2[,-5]

sme_1int <- sme2[,-5]
#########################################################

c_y <- sme_1int[, 1:2]
int_year <- sqldf("SELECT *
                  FROM c_y
                  GROUP BY clientid")

# import the growthrate with data cleaning

sr <- read.csv("sr_gr.csv", header = T)
summary(sr)
sr_2y <- sqldf("SELECT year, clientid, countrycode, sme2growth
               FROM sr")
sr_2y_o <- na.omit(sr_2y)


# merge sme growth with int_year
s_gr <- sqldf("SELECT*
              FROM sr_2y_o
              LEFT JOIN int_year
              ON sr_2y_o.clientid = int_year.clientid")
s_gr_o <- na.omit(s_gr)

smegrowth <- s_gr_o[,-5]
names(smegrowth)[5] <- "int_year"


##########################################################3


# pre and post average growth rate calculating

pre_gr <- sqldf("SELECT *
                FROM smegrowth
                WHERE year < int_year")
pre_gr_avg <- sqldf("SELECT clientid, countrycode, AVG(sme2growth) as pre_avg_gr, int_year
                    FROM pre_gr
                    GROUP BY clientid")

post_gr <- sqldf("SELECT *
                FROM smegrowth
                WHERE year >= int_year")
post_gr_avg <- sqldf("SELECT clientid, countrycode, AVG(sme2growth) as post_avg_gr, int_year
                    FROM post_gr
                    GROUP BY clientid")

write.csv(pre_gr_avg,"sme_pre_gr_2y_int.csv")
write.csv(post_gr_avg,"sme_post_gr_2y_int.csv")
