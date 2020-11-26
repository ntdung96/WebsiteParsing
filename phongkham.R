library(rvest)

url <- paste0("https://thongtindoanhnghiep.co/tim-kiem?location=&kwd=phong+kham+da+khoa&p=", c(1:101))

data <- data.frame(NULL, stringsAsFactors = FALSE)
for (i in 1:length(url)) {
      fl <- read_html(url[i])
      Name <- fl %>%
            html_nodes("h2 a") %>%
            html_text()
      Prov <- fl %>%
            html_nodes(".col-md-4 a strong") %>%
            html_text()
      Addr <- fl %>%
            html_nodes(".row+ p strong") %>%
            html_text()
      data <- rbind(data, data.frame(Name, Prov,Addr))
      print(i)
}
write.csv(data, "phongkham.csv", fileEncoding = "utf-8")