A <- matrix(c( 6, 1,+ 0, -3,-1, 2),3, 2, byrow = TRUE) 
B <- matrix(c( 4, 2,0, 1,-5, -1),3, 2, byrow = TRUE) 
A
B
v=c(1.2,3.5,.79,25)
rownames(A)=c("row1","row2","row3")
colnames(A)=c("col1","col2")
A
A + B #summation of two matrices
t(A) # Transpose

######
# Swirl
# install.packages("swirl")
library(swirl)   

#####
# Reading data
drug.table<-read.table("drug.txt",header = TRUE)
drug.table

military<-read.csv2("MilitaryExpenses copy.csv",sep = ',', header = T)
mil<-read.csv2("MilitaryExpenses copy.csv")
rm(mil)
mil2<-read.csv2("MilitaryExpenses copy.csv", header = T)
rm(mil2)

# read.delim() for Delimited Files
# The read.delim function is typically used to read in delimited text files,
# where data is organized in a data
# matrix with rows representing cases and columns representing variables.

d=read.delim("annual.txt", header=TRUE, sep="\t") 
   
# Reading Data
##### 
#Creating data.frame

people <-c("Kim","Bob","Ted","Sue","Liz","Amanada","Tricia","Johnathan","Luis","Isabel")
gender<-c("m","m","m","f","f","f","f","f","m","f")
scores <-c(17,19,24,25,16,15,23,24,29,17)
quiz_scores <- data.frame(people,gender,scores) #to create a data frame
quiz_scores
head(quiz_scores)





