## This is the script with solutions included...

## Warning: the code below contains deliberate errors.
## Also it sometimes contains "???" which you need to replace with appropriate text.


#######################################################
## first line of code is to clear R's memory
rm(list=ls())
#######################################################


#######################################################
## First we load some required add-on package
## (you need to install these if we haven't already)
library(readr)
library(dplyr)
library(ggplot2)
#######################################################


#######################################################
## Now read in the data, using the read_csv() function.
## First we should assign, using the assignment arrow,
## the URL of the published version of the google sheet data into an object.
#### SOLUTION: The following line needed the assignment arrow correctly written
the_URL <- "https://docs.google.com/spreadsheets/d/e/2PACX-1vQFgYX1QhF9-UXep22XmPow1ZK5nbFHix9nkQIa0DzqUhPtZRxH1HtY-hsno32zDiuIHiLb2Hvphk1L/pub?gid=1188775314&single=true&output=csv"
#### SOLUTION: the following line needed read_cvs corrected to read_csv
class_RTs <- read_csv(the_URL)
#######################################################


#######################################################
## Have a look at the data in R, does it look OK?
#### SOLUTION: the following line needed clas changed to class
class_RTs
#######################################################


#######################################################
## Now we need to do some data wrangling (cleaning and tidying)
## Clean up the column / variable names:
## Must be very careful to get the next line right!!! Really important!!!
## Otherwise columns will have the wrong names, which would be very confusing
#### SOLUTION: the following line needed a comma added at the end
names(class_RTs) <- c("Timestamp", "ID", "Gender", "Pref_Reaction_time_1",
                      "Verbal_memory_score", "Number_memory_score",
                      "Visual_memory_score",
                      "Weight_kgs", "Handed", "Nonpref_Reaction_time_ave",  "Pref_Reaction_time_2",
                      "Pref_Reaction_time_3",  "Pref_Reaction_time_4", "Pref_Reaction_time_5",
                      "Pref_Reaction_time", "Random_number")
## check the headings are correct
class_RTs
#######################################################



#######################################################
## Check the variable types are correct.
## Timestamp should be a character
## ID should be a character
## Gender should be a character
## The remaining variables should be numeric.
class_RTs
glimpse(class_RTs)
#######################################################


#######################################################
## Correct or exclude problematic data
## If we have problems here, with variables of the wrong type,
## it probably means some of the data entry is a bit messed up.

## e.g. if there are non-numeric entries in the Reaction_time variable, 
## one solution is to exclude them
class_RTs <- filter(class_RTs, !is.na(as.numeric(Pref_Reaction_time)))

## Once fixed, we need to make the variables have the correct type
## to do this we can use the type_convert() function from readr package.
#### SOLUTION: the following line needed RT changed to RTs
class_RTs <- type_convert(class_RTs)
#######################################################


#######################################################
## Check the number of observations remaining
class_RTs
## and the number of observations of each gender
### Check numbers of data points in each gender
table(class_RTs$Gender)
#######################################################


#######################################################
## Now make a figure containing the histogram of reaction times for the two genders
#### SOLUTION: replace ??? with Pref_Reaction_time
ggplot(data=class_RTs, aes(x=Pref_Reaction_time)) + geom_histogram() + facet_grid(~Gender)

## And a box and whisker plot
#### SOLUTION: replace x=??? with x=Gender and y=??? with y=Pref_Reaction_time
ggplot(data=class_RTs, aes(y=Pref_Reaction_time, x=Gender)) + geom_boxplot()

## Or just the data points (with some jitter, to separate overlapping points):
#### SOLUTION: replace x=??? with x=Gender and y=??? with y=Pref_Reaction_time
ggplot(data=class_RTs, aes(y=Pref_Reaction_time, x=Gender)) + geom_point() + geom_jitter(width=0.05)
#######################################################


#######################################################
## Do you think there is a difference in reaction times between females and males?
## What is the effect size (i.e. the magnitude of the difference?)
## Is this likely to be of practical significance?
## Look at your graphs and assess assumptions:
## - Do you think the residuals will be normally distributed?
## - Do the two groups have similar variance?
## - Do there seem to be any outliers?
## - Are data points independent? (You don't get this from the graph, but rather from knowing how the data were collected.)
#######################################################


#######################################################
## Do the t test and assign the outcome to an object:
#### SOLUTION: replace ??? ~ ??? with Pref_Reaction_time ~ Gender
my_ttest <- t.test(Pref_Reaction_time ~ Gender, data=class_RTs, var.equal=TRUE)
## look at the result of the t-test
#### SOLUTION: replace t.test with my_ttest
my_ttest
#######################################################


#######################################################
## Critical thinking
# How might the work be flawed?
# How might the analysis be flawed (assumptions violated)?
# Is the difference (i.e. effect size) small, medium, large, relative to differences caused by other factors?
# How general might be the finding?
# How do the qualitative and quantitative findings compare to those in previous studies?
# What could have been done better?
# What are the implications of the findings?
#######################################################


#######################################################
## Report and communicate the results
## Write a sentence that gives the direction and extent of difference,
## and a measure of certainty / uncertainty in that finding.
## Make a beautiful graph that very clearly communicates the findings!
#### SOLUTION: replace x=??? with x=Gender and y=??? with y=Reaction_time,
#### and data=??? with data=class_RTs
ggplot(data=class_RTs, aes(y=Pref_Reaction_time, x=Gender)) + geom_boxplot() +
  ylab("Reaction time (seconds)")
