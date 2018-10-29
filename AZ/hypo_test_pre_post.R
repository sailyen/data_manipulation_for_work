
pre <- read.csv("sme_pre_gr_2y_int.csv", header = T)
post <- read.csv("sme_post_gr_2y_int.csv", header = T)

head(pre)
nrow(pre)
head(post)
nrow(post)

presize <- nrow(pre)
pi.hat1 <- mean(pre$pre_avg_gr)

postsize <- nrow(post)
pi.hat2 <- mean(post$post_avg_gr)

pi.hat.diff <- pi.hat2 - pi.hat1
std.err.pi.hat.diff <- sqrt(pi.hat2*(1-pi.hat2)/postsize + pi.hat1*(1-pi.hat1)/presize)
z.crit <- qnorm(0.95)
z.calc <- pi.hat.diff/std.err.pi.hat.diff

#z.crit = 1.644854
#z.calc = -9.771537

summary(pre)
summary(post)


library(sqldf)

pp <- sqldf("SELECT *
            FROM pre
            INNER JOIN post
            ON pre.clientid = post.clientid")

ppr <- pp[, c(2,4,9)]

write.csv(ppr,"pp_gr.csv")

ppslr <- lm(ppr$post_avg_gr~ppr$pre_avg_gr)
summary(ppslr)

# no relationship
############################################