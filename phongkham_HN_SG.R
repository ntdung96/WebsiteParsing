library(rvest)

url <- paste0("https://timbenhvien.vn/tim-kiem/thanh-pho-ho-chi-minh/trang:",
              c(1:286))

data <- data.frame(NULL, stringsAsFactors = FALSE)
for (i in 1:length(url)) {
      fl <- read_html(url[i])
      Name <- fl %>%
            html_nodes(".pc-display a") %>%
            html_text()
      Addr1 <- fl %>%
            html_nodes(".tb_add tr:nth-child(1) td") %>%
            html_text()
      Addr <- subset(Addr1, !startsWith(Addr1, "\r\n\t"))
      data <- rbind(data, data.frame(Name,Addr))
      print(i)
}

write.csv(data, "phongkham_SG.csv", fileEncoding = "utf-8")

###

url_hn <- paste0("https://timbenhvien.vn/tim-kiem/thanh-pho-ha-noi/trang:",
              c(1:123))

data_hn <- data.frame(NULL, stringsAsFactors = FALSE)

for (j in 1:length(url_hn)) {
      fl_hn <- read_html(url_hn[j])
      Name_hn <- fl_hn %>%
            html_nodes(".pc-display a") %>%
            html_text()
      Addr1_hn <- fl_hn %>%
            html_nodes(".tb_add tr:nth-child(1) td") %>%
            html_text()
      Addr_hn <- subset(Addr1_hn, !startsWith(Addr1_hn, "\r\n\t"))
      data_hn <- rbind(data_hn, data.frame(Name_hn,Addr_hn))
      print(j)
}

write.csv(data_hn, "phongkham_HN.csv", fileEncoding = "utf-8")