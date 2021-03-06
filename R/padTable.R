#'@title pad a table in mono text
#'@description create a simple text table
#'@param data a data.frame with character data only. 
#'If \code{row.names} are present, they will be injected 
#'into the table output. 
#'@param align a character vector of length 1 or of equal length to the 
#'number of columns in \code{data}
#'@param space a numeric vector of length 1 or of equal length to the 
#'number of columns in \code{data}. Used to layout the table. Is nchar 
#'width of a single column
#'@return a character output for the table
#'@examples
#'rwNames <- c(character(0),'MAXIMUM INSTANTANEOUS DISCHARGE AND CORRESPONDING Gage height',
#''MINIMUM INSTANTANEOUS DISCHARGE AND CORRESPONDING Gage height')
#'df <- data.frame('DATE'=c("-----","06/01/2013", "01/29/2013"), 
#'                 'HH:MM:SS' = c("-----",'21:30:00','13:15:00'),
#'                 '(CFS)' = c("-----","457000","26600"), 
#'                 '(CMS)' = c("-----",'13000', '753'),
#'                 '(FT)' = c("-----",'33.14','0.93'),
#'                 '(M)' = c("-----",'10.10', '0.28'),
#'                 stringsAsFactors = FALSE, check.names = FALSE,
#'                 row.names = rwNames)
#'cat(padTable(df))
#'@export
padTable <- function(data, align = 'left', space = 16){
  table <- ""
  if (length(align) != 1 | length(space) != 1) 
    stop('multi length args for align or space are not yet supported')
  if (align != 'left') stop(align, ' not yet supported')
  
  buffer <- paste0("%-",space,'s') # negative sign for left align
  
  # for headers --
  baseChar <- sprintf(buffer, vector(mode = 'character', length=ncol(data)))
  substring(baseChar, 1) <- names(data)
  flatRow <- paste(baseChar, collapse='')
  table <- paste(table,flatRow,'\n', collapse = '')
  
  for (i in 1:nrow(data)){
    baseChar <- sprintf(buffer, vector(mode = 'character', length=ncol(data)))
    substring(baseChar, 1) <- as.character(data[i,])
    flatRow <- paste(baseChar, collapse='')
    if (row.names(data[i,]) != " "){
      table <- paste(table, row.names(data[i,]),'\n', collapse = '')
    }
    table <- paste(table,flatRow,'\n', collapse = '')
  }
  
  
  return(table)
}