# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
dat <- read.table(text=
"
CA DATE_1    TIME_1   ENTRIES_1  DATE_2    TIME_2     ENTRIES_2  
A002 07-27-13 00:00:00 4209603 07-27-13 08:00:00   4209663 
A002 07-28-13 08:00:00 4210490 07-28-13 16:00:00   4210775 
A002 07-29-13 16:00:00 4211586 07-30-13 00:00:00   4212845 
", header=T) %>% add_rownames()

write.csv(dat, "data-raw/p33_input1.csv", row.names=FALSE)

df_out = dat %>% 
    # gather to long form
    gather(var, val, -rowname, -CA) %>% 
    # separate ID suffix from variable name by position
    separate(var, c('varNew', 'id')) %>% 
    # spread back to wide form
    spread(varNew, val) %>% 
    # clean up extra columns
    select(-rowname, -id)

write.csv(df_out, "data-raw/p33_output1.csv", row.names=FALSE)

p33_output1 <- read.csv("data-raw/p33_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p33_output1, is.factor)
int.cols <- sapply(p33_output1, is.integer)

p33_output1[, fctr.cols] <- sapply(p33_output1[, fctr.cols], as.character)
p33_output1[, int.cols] <- sapply(p33_output1[, int.cols], as.numeric)
save(p33_output1, file = "data/p33_output1.rdata")

p33_input1 <- read.csv("data-raw/p33_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p33_input1, is.factor)
int.cols <- sapply(p33_input1, is.integer)

p33_input1[, fctr.cols] <- sapply(p33_input1[, fctr.cols], as.character)
p33_input1[, int.cols] <- sapply(p33_input1[, int.cols], as.numeric)
save(p33_input1, file = "data/p33_input1.rdata")
