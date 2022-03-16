# sula maps twitter bot

# Twitter R package
# install.packages("rtweet")
# library(twitteR)
library(rtweet)

# Create Twitter token
SulaMapsBot_token <- rtweet::create_token(
  app = "SulaMapsBot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# Hash tags ----
alwaysHashTags <- paste0("#", c("artposter", "cartography", "minimalist", "maps", "poster"))
occasionalHashTags <- paste0("#", c("gift", "perfectgift", "present", "weddingpresent"))

# Tweet with example art

# Randomly chosen
tweetMedia <- list.files(path = file.path("tweetImages"), full.names = TRUE)
selectedMedia <- sample(tweetMedia, size = 2)
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

#selectedMedia_gh <- file.path("https://raw.githubusercontent.com/jonesor/sulamaps/main",selectedMedia)

# Download the image to a temporary location
#temp_file <- tempfile()
#download.file(selectedMedia_gh[1], temp_file)

(composedTweet <- paste0(c(tweetText, hashTagText), collapse = " "))

post_tweet(composedTweet, media = selectedMedia, token = SulaMapsBot_token)

