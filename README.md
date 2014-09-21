Getting and Cleaning Data Course Project

README.MD This file describes how the run_analysis.R script works and the requirem-ents to make it fully functional.

Firstly download and unzip the data from link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder "data"

In R (or R studio) set the working directory ( using setwd()) to a directory contai-ning the "data" folder and the run_analysis.R script
Enter the command source("run_analysis.R")
This will complete the data formatting and write two files to the working directory
These are "tidydata.txt" and "meanData.txt" You can check the contents of your working directory by entering the dir() command
To load the data into R, enter the following commands
data <- read.table("tidydata.txt", header = T)
meandata <- read.table("meanData.txt",header = T)
This will asign the large tidy data set to 'data' and the mean data set to 'meandata'
