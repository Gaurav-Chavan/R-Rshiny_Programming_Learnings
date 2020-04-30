# Import Libraries ---
library(tidyverse)
library(DT)
library(devtools)
devtools::install_github("renanxcortes/springerQuarantineBooksR")
library(springerQuarantineBooksR)


#Download all books at once 8 GB

#setwd("path_of_your_choice") # where you want to save the books
#download_springer_book_files() # download all of them at once


# Create a table of Springer books ---


springer_table <- download_springer_table()


# Use DT ----
springer_table$open_url <- paste0(
  '<a target="_blank" href="', # opening HTML tag
  springer_table$open_url, # href link
  '">SpringerLink</a>' # closing HTML tag
)
springer_table <- springer_table[, c(1:3, 19, 20)] # keep only relevant information
datatable(springer_table,
          rownames = FALSE, # remove row numbers
          filter = "top", # add filter on top of columns
          extensions = "Buttons", # add download buttons
          options = list(
            autoWidth = TRUE,
            dom = "Blfrtip", # location of the download buttons
            buttons = c("copy", "csv", "excel", "pdf", "print"), # download buttons
            pageLength = 5, # show first 5 entries, default is 10
            order = list(0, "asc") # order the title column by ascending order
          ),
          escape = FALSE # make URLs clickable
)


# Download only specific books  basis Title ---

download_springer_book_files(
  springer_books_titles = c(
    "A Beginner's Guide to R",
    "All of Statistics",
    "An Introduction to Machine Learning",
    "An Introduction to Statistical Learning",
    "Applied Multivariate Statistical Analysis",
    "Applied Linear Algebra",
    "Applied Predictive Modeling",
    "Bayesian Essentials with R",
    "Business Process Management Cases",
    "Computer Vision",
    "Data Analysis",
    "Data Science and Predictive Analytics",
    "Introduction to Deep Learning",
    "Neural Networks and Deep Learning",
    "Probability and Statistics for Computer Science",
    "Understanding Statistics Using R"
  )
)

