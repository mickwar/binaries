#!/usr/bin/env Rscript

# A version of vulture that uses R (designed for OSX)
# Parse the commands
x = commandArgs(trailingOnly = TRUE)
file = x[1]
com = x[2:length(x)]

# Initial run
system(com)

# Get the time stamp of last modification for file
y = system(paste0("stat ", file, " | cut -d '\"' -f 4"), intern = TRUE)

# Make the waiting message clean
message = paste0("##### Waiting for changes in ", file, " #####")
add = 79 - nchar(message)
message = paste0(paste0(rep("#", floor(add / 2)), collapse = ""), message,
    paste0(rep("#", ceiling(add / 2)), collapse = ""))

# Print first message
cat(message)

# Check every 0.5 seconds if the file is modified. If so, run the command
while (TRUE){
    Sys.sleep(0.5)
    tmp = system(paste0("stat ", file, " | cut -d '\"' -f 4"), intern = TRUE)
    if (tmp != y){ 
        system(com)
        cat(message)
        y = tmp 
        }   
    }  
