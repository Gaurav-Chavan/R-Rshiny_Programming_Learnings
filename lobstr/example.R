library(lobstr)

# Abstract Syntax Trees
lobstr::ast(x<-1+2)

# Refrences to check memory utilization
x<- 1
y<-list(x,x)
z<- list(x,x,x)

ref(x,y,z)


#Object size
obj_size(x)
obj_size(y)
obj_size(z)


