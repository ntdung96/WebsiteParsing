#Load Rvest, Dplyr
install.packages('tidyverse')
library(rvest)
library(dplyr)

#Link 4 pages of bifa
url <- paste0('http://www.bifa.vn/hoi-vien?p=48&pagenumber=',1:4)

#Create empty dataset "dat"
dat <- data.frame(NULL, stringsAsFactors = FALSE)

#Scrape data into "Name" and "Link" column, and write to "dat" table
for (i in 1:4) {
    page <- read_html(url[i])
    Name <- page %>%
        html_nodes('.member-name a') %>%
        html_text()
    Link <- page %>%
        html_nodes('.member-name a') %>%
        html_attr('href')
    dat <- rbind(dat, data.frame(Name, Link))
}

#Remove the last row
dat <- dat[-171,]

#Scrape "Info" column using 170 links from "Link" column
dat$Info <- sapply(dat$Link, function(x) {
    read_html(x) %>%
        html_nodes('.member-info') %>%
        html_text()
})

#Write to a CSV file with UTF-8 encoding
write.csv(dat, file = 'bifa.csv', fileEncoding = 'UTF-8')
