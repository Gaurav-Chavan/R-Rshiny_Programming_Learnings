#----------------- Important Libraries --------------------------#
# 1. devtools
# 2. rayshader
# 3. ggplot2
# 4. tidyverse
# 5. reshape


#Install Libraries
devtools::install_github("tylermorganwall/rayshader")

library(rayshader)

library(ggplot2)



#----------------- Example 1  Plotting Contours --------------------------------#
library(reshape2)
#Contours and other lines will automatically be ignored. Here is the volcano dataset:

ggvolcano = volcano %>% 
  melt() %>%
  ggplot() +
  geom_tile(aes(x = Var1, y = Var2, fill = value)) +
  geom_contour(aes(x = Var1, y = Var2, z = value), color = "black") +
  scale_x_continuous("X", expand = c(0, 0)) +
  scale_y_continuous("Y", expand = c(0, 0)) +
  scale_fill_gradientn("Z", colours = terrain.colors(10)) +
  coord_fixed()

par(mfrow = c(1, 2))
plot_gg(ggvolcano, width = 7, height = 4, raytrace = FALSE, preview = TRUE)

plot_gg(ggvolcano, multicore = TRUE, raytrace = TRUE, width = 7, height = 4, 
        scale = 300, windowsize = c(1400, 866), zoom = 0.6, phi = 30, theta = 30)



#------------------------ Example 2 : Scatter Plot  -------------------------------------#
mtplot = ggplot(mtcars) + 
  geom_point(aes(x = mpg, y = disp, color = cyl)) + 
  scale_color_continuous(limits = c(0, 8))

plot_gg(mtplot, width = 3.5, multicore = TRUE, windowsize = c(800, 800), 
        zoom = 0.85, phi = 35, theta = 30, sunangle = 225, soliddepth = -100)




#------------------ Example 3 : Density Plot ------------------------------------#
library(tidyverse)


faithful_dd <- ggplot(faithfuld, aes(waiting, eruptions)) +
  geom_raster(aes(fill = density)) +
  ggtitle("3D Plotting in R from 2D_ggplot_graphics") +
  labs(caption = "Package: rayshader") +
  theme(axis.text = element_text(size = 12),
        title = element_text(size = 12,face="bold"),
        panel.border= element_rect(size=2,color="black",fill=NA))  

faithful_dd


plot_gg(faithful_dd, multicore = TRUE, width = 8, height = 8, scale = 300, 
        zoom = 0.6, phi = 60,
        background = "#afceff",shadowcolor = "#3a4f70")









