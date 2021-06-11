library(Rcrawler)
# # temp1 <- Rcrawler(Website = "https://www.flipkart.com/mobiles/pr?sid=tyy,4io&marketplace=FLIPKART",
# #          no_cores = 2, no_conn = 2,MaxDepth = 1,
# #          ExtractCSSPat = c("_3wU53n ","_1uv9Cb "),
# #          PatternsNames =c("Title","Price"), 
# #          ManyPerPattern = TRUE)
# 
# Rcrawler(Website = "https://www.flipkart.com/mobiles/pr?sid=tyy%2C4io&marketplace=FLIPKART&otracker=product_breadCrumbs_Mobiles&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DMi", 
#          no_cores = 2, no_conn = 2,MaxDepth = 1, 
#          ExtractCSSPat  = c("._3wU53n","_6BWGkk","_3ULzGw","hGSR34"), 
#          PatternsNames = c("Title","Price","Description","Rating"))
# 
# df<-data.frame(do.call("rbind", DATA))




# For a Single Record ----
Data <- ContentScraper(Url = "https://www.flipkart.com/mobiles/pr?sid=tyy%2C4io&marketplace=FLIPKART&otracker=product_breadCrumbs_Mobiles&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DMi",
                      CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34")
                     ) 

df<-data.frame(do.call("rbind", Data))


# For a Multiple Record in a single Page ----
Data <- ContentScraper(Url = "https://www.flipkart.com/mobiles/pr?sid=tyy%2C4io&marketplace=FLIPKART&otracker=product_breadCrumbs_Mobiles&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DMi",
                       CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
                       ManyPerPattern = T
) 

df<-data.frame(do.call("rbind", Data))


# Filtering Urls to be crawled and collected by Regular expression ----
Rcrawler(Website = "https://www.flipkart.com/mobiles", 
         no_cores = 2, 
         no_conn = 2,MaxDepth = 1,
            
         crawlUrlfilter ="/mi~brand/",
         ExtractCSSPat = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
         PatternsNames =c("Title","Price","Description","Rating")
         )

df<-data.frame(do.call("rbind", DATA))



# For Flipkart ----
# Brand Mi ----
# listURLs<-c("https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy,4io&otracker=nmenu_sub_Electronics_0_Mi",
#             "https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy%2C4io&otracker=nmenu_sub_Electronics_0_Mi&page=2",
#             "https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy%2C4io&otracker=nmenu_sub_Electronics_0_Mi&page=3",
#             "https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy%2C4io&otracker=nmenu_sub_Electronics_0_Mi&page=4",
#             "https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy%2C4io&otracker=nmenu_sub_Electronics_0_Mi&page=5",
#             "https://www.flipkart.com/mobiles/mi~brand/pr?sid=tyy%2C4io&otracker=nmenu_sub_Electronics_0_Mi&page=6"
#             )
# 
# Mi_Data <- ContentScraper(Url = listURLs,
#                           CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
#                           PatternsName = c("Title","Price","Description","Rating"),
#                           ManyPerPattern = TRUE)
# 
# VecTitle <- unlist(lapply(Mi_Data, `[[`, 1))
# VecPrice <- unlist(lapply(Mi_Data, `[[`, 2))
# VecDescription<- unlist(lapply(Mi_Data, `[[`, 3))
# VecRating<- unlist(lapply(Mi_Data, `[[`, 4))




# Mi Brand Version 2 Stable ----

Final_Data <- data.frame(Title=character(0), Price = character(0),Description = character(0),Rating = character(0),stringsAsFactors = F)

for (x in listURLs)
{
Data <- ContentScraper(Url = x,
                       CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
                       ManyPerPattern = T
                       ) 

df1 <- data.frame(do.call("cbind", Data))
names(df1) <- c("Title","Price","Description","Rating")
df1$Title <- as.character(df1$Title)
df1$Price <- as.character(df1$Price)
df1$Description <- as.character(df1$Description)
df1$Rating <- as.character(df1$Rating)

Final_Data <- rbind(Final_Data,df1)
}



# Samsung_Brand  Stable ----
rm(Data,df1)
Final_Data_Samsung <- data.frame(Title=character(0), Price = character(0),Description = character(0),Rating = character(0),stringsAsFactors = F)

listURLs1 <- c("https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=2",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=3",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=4",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=5",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=6",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=7",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=8",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=9",
              "https://www.flipkart.com/search?p%5B%5D=facets.brand%255B%255D%3DSamsung&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&page=10"
              )



for (x in listURLs1)
{
  Data <- ContentScraper(Url = x,
                         CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
                         ManyPerPattern = T
  ) 
  
  df1 <- data.frame(do.call("cbind", Data))
  names(df1) <- c("Title","Price","Description","Rating")
  df1$Title <- as.character(df1$Title)
  df1$Price <- as.character(df1$Price)
  df1$Description <- as.character(df1$Description)
  df1$Rating <- as.character(df1$Rating)
  
  Final_Data_Samsung <- rbind(Final_Data_Samsung,df1)
}

Final_Data <- rbind(Final_Data,Final_Data_Samsung)
rm(Final_Data_Samsung,Data,df1)


#  Apple Mobiles ----
Final_Data_Apple <- data.frame(Title=character(0), Price = character(0),Description = character(0),Rating = character(0),stringsAsFactors = F)

listURLs1 <- c(
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.brand%255B%255D%3DApple&p%5B%5D=facets.serviceability%5B%5D%3Dfalse",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.brand%255B%255D%3DApple&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&page=2",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.brand%255B%255D%3DApple&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&page=3",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.brand%255B%255D%3DApple&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&page=4"
  )



for (x in listURLs1)
{
  Data <- ContentScraper(Url = x,
                         CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
                         ManyPerPattern = T
  ) 
  
  df1 <- data.frame(do.call("cbind", Data))
  names(df1) <- c("Title","Price","Description","Rating")
  df1$Title <- as.character(df1$Title)
  df1$Price <- as.character(df1$Price)
  df1$Description <- as.character(df1$Description)
  df1$Rating <- as.character(df1$Rating)
  
  Final_Data_Apple <- rbind(Final_Data_Apple,df1)
}

Final_Data <- rbind(Final_Data,Final_Data_Apple)
rm(Final_Data_Apple,Data,df1)



#  Apple Mobiles ----
Final_Data_nOKIA <- data.frame(Title=character(0), Price = character(0),Description = character(0),Rating = character(0),stringsAsFactors = F)

listURLs1 <- c(
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DNokia",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DNokia&page=2",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DNokia&page=3",
  "https://www.flipkart.com/search?p%5B%5D=facets.availability%255B%255D%3DExclude%2BOut%2Bof%2BStock&sid=tyy%2F4io&sort=recency_desc&wid=1.productCard.PMU_V2_1&p%5B%5D=facets.serviceability%5B%5D%3Dfalse&p%5B%5D=facets.brand%255B%255D%3DNokia&page=4"
  )



for (x in listURLs1)
{
  Data <- ContentScraper(Url = x,
                         CssPatterns = c("._3wU53n","._1vC4OE._2rQ-NK","._3ULzGw",".hGSR34"),
                         ManyPerPattern = T
  ) 
  
  df1 <- data.frame(do.call("cbind", Data))
  names(df1) <- c("Title","Price","Description","Rating")
  df1$Title <- as.character(df1$Title)
  df1$Price <- as.character(df1$Price)
  df1$Description <- as.character(df1$Description)
  df1$Rating <- as.character(df1$Rating)
  
  Final_Data_nOKIA <- rbind(Final_Data_nOKIA,df1)
}

Final_Data <- rbind(Final_Data,Final_Data_nOKIA)
rm(Final_Data_nOKIA,Data,df1)


write.csv(Final_Data,"Flipkart_Mobile.csv",row.names = F)

