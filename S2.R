# making table data sets
library(dplyr)
library(tidyr)
library(MorpheusData)

#############benchmark 43
class <- read.table(text=
"C_name F_key
class1 f1
class2 f2
class3 f1
class4 f3
class5 f4
class6 f1", header=T)

enroll <- read.table(text=
"S_key C_name
S1 class2
S2 class1
S3 class2
S3 class5
S4 class2
S4 class4
S5 class4
S6 class3
S6 class2
S7 class5
S7 class1
S8 class4
S9 class5
S9 class2
S10 class5",header=T)

faculty <- read.table(text=
"F_key F_name
f1 faculty1
f2 faculty2
f3 faculty3
f4 faculty4",header=T)

student <- read.table(text=
"S_key major age
S1 History 20
S2 Computer 21
S3 Computer 23
S4 Math 18
S5 History 22
S6 Math 22
S7 English 21
S8 English 23
S9 History 21
S10 History 22",header=T)

# write.csv(class, "sql/class.csv", row.names=FALSE)
# write.csv(enroll, "sql/enroll.csv", row.names=FALSE)
# write.csv(faculty, "sql/faculty.csv", row.names=FALSE)
# write.csv(student, "sql/student.csv", row.names=FALSE)


# enroll <- read.csv("sql/enroll.csv", check.names = FALSE)
# fctr.cols <- sapply(enroll, is.factor)
# int.cols <- sapply(enroll, is.integer)
# enroll[, fctr.cols] <- sapply(enroll[, fctr.cols], as.character)
# enroll[, int.cols] <- sapply(enroll[, int.cols], as.numeric)
# save(enroll, file = "sql/enroll.rdata")

# faculty <- read.csv("sql/faculty.csv", check.names = FALSE)
# fctr.cols <- sapply(faculty, is.factor)
# int.cols <- sapply(faculty, is.integer)
# faculty[, fctr.cols] <- sapply(faculty[, fctr.cols], as.character)
# faculty[, int.cols] <- sapply(faculty[, int.cols], as.numeric)
# save(faculty, file = "sql/faculty.rdata")

# student <- read.csv("sql/student.csv", check.names = FALSE)
# fctr.cols <- sapply(student, is.factor)
# int.cols <- sapply(student, is.integer)
# student[, fctr.cols] <- sapply(student[, fctr.cols], as.character)
# student[, int.cols] <- sapply(student[, int.cols], as.numeric)
# save(student, file = "sql/student.rdata")

# class <- read.csv("sql/class.csv", check.names = FALSE)
# fctr.cols <- sapply(class, is.factor)
# int.cols <- sapply(class, is.integer)
# class[, fctr.cols] <- sapply(class[, fctr.cols], as.character)
# class[, int.cols] <- sapply(class[, int.cols], as.numeric)
# save(class, file = "sql/class.rdata")

input=inner_join(class,enroll) %>% 
inner_join(faculty) %>% 
inner_join(student) 
write.csv(input, "data-raw/s2_input1.csv", row.names=FALSE)
s2_input1 <- read.csv("data-raw/s2_input1.csv", check.names = FALSE)
fctr.cols <- sapply(s2_input1, is.factor)
int.cols <- sapply(s2_input1, is.integer)
s2_input1[, fctr.cols] <- sapply(s2_input1[, fctr.cols], as.character)
s2_input1[, int.cols] <- sapply(s2_input1[, int.cols], as.numeric)
save(s2_input1, file = "data/s2_input1.rdata")

output=input %>% filter (F_name == "faculty1" | major == "History") %>% summarize(age = max(age))
write.csv(output, "data-raw/s2_output1.csv", row.names=FALSE)
s2_output1 <- read.csv("data-raw/s2_output1.csv", check.names = FALSE)
fctr.cols <- sapply(s2_output1, is.factor)
int.cols <- sapply(s2_output1, is.integer)
s2_output1[, fctr.cols] <- sapply(s2_output1[, fctr.cols], as.character)
s2_output1[, int.cols] <- sapply(s2_output1[, int.cols], as.numeric)
save(s2_output1, file = "data/s2_output1.rdata")

# 5.1.2
inner_join(class,enroll) %>% 
inner_join(faculty) %>% 
inner_join(student) %>% 
filter (F_name == "faculty1" | major == "History") %>%
summarize(age = max(age))
