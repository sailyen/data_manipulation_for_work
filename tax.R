tax <- read.csv("tax.csv", header = T, na.strings = "..")
head(tax)
names(tax)[1] <- "code"

library(reshape2)


taxm <- melt(tax, id = "code")
head(taxm)

library(sqldf)

taxm$variable = substr(taxm$variable,2,5)
head(taxm)
taxmo <- na.omit(taxm)
head(taxmo)
yead <- sqldf("SELECT code, variable
               FROM taxmo
              ORDER BY variable DESC
              LIMIT 5")

tax_f <- sqldf("SELECT code, variable, value
                FROM taxmo
               WHERE variable IN (SELECT variable
               FROM taxmo AS T2
               WHERE T2.code = taxmo.code
               ORDER BY variable DESC LIMIT 5)
               ORDER BY code")
tax_5avg <- sqldf("SELECT code, AVG(value) AS Tax_revenue_per_GDP
                  FROM tax_f
                  GROUP BY code")
head(tax_5avg)
write.csv(tax_5avg, "alice_tax.csv")
