library(plyr)
library(animation)


x <-  runif(50) # generating 50 random numbers
x

y <-  runif(50) # generating 50 random numbers 
y

data <- cbind(x,y) 
data

plot(data) # scatter plot

km <- kmeans(data,4) #kmeans clustering
str(km)

# Create animation ----
km <- kmeans.ani(data,4) #kmeans clustering animation
