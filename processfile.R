filepath <- "~/GIT/EDA/household_power_consumption.txt"

myrbind <- function(x, ..., template=x) {
      do.call(rbind, c(list(template[1,]), list(x), list(...)))[-1,]
}


processFile = function(filepath, limit = 5000000) {
      con = file(filepath, "r")
      lineN = 0;   #index to keep track
      HPC <- data.frame(stringsAsFactors=FALSE)
      
      while ( TRUE ) { #keep doing this untill you encounter break
            lineN = lineN + 1; # increment the index
            print(paste("Line: ", lineN)) #print line number for debbuging
            line = unlist(strsplit(readLines(con, n = 1),";")) #read a line and convert to list of chars
           # print(line[1]) # print the time stamp
            if(lineN == 1){ #the first line contains names
                  print("Naming") #message me
                  names <- line
                  for (i in 1:length(names)){
                        HPC[,names[i]] <- character()   
                  }
            }
            if (lineN != 1 & unlist(strsplit(line,";"))[1] %in% c(c("1/2/2007", "2/2/2007"))){
                  newLine <- unlist(strsplit(line,";"))
                  names(newLine) <- names
                  print(newLine)
                  print("")
                  HPC <- myrbind(HPC,newLine)
            }
            
            if ( length(line) == 0 ) {
                  print("breaking on total")
                  break
            }
            else if ( lineN >= limit ){
                  print("breaking on limit")
                  break
            }
      }
      return(HPC)
      close(con)
}