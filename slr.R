df <- read.csv("df.csv", header = T, na.strings = "#N/A")
summary(df)
names(df)[1] <- "Code"
df[,3:28] <- sapply(df[,3:28], as.numeric)


a1 <- lm(Y~A3, data = df)
a1s <- summary(a1)
a1s
f <- a1s$fstatistic
p <- pf(f[1],f[2],f[3], lower.tail=F)
p


result <- data.frame(matrix(nrow = 27, ncol = 2))
names(result)[1] <- "index"
names(result)[2] <- "p-value"

for (i in 3:27){
  xvar <- paste0("Y~A",i)
  p <- tryCatch(pf(summary(lm(xvar,data = df))$fstatistic[1],
                   summary(lm(xvar,data = df))$fstatistic[2],
                   summary(lm(xvar,data = df))$fstatistic[3], lower.tail=F), 
                error = function(e){e})
  m <- paste0("A",i)
  result[i, 1] <- m
  result[i, 2] <- p
}

result
write.csv(result,"sig_num.csv")
