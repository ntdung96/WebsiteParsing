## Scrape a list of websites and get email addresses

library(xml2)
library(rvest)
library(stringr)

url <- read.csv("HH_BDS_draft.csv", stringsAsFactors = FALSE)$WEBSITE
url[-grep("^http", url)] <-paste0("http://", url[-grep("^http", url)])

email <- character(length = 231)

for (i in which(email=="")){
      tryCatch({
            if(url[i] == ""){
                  email[i] <- NA
            } else {
                  pg <- read_html(url[i], options = c("NOERROR", "NONET"))
                  h <- html_text(html_nodes(pg, "body"))
                  if(length(h)==0) {
                        result <- NA
                  } else {
                        result <- unique(str_match_all(h, "(+.*@.*)")[[1]][,2])
                  }
                  email[i] <- ifelse(length(result)==0, NA, result)
            }
      }, error=function(e){})
}
