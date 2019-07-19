library(flextable)
library(officer)

myft <- flextable(
  head(mtcars), 
  col_keys = c("am", "carb", "gear", "mpg", "drat" ))
myft

# themes 
myft <- theme_vanilla(myft)
myft

# Layout
# Table layout can be modified. One can add or change header/footer rows,
# change cells height and width and merge cells.

myft <- merge_v(myft, j = c("am", "carb") )
myft <- set_header_labels( myft, carb = "# carb." )
myft <- autofit(myft)
myft


# Formatting

myft <- italic(myft, j = 1)
myft <- bg(myft, bg = "#C90000", part = "header")
myft <- color(myft, color = "white", part = "header")
myft <- color(myft, ~ drat > 3.5, ~ drat, color = "red")
myft <- bold(myft, ~ drat > 3.5, ~ drat, bold = TRUE)
myft <- autofit(myft)
myft