# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 1
df1 <- read.table(text=
"frame X1 X2 X3
1 0 0 0
2 10 15 0
3 15 10 0
4 15 10 0
", header=T)

df2 <- read.table(text=
"frame X1 X2 X3
1 0 0 0
2 14.53 12.57 0
3 13.90 14.65 0
4 14.10 14.70 0
", header=T)


write.csv(df1, "data-raw/p27_input1.csv", row.names=FALSE)
write.csv(df2, "data-raw/p27_input2.csv", row.names=FALSE)

d1=gather(df1,pos,carid,X1,X2,X3)
d2=gather(df2,pos,speed,X1,X2,X3)
df3=inner_join(d1,d2)
df4=filter(df3,carid != 0)
df_out = arrange(df4,carid,frame)

write.csv(df_out, "data-raw/p27_output1.csv", row.names=FALSE)

p27_output1 <- read.csv("data-raw/p27_output1.csv", check.names = FALSE)
fctr.cols <- sapply(p27_output1, is.factor)
int.cols <- sapply(p27_output1, is.integer)

p27_output1[, fctr.cols] <- sapply(p27_output1[, fctr.cols], as.character)
p27_output1[, int.cols] <- sapply(p27_output1[, int.cols], as.numeric)
save(p27_output1, file = "data/p27_output1.rdata")

p27_input1 <- read.csv("data-raw/p27_input1.csv", check.names = FALSE)
fctr.cols <- sapply(p27_input1, is.factor)
int.cols <- sapply(p27_input1, is.integer)

p27_input1[, fctr.cols] <- sapply(p27_input1[, fctr.cols], as.character)
p27_input1[, int.cols] <- sapply(p27_input1[, int.cols], as.numeric)
save(p27_input1, file = "data/p27_input1.rdata")


p27_input2 <- read.csv("data-raw/p27_input2.csv", check.names = FALSE)
fctr.cols <- sapply(p27_input2, is.factor)
int.cols <- sapply(p27_input2, is.integer)

p27_input2[, fctr.cols] <- sapply(p27_input2[, fctr.cols], as.character)
p27_input2[, int.cols] <- sapply(p27_input2[, int.cols], as.numeric)
save(p27_input2, file = "data/p27_input2.rdata")
