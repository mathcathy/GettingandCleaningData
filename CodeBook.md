Getting and Cleaning Data Code Book

This Brief Code Book describes the features of the data and the way in which it is transformed using the R script run_analysis.R

The data is obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

More information on the data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Additionaly, once the data is downloaded, unziped and the folder renamed "data" more information can be found in the file "data/README.txt"

The script run_analysis.R performs the following steps to the data:

Reads in the training data: X_train.txt, y_train.txt, subject_train.txt from the ./data/train directory

Reads in the test data : X_test.txt, y_test.txt, subject_test.txt from the ./data/test directory

Combines X_train.txt and X_test.txt into one data frame (using row bind) named allData

Combines y_train.txt and y_test.txt into one data frame (using row bind) named allLabels

Combines subject_train.txt andsubject_test.txt into one data frame (using row bind) named allSubjects

loads the file "features.txt" and searches it for the variables which are mean or standard deviation

creates a subset of allData called requiredData with only variables of mean or standard deviation as these are all that is required.

The column headings of requiredData are extracted from the features.txt file

The column names are subsequently cleaned, parentheses and hyphens removed, mean changed to Mean and std to STD. Additionaly a typo of 'BodyBody' is corrected to 'Body'

The activity_labels.txt file is read in from the ./data folder and the character strings are then cleaned. Firstily, changed to lower case, then the underscores removed where present, and then the first letter of each word capitalised.

These activity labels are then used to transform allLabels

The collumn of the allLabels data frame is renamed activity

The collumn of the allSubjects data frame is renamed subject

the required data frame is then created, named outputData, by column binding requiredData, allLabels and allSubjects.

outputData is written to txt file tidydata.txt in the current working directory

Subsequently an additional data frame is created with the mean value, for each variable calculated for each participant and activity, this is assigned to meanData

Lastly meanData is written to a text file 'meanData.txt' in the current working directory




