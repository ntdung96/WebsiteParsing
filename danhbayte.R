library(rvest)
library(readxl)

DSPhongkham <- read_excel("~/Downloads/DSlinkphngkhamDung.xlsx", stringAsFactors = FALSE)

dat <- data.frame(NULL, stringsAsFactors = FALSE)
for (i in 1:10446) {
      fl <- read_html(DSPhongkham$...1[i])
      Name <- fl %>%
            html_nodes("h1") %>%
            html_text()
      Phone <- fl %>%
            html_nodes(".col-md-6 div:nth-child(2)") %>%
            html_text()
      Addr <- fl %>%
            html_nodes(".col-xs-12.col-md-12 div:nth-child(1)") %>%
            html_text()
      Time <- fl %>%
            html_nodes(".col-md-6 div:nth-child(3)") %>%
            html_text()
      Type <- fl %>%
            html_nodes(".col-md-6 div:nth-child(4)") %>%
            html_text()
      Cert <- fl %>%
            html_nodes(".col-md-6 div:nth-child(5)") %>%
            html_text()
      Resp <- fl %>%
            html_nodes(".col-md-6 div:nth-child(6)") %>%
            html_text()
      Phamvi <- fl %>%
            html_nodes(".col-xs-12 div:nth-child(7)") %>%
            html_text()
      dat <- rbind(dat, data.frame(Name, Phone,Addr,Time,Type, Cert, Resp,Phamvi))
      print(i)
}

write.csv2(data, "phongkham_10446.csv", fileEncoding = "utf-8")