pacman::p_load(arules, arulesViz,RColorBrewer)

data("Groceries")

head(Groceries@itemInfo,n=12)

head(Groceries@data)

data <- list(
  c("a","b","c"),
  c("a","b"),
  c("a","b","d"),
  c("b","e"),
  c("b","c","e"),
  c("a","d","e"),
  c("a","c"),
  c("a","b","d"),
  c("c","e"),
  c("a","b","d","e"),
  c("a",'b','e','c')
)
data <- as(data, "transactions")


inspect(data)

#Convert transactions to transaction ID lists ----

tl <- as(data, "tidLists")
inspect(tl)


summary(Groceries)


rules <- apriori(Groceries,parameter = list(supp = 0.001, conf = 0.80))


inspect(rules[1:10])

# The Item Frequency Histogram ----

arules::itemFrequencyPlot(Groceries,topN=20,col=brewer.pal(8,'Pastel2'),main='Relative Item Frequency Plot',type="relative",ylab="Item Frequency (Relative)")


plot(rules[1:20],method = "graph",control = list(type = "items"))

# The size of graph nodes is based on support levels and the colour on lift ratios. 
# The incoming lines show the Antecedants or the LHS and the RHS is represented by names of items. 


# Individual Rule Representation ----
# The next plot offers us a parallel coordinate system of visualisation.
# It would help us clearly see that which products along with which ones, result in what kinds of sales


plot(rules[1:20],method = "paracoord",control = list(reorder = TRUE))



# Interactive Scatterplot ----

# These plots show us each and every rule visualised into a form of a scatterplot. 
# The confidence levels are plotted on the Y axis and Support levels on the X axis for each rule. 
# We can hover over them in our interactive plot to see the rule.


arulesViz::plotly_arules(rules)