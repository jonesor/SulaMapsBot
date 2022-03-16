# sula maps twitter bot

# Twitter R package
# install.packages("rtweet")
# library(twitteR)
library(rtweet)
library(ggplot2)

# Create Twitter token
SulaMapsBot_token <- rtweet::create_token(
  app = "SulaMapsBot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET"),
  set_renv = FALSE
)

# Hash tags ----
alwaysHashTags <- paste0("#", c("artposter", "cartography", "minimalist", "maps", "poster"))
occasionalHashTags <- paste0("#", c("gift", "perfectgift", "present", "placemap"))

# Tweet with example art

# Randomly chosen
tweetMedia <- list.files(pattern = "jpeg", full.names = FALSE)
selectedMedia <- sample(tweetMedia, size = 1)
selectedMedia_fileName <- basename(selectedMedia)
mediaPlaceNames <- gsub(pattern = "_.*", replacement = "", x = selectedMedia_fileName)
(placeHashTags <- paste0("#", mediaPlaceNames))

textPhrases <- c("I love to make beautiful maps!",
                 "These stunning maps are designed in Denmark.", 
                 "Are you looking for an unusual gift?", 
                 "Looking for a reminder of a special place?", 
                 "Searching for some trendy wall decor?")
(tweetText <- 
    paste(sample(textPhrases, size = 1),"Check out my @etsy shop (link in bio).", sep = " ")
)

(hashTagText <- paste(
  c(
    paste(sample(alwaysHashTags, 3), collapse = " "),
    paste(sample(occasionalHashTags, 3), collapse = " "),
    paste(placeHashTags, collapse = " ")
  ),
  collapse = " "
))

(composedTweet <- paste0(c(tweetText, hashTagText), collapse = " "))


post_tweet(composedTweet, media = selectedMedia, token = SulaMapsBot_token)


