reg_2y <- read.csv("reg_2y.csv", header = T)
reg_1y <- read.csv("reg_1y.csv", header = T)
summary(reg_2y)
summary(reg_1y)

reg1_2y <- lm(reg_2y$smeloangrowth~reg_2y$totcountrygrowth) 
summary(reg1_2y)
reg1_1y <- lm(reg_1y$smeloangrowth~reg_1y$totcountrygrowth) 
summary(reg1_1y)

reg2_2y <- lm(reg_2y$smeloangrowth~reg_2y$totportgrowth) 
summary(reg2_2y)
reg2_1y <- lm(reg_1y$smeloangrowth~reg_1y$totportgrowth) 
summary(reg2_1y)

reg3_2y <- lm(reg_2y$smeloangrowth~reg_2y$totcommgrowth) 
summary(reg3_2y)
reg3_1y <- lm(reg_1y$smeloangrowth~reg_1y$totcommgrowth) 
summary(reg3_1y)
