# sula maps twitter bot

# Twitter R package
# install.packages("rtweet")
# library(twitteR)
library(rtweet)
library(stringr)

# Create Twitter token
SulaMapsBot_token <- rtweet::create_token(
  app = "SulaMapsBot",
  consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET"),
  set_renv = FALSE
)

# Hash tags ----
alwaysHashTags <- paste0("#", c("artposter", "cartography", "minimalist", "maps", "poster"))
occasionalHashTags <- paste0("#", c("gift", "perfectgift", "present", "placemap"))

# Tweet with example art

# Randomly chosen image
tweetMedia <- list.files(path = "tweetImages", pattern = "jpeg", full.names = TRUE)
selectedMedia <- sample(tweetMedia, size = 2)
selectedMedia_fileName <- basename(selectedMedia)
selectedMedia_fileName <- gsub(pattern = " ", replacement = "", selectedMedia_fileName)
mediaPlaceNames <- unique(gsub(pattern = "_.*", replacement = "", x = selectedMedia_fileName))

# split hyphenated names into two
mediaPlaceNames <- unlist(str_split(mediaPlaceNames, pattern = "-"))
#
(placeHashTags <- paste0("#", mediaPlaceNames))

textPhrases <- c(
  "I love to make beautiful maps!",
  "These stunning maps are designed in Denmark.",
  "Are you looking for an unusual gift?",
  "Looking for a reminder of a special place?",
  "Searching for some trendy wall decor?",
  "What do you think of these posters? Would you like one for your town?",
    "Would you like one of these posters for YOUR town?",
    "Hi everyone! Would you like to see a poster for YOUR town?",
    "Hi everyone! Here's today's SulaMaps sample.",
    "Maps maps maps..."

)
(tweetText <-
  paste(sample(textPhrases, size = 1), "Check out my @etsy shop (link in bio).", sep = " ")
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
