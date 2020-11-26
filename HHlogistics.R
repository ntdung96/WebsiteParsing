library(rvest)

url1 <- paste0("https://www.vla.com.vn/tim-kiem-hoi-vien.html?membershipType=&companyName=&p=",c(1:45))

data <- data.frame(NULL, stringsAsFactors = FALSE)

for (i in 1:length(url1)) {
      file <- read_html(url1[i])
      Name <- html_nodes(file, "#content h4") %>%
            html_text(trim = TRUE)
      Address <- html_nodes(file, ".email:nth-child(1)") %>%
            html_text(trim = TRUE)
      Email <- html_nodes(file, ".email+ .email") %>%
            html_text(trim = TRUE)
      Website <- html_nodes(file, ".link") %>%
            html_text(trim = TRUE)
      Phone <- html_nodes(file, ".link+ .phone") %>%
            html_text(trim = TRUE)
      data <- rbind(data, data.frame(Name, Address, Email, Website, Phone))
}

write.csv(data, file = "HHLogistics.csv", fileEncoding = "UTF-8")