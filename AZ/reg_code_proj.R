reg <- read.csv("reg_pre_post.csv",header = T)
summary(reg)
reg <- reg[,c(1,2,5,7,8)]
names(reg)[1] <- "Ins_code"
names(reg)[3] <- "Proj_growth"
names(reg)[4] <- "3year_growth"
names(reg)[5] <- "5year_growth"

reg3 <- lm(reg$Proj_growth~reg$`3year_growth`)
summary(reg3)
reg5 <- lm(reg$Proj_growth~reg$`5year_growth`)
summary(reg5)

write.csv(reg,"reg.csv")
