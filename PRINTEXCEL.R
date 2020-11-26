school = unique(ds$school_name.x)
ds <- ds[,-1]
##
wb <- createWorkbook(type="xlsx")

title_style <- CellStyle(wb) + Font(wb, heightInPoints = 10, isBold = TRUE) + Alignment(horizontal = "ALIGN_CENTER")

colname_style <- CellStyle(wb) + Font(wb, isBold = TRUE) + Alignment(wrapText = TRUE)

sheet <- createSheet(wb)
addMergedRegion(sheet, 1, 1, 1, ncol(ds))

rows <- createRow(sheet,rowIndex = 1)
sheetTitle <-createCell(rows, colIndex=1)
setCellValue(sheetTitle[[1,1]], value = paste0("Danh sách học sinh tham gia khảo sát dự án Chăm sóc Mắt 2016 - 2017 \n",
                                               "trường ", school))
setCellStyle(sheetTitle[[1,1]], cellStyle = title_style)

names(ds) <- c("Tên học sinh", "Lớp", "Tên phụ huynh", "Điện thoại",
               "Giáo viên chủ nhiệm", "Trường hiện tại", "Lớp hiện tại")

addDataFrame(ds, sheet, startRow = 2, startColumn = 1,
             colnamesStyle = colname_style)

autoSizeColumn(sheet, colIndex = 1:ncol(ds))

saveWorkbook(wb, paste0(school, ".xlsx"))