#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Gaurav's Plumber API Example

#* Echo back the input
#* @param name The message to echo
#* @get /echo
function(name= "") {
    list(name = paste0("Your Name is : '", name, "'"))
}

#* Plot a histogram
#* @png
#* @get /plot
function() {
    rand <- rnorm(100)
    hist(rand)
}

#* Return the sum of three numbers
#* @param a The first number to add
#* @param b The second number to add
#* @param c The third number to add
#* @post /sum
function(a, b, c) {
    as.numeric(a) + as.numeric(b) + as.numeric(c)
}
