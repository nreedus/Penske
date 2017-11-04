library(twitteR)
library(RCurl)
devtools::install_version("httr", version="1.0.0", repos="http://cran.us.r-project.org")

consumer_key <- "gxbWcq1qf8vjIEqLKAhwGdZ6U"
consumer_secret <- " nVN4uc3RPwus9DATGaftonnzzxZVGvdyt4HmkSenQV0BzFplel"
access_token <- " 767450717116329984-5yfA7y2LokN2LNIchlZioP1FWkXYmIm"
access_secret <- " nKXpuc0BIw9MPDHaRNsgSn3QIA6pbh8OJQuhqln8KYHtX"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
1

Penske_tweets <- searchTwitter("Penske", n=10)


