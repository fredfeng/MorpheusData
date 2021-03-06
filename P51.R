# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 51
day=c(1,2,3,4,5,6,1,2,3,4,5,6)
site=c('a', 'a', 'a', 'a', 'a', 'a', 'b', 'b', 'b', 'b', 'b', 'b')
value.1=c(1,2,5,7,5,3,9,4,2,8,1,8)
value.2=c(5,4,7,6,2,4,6,9,4,2,5,6)
dat=data.frame(day,site,value.1,value.2)



write.csv(dat, "data-raw/p51_input1.csv", row.names=FALSE)

df_out = dat %>%
  gather(labs, values, value.1:value.2) %>% 
  unite(site2, site,labs) %>% 
  spread(site2, values) 

write.csv(df_out, "data-raw/p51_output1.csv", row.names=FALSE)

p51_output1 <- read.csv("data-raw/p51_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p51_output1, is.factor)
int.cols <- sapply(p51_output1, is.integer)

p51_output1[, fctr.cols] <- sapply(p51_output1[, fctr.cols], as.character)
p51_output1[, int.cols] <- sapply(p51_output1[, int.cols], as.numeric)
save(p51_output1, file = "data/p51_output1.rdata")

p51_input1 <- read.csv("data-raw/p51_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p51_input1, is.factor)
int.cols <- sapply(p51_input1, is.integer)

p51_input1[, fctr.cols] <- sapply(p51_input1[, fctr.cols], as.character)
p51_input1[, int.cols] <- sapply(p51_input1[, int.cols], as.numeric)
save(p51_input1, file = "data/p51_input1.rdata")
