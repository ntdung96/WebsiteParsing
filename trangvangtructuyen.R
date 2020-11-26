library(rvest)

url <- paste0("http://trangvangtructuyen.vn/tim-kiem/Máy-Lọc-Nước/Hồ-Chí-Minh/", c(1:10),"/")

data <- data.frame(NULL, stringsAsFactors = FALSE)
for (i in 1:length(url)) {
      fl <- read_html(url[i])
      Name <- fl %>%
            html_nodes("h2") %>%
            html_text()
      Addr <- fl %>%
            html_nodes(".diachi") %>%
            html_text(trim = TRUE)
      Phone1 <- vector(mode = "character", length = 15L)
      Phone2 <- vector(mode = "character", length = 15L)
      Email <- vector(mode = "character", length = 15L)
      Website <- vector(mode = "character", length = 15L)
      for (k in c(1:15)) {
            Phone1[k] <- fl %>%
                  html_nodes(paste0(".col-sm-12:nth-child(",k+1L,") ",".glyphicon-phone-alt+ p")) %>%
                  html_text()
            Phone2[k] <- fl %>%
                  html_nodes(paste0(".col-sm-12:nth-child(",k+1L,") ",".glyphicon-print+ p")) %>%
                  html_text()
            Email[k] <- fl %>%
                  html_nodes(paste0(".col-sm-12:nth-child(",k+1L,") ",".glyphicon-envelope+ p a")) %>%
                  html_text()
            Website[k] <- fl %>%
                  html_nodes(paste0(".col-sm-12:nth-child(",k+1L,") ",".glyphicon-globe+ p a")) %>%
                  html_text()
      }
      data <- rbind(data, data.frame(Name,Addr,Phone1,Phone2,Email,Website))
      print(i)
}
write.csv(data, "maylocnuoc_hcm.csv", fileEncoding = "utf-8")