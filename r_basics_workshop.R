# 2020-04

# Today we will be learning some of the basics in how to
	# work with the R software
# Specifically, we will focus on practical issues involved in
	# using R for a simple analysis
# Our analysis goal is to compare average respiration at
	# "Cold" sites (<8 deg C) with "Hot" sites (>=8 deg C),
	# but we'll have to work with the data before we
	# can get there

### Let's start by talking about help in R ----
# Learning to look for help within R or online will make your
	# work in R considerably easier in the long run
# Here are three options to get help when you are learning
	# a new function or just run into a problem in R

# First, typing "?function name" into the console will
	# open the R help page for that function
# Here's an example with the mean() function
# We will be revisiting R help many times today
?mean

# In terms of searching online, the site "Stack Overflow"
	# is currently very active on R programming questions
# You can search the R tagged questions on Stack Overflow,
	# https://stackoverflow.com/questions/tagged/r


### Before we start running code, ----
	# let's talk about the working directory
# This is the directory that, by default, R will look for datasets
	# and will place any objects we save
	# if we don't write out the full directory path
# I almost always set my working directory
 	# when working on a project
# I then I place all datasets and R scripts
	# needed for the project into that folder

# To see our current working directory,
 	# we can use the function getwd()
# The path of the default working directory that R has set
  	# will print to our console

getwd()

# We can set the working directory either through
  	# RStudio drop-down menus
	# or by coding with the "set working directory" function setwd()

# Since I've started using RStudio,
  	# I often take advantage of some of
	# the shortcuts there
# For example:
# If I've navigated to your working directory in the Files pane
	# More > Set As Working Directory

# If I've already opened a script from the folder
	# I want to be my working and in RStudio
	# I go to the the "Session" menu then set the working directory via
	# Session > Set Working Directory > To Source File Location

# When using setwd(), you have to to type out the path to the directory
# When typing out a path in R, you MUST either use forward slashes
	# or double backslashes instead of the usual backslash
# I'm going to show you the code that I could
  	# use to set my working directory to the
  	# location I've stored my files

# This is for demonstration purposes only -
  	# the code will not work for you
  	# as you do not have access to my files

# I show you both back and forward slashes, but I'm a lazy typer
	# so I only ever really use the forward slashes
setwd("N:/docs/Classes/R workshops/R basics/2017_R_basics")
setwd("N:\\docs\\Classes\\R workshops\\R basics\\2017_R_basics")

# Now look at the working directory again to make sure you set
	# it to where you want

getwd()

# We are going to be working with three datasets today
# I purposely saved them in different formats so we can practice
	# reading in datasets
# I usually work with .csv and .txt files, but there are add-on
	# packages to allow you to work with pretty much
  	# and kind of file in R

### Read in the temperature dataset ----

# The temperature dataset is a text file, called "temp.txt"
# We will use the read.table() function to read this into R

# If you are using a function for the first time,
	# you should learn to check the help pages
	# for examples of how to use it
	# and/or arguments you can set within it
?read.table

# Let's read in the dataset and take a look how R reads it in

# Datasets in R are called "data.frames";
	# I will use dataset and data.frame interchangeably today

# We need to tell R that the first
	# line of the file contains the column names
	# by setting the "header" argument to TRUE;
	# you can see in the help file that the default is FALSE
temperature = read.table("temp.txt", header = TRUE)

# You'd need to write out the whole directory path
	# if the data were not stored in your working directory
# Example of this using my current working directory
  	# using forward slashes
	# (reminder: this won't run for you):
temperature = read.table("N:/docs/Classes/R workshops/R basics/2017_R_basics/temp.txt",
					header = TRUE)

# Notice that this object, which I've named "temperature",
	# can now be seen in your Environment pane

# Assigning names to objects is key in R
	# If we don't assign a name to an object, it isn't stored
	# to work with on tasks within your R session
# You will see me assign names using = while others assign using <-
	# Use whichever you like and stick to it

# The first thing to do after reading the dataset is to take a look
	# at the dataset to make sure it looks like you expected it to

# We can look at the
	# *structure* of the dataset via the str() function
	# or by using the arrows in the Environment pane in RStudio
str(temperature)

# Uh-oh, there's a pretty obvious problem that jumps out at me
# The "DryWt" column should be numeric, but instead it has
	# been read as a *factor*
# A factor in R is a categorical or classification variable

# Let's take a closer look at just this column
# I'm going to do this using dollar sign notation, where I write out
	# the name of the dataset, the dollar sign, and then which variable
	# I'd like to print in the console
# The dollar sign notation is a common way to ask for a single column
	# from a data.frame
temperature$DryWt

# Do you see the period all by itself?
	# The period, ".", is a character
	# Because there is a character value within the numbers
	# R read the whole column as a categorical variable
# It turns out that this file was used in SAS at some point,
	# and the "." represents a missing value
# We failed to tell R that, though, so it did the best it could
	# with the given info and called the entire column a factor

# We can tell R what character represents missing values
	# by using the "na.strings" argument

# The most common reason I've seen
  	# that numeric variables are read as factors in R is
	# due to the character chosen to be a
  	# missing value - "na", "n/a", "N/A", etc., without telling R
# The second most common reason is when someone has
  	# stored really large numeric values
	# with commas in them - e.g., 1,125 instead of 1125

# So let's read in the dataset again, this time
	# using the "na.strings" argument to tell R that "." means NA
temperature = read.table("temp.txt", header = TRUE, na.strings = c(".", "NA") )

### The basics of exploring a dataset in R ----

# How does the structure of the dataset look now?
str(temperature)

# Now that things look OK, let's look at some more options
	# for looking at a dataset

# If we type the name of the object, the object gets printed in the console
# This is often not useful for big datasets but is OK for a quick scan
	# on small datasets
temperature

# In RStudio, we can click on a data object in the Environment pane
	# and see the dataset in our Source pane - this is a nice
	# feature for checking out what a dataset looks like but
	# doesn't allow editing, although you can do some basic filtering

# To get an idea of what a large dataset looks like, you can print
	# the first or last six lines of a dataset using head() or tail()
head(temperature)
tail(temperature)

# I can never remember my column names, so often have to check
	# using the names() function
# I use variable names extensively in R, so knowing the names
	# and having variable names be easy to type becomes important
names(temperature)

### About names and characters in R ----
# R is case sensitive,
	# so upper and lower case letters as different
	# (i.e., "a" is different than "A")
# Be sure to watch out for names and levels of categorical variables
	# when you're writing code

### The dimensions of the dataset ----
	# (number of rows and number of columns)
# data.frames in R have two dimensions, rows and columns
# data.frames can't be "ragged", meaning
	# every row in a data.frame has the same width
	# and every column in a data.frame has the same length

dim(temperature)
nrow(temperature) # I use this most often
ncol(temperature)

# RStudio makes this easy - we can just look in our Environment pane

# We're still in the data exploration stage so
	# let's get a quick summary of all variables in this object using summary()
summary(temperature)

# We can also get a summary of a single column
summary(temperature$Tech)

### Reading in the respiration datasets ----
# The datasets containing the respiration information
	# are in two separate datasets
# I saved the spring respiration dataset as a .csv file
# I saved the fall respiration dataset as a .xlsx file

# We can read in the .csv file with read.table,
	# defining the "sep" argument as a comma
# We can also read it directly with read.csv()

# If you look at the help page for read.csv(), you'll see
	# the default setting is "header = TRUE", so we don't have
	# to use any code for this
?read.csv

respspring = read.csv("spring resp.csv")

# You can't read in documents from Excel with only base R so
	# we'll need use an add-on package to do this
# We will be using a package called "readxl"

# When using an add-on package for the first time, you will
    # need to install the package
# The "readxl" package is already installed in this room today,
    # but we will take a moment to learn how to install a package

# We'll go to the Packages pane in RStudio to install this package
# This is where we can see all the packages that have already been installed
# Note the "Install" button - all we need to do to
  	# install a package is to click Install in RStudio
	# and type in the package name, readxl

# If we wanted to type out code to install packages,
	# we could do so via the install.packages() function
install.packages("readxl")

# Please note that you only need to install packages once;
	# after that the package is available to be loaded
	# in this and future R sessions on the same computer
# I've seen folks install a package every time they wanted to use
	# it, and that's simply not needed
# For this reason you shouldn't include install.packages() code
	# in a working script

# Now that the package is installed, we can load
	# it via library() in order to use functions from the package
# Unlike installation, loading a package does need
	# to be done in every time you work in a new R session
library(readxl)

# There is a warning message, but it is just telling us that there
	# is a newer version of R out there and is not an error

# Once a package is loaded you can look at the help pages
	# for the package functions
# The function we are going to use is called read_excel()
?read_excel

# The main difference for reading a simple file like this one
	# compared to a .txt or .csv is that
	# we need to define which worksheet we want to read,
	# either by name or number via the "sheet" argument;
# Here we'll use the worksheet number, which is 1, rather than the worksheet name
# Notice that read_excel() has col_names = TRUE as the default setting,
	# much like read.csv() with the default of header = TRUE
respfall = read_excel("fall resp.xlsx", sheet = 1)

# Check the structure of the two datasets in the Environment pane

# The read_excel() function read the "Date" variable as actual dates
	# in POSIXct format (POSIXct indicates a date-time variable),
	# but read.csv() read the dates as factors
# Our life will be easier if the variables are the same kind of variable
	# when we attempt to combine the datasets

# Here is an example of changing the "Date" variable
	# to a date with as.Date() in both datasets
?as.Date

# This is good for you to get exposure to,
	# although I won't spend much time on it,
	# as some folks struggle with dates in R

# The main thing to notice is that we will need to
	# define the format the date is in
	# (i.e., the order that day month and year appear in the date)
	# and the delimiter used in the date (in this case a forward slash)
respspring$Date = as.Date(respspring$Date, format = "%m/%d/%Y")
		# We will overwrite the factor variable
			# with the date variable by giving it the same name, "Date"

# We can do the same thing for respfall
# Notice the format and delimiter are different in the respfall dataset
respfall$Date = as.Date(respfall$Date, format = "%Y-%m-%d")

# Now "Date" is a date variable in both datasets (see the Environment pane)

# These two datasets contain a measure of respiration in different seasons
	# and we want to "stack" these two datasets together
	# to make a single respiration dataset

# We'll add a new column called "season" to each of these datasets
	# so we can still easily distinguish the two samplng times
	# once we they are in a single dataset

# Here's the way I do it:
head(respspring)   # The original dataset only has 3 variables
respspring$season = "spring" # Add the column "season" with the category of "spring"
head(respspring)   # Now there is a 4th variable names "season"

# R automatically repeats the word "spring" until every row has a value
	# This is called "recycling"
# We named the new variable "season" and a new column
  	# is automatically added to the dataset

# Now add a new column "season" with the category "fall"
	# to the fall respiration dataset

respfall$season = "fall"
head(respfall)

# Combine the two respiration datasets ----

# Let's combine (aka "concatenate") respspring and respfall vertically
	# using the function rbind() - the r in rbind means row

?rbind

# If you look deep enough in the help page, you'll find that
	# rbind() matches columns by names - if the names aren't the same
	# you'll have problems when using rbind()

# Check that column names are the same
names(respspring)
names(respfall)

# So we made the names the same - what if we hadn't?

# We can change column names by "assigning" new ones as below,
	# adding a capital "S" to season
# We essentially replace the columm names with new ones

names(respfall) = c("Sample", "Date"  , "Resp", "Season")
names(respfall)

# But you don't always want to write out all the column names -
	# what if you just want to change one of the names?

# We can use brackets to *extract* only the 4th column name
?"["  # Yep, brackets are actually a function, meaning "extract"

names(respfall)[4]  # pull the 4th column name only
names(respfall)[4] = "season" # replace the 4th name
names(respfall)

# OK, let's row bind these two datasets
	# I'm putting spring first, but it doesn't really matter
respall = rbind(respspring, respfall)
summary(respall)

# Now we need to combine the temperature and respiration datasets
# But if you check your Environment pane, you'll see
	# they have a different number of rows - the temperature dataset
	# is missing information from one of the Sample plots

# Merge the temperature and respiration datasets ----

# Let's join our two datasets together using the "merge" function
	# We'll match by the "Sample" column in each
?merge

# By default the "merge" function merges on
	# all columns that have the same name in both datasets
# Example:
resptemp = merge(respall, temperature)
head(resptemp)
# Check structure in Environment pane

# You can also choose the column names you want to merge by
	# which will make sure you know exactly which variables you are merging
	# on and makes your code more explicit

# If the names are the same:
merge(respall, temperature, by = "Sample")

# What if the names are different?
# Let's make a duplicate temperature dataset called
	# "temp2" and change the name of the "Sample" column
temp2 = temperature
names(temp2)[1] = "Samplenum"

merge(respall, temp2, by.x = "Sample", by.y = "Samplenum")
	# Notice the name in the merged dataset is from the "x" dataset,
		# which is the dataset we list first

# There are only 59 observations in our merged data frame resptemp
# This is because the sample missing from the temperature dataset
	# was dropped during the merge

# To keep all observations regardless of if they have a value in both datasets,
	# set "all" to TRUE in merge()
head(resptemp)  # You can see that sample 21 is missing
# Let's make a new resptempt dataset, this time keeping all rows from both datasets
resptemp = merge(respall, temperature, by = "Sample", all = TRUE)
head(resptemp)  # Now sample 21 is here, with NA in the Tech, Temp, and DryWt columns

# OK, we're starting to get somewhere:
	# we have a single dataset to work with

# Working with factors ----

# Let's talk a little bit more about factors in R

# Factors in R become important when we want to make graphs
	# of categorical variables
	# or we want to fit a linear model with factors (like ANOVA)
	# and would like to control what the output looks like

# Currently, the "season" variable is a character variable
# Let's take a look at it
resptemp$season

# We can tell it's not a factor because there is no "levels" information
	# when we look at the structure  or print the column in the console
# If we check the Environment pane we see it is a character variable ("chr")

# The factor() function can be used to force a variable to be a factor;
	# this is especially useful if you've stored categorical variables
	# as integers (e.g., 1, 2, 3) instead of characters
factor(resptemp$season)

# We just printed "season" as a factor in the console
# Look at the structure of the dataset, though, in the Environment pane
# It still says season is a character variable because we didn't assign
	# the new factor object a name

# We can give it the same name if we want, which will replace
	# the character variable with the factor variable in "resptemp"
resptemp$season = factor(resptemp$season)

# Assigning the name puts the variable into the dataset;
	# note the change in the Environment pane

# Look at the levels information we can see
	# The order of the levels can be important, particularly for graphing
# By default, R sets the order of the levels alphanumerically
	# So numbers come before letters,
  	# 1 comes before 2, and "a" comes before "b"

# We can change the order of the levels via the "levels" argument in factor()
?factor

# Let's change the order of the factor, putting "spring" as the first level
# Notice I wrote out all of the levels as characters,
	# and put them all in a vector (with the c() function)
factor(resptemp$season, levels = c("spring", "fall") )

# Typos matter here; look what happens if we put in a level
	# that doesn't actually exist in the dataset
# We can easily make a mistake by capitalizing Spring
factor(resptemp$season, levels = c("Spring", "fall") )

# If we want to change the names of the labels to, say,
  	# make them look nice for graphing,
	# we can use the "labels" argument
# The info we give the "labels" argument must be in the
  	# same order as the info in the "levels" argument
# Here's the correct way to do this
factor(resptemp$season, levels = c("spring", "fall"),
	  labels = c("Spring", "Fall") )

# R will do what you tell it to, though
# We can make pretty serious mistakes if we aren't paying attention and we
	# get the order of the labels wrong
factor(resptemp$season, levels = c("spring", "fall"),
	  labels = c("Fall", "Spring") )

# If you look at the last few lines of R code, you'll notice we haven't
	# assigned anything we've done to a name;
  	# instead we've just been printing out work in the console
# You can verify this by looking at the dataset structure again
# Let's assign the reordered levels with new labels
	# to the "season" variable in our dataset "resptemp" before moving on
resptemp$season = factor(resptemp$season, levels = c("spring", "fall"),
				    labels = c("Spring", "Fall") )


# Adding columns to the resptemp dataset ----

# We have temperature in Celsius in our dataset "resptemp"
	# What if we want temperature in Fahrenheit, too?

# Let's add a temperature in Fahrenheit column to our dataset:

# Generally writing everything out with dollar sign notation can be a chore
# There are several functions available to help with this,
	# and I will show you one option here - transform()

# In transform(), we can refer to variables in the dataset directly
	# after defining which dataset we're working with
# New variables names are also assigned inside the function, and
	# we simply assign a name to the new transformed dataset
	# (in this case, I just give the dataset the same name, "resptemp")
resptemp = transform(resptemp, tempf = 32 + ( (9/5)*Temp) )

head(resptemp)

# Our goal today is compare "Cold" vs "Hot" sites, but we don't
	# have a categorical variable that represents site type at the moment,
	# just a continuous temperature variable

# Let's create a new categorical variable for "Cold" and "Hot" sites
# We define a site as "Cold" if the temperature is less than 8 degrees C
	# and "Hot" if it is greater than or equal 8 degrees C

# We'll create this new column
	# using the ifelse() function
?ifelse

# In ifelse(), we define a condition we want to test
	# and then give two possible values for R to assign to each row
# The first value is assigned to any row where the condition is TRUE,
	# and the second value is assigned to any row where the condition is FALSE

# We will use the condition that the temperature must be less than 8 degrees C

# The actual work is done inside transform() again
	# to create our new variable "tempgroup"
resptemp = transform(resptemp, tempgroup = ifelse(Temp < 8, "Cold", "Hot") )
resptemp$tempgroup

# Missing values ----

# If we check the summary output for resptemp, we see
	# we have missing values (NA) in our dataset
	# which we need to remember as we work with the dataset

summary(resptemp)

# R treats missing values very differently than software packages
	# you may have used in the past

# Example:
# How does the function "mean" handle missing values?

mean(resptemp$DryWt)

?mean

# The "mean" function in R doesn't remove missing values by default.
	# If there are missing values (denoted NA)
	# we will get NA as an answer when we use mean()

# We should use the argument na.rm = TRUE to remove missing values
# Many common functions have a na.rm argument (but not all)

mean(resptemp$DryWt, na.rm = TRUE)

# If we don't want any missing values in our dataset,
	# we could remove all rows containing missing values with na.omit()
resptemp2 = na.omit(resptemp)

# There are other options for working with missing values,
	# including is.na() and complete.cases()
# We will see is.na() in a few minutes


# Saving the created dataset ----

# We went to all this trouble making a single dataset
  	# out of the three original datasets,
	# but it only exists in this R session until we close R.
# We can always just recombine the three datasets in R,
	# but I often find it convenient to save the combined dataset
	# in case I want to use it for further analyses

# I usually save datasets as .csv files,
  	# although there are many other options
# Use write.csv and save to your working directory
	# (so you can skip writing out the file path)
?write.csv

write.csv(x = resptemp, file = "combined_resp_and_temp_data.csv", row.names = FALSE)


# Let's get started on our analysis ----

# In case you've forgotten, remember our overall goal
	# is to compare soil respiration between sites < 8 degrees C ("Cold")
	# and those 8 degrees C or higher ("Hot")

# An analysis always start with data exploration,
	# usually with some sort of data summaries and graphics

# We are going to compare the means of respiration
	# between the two temperature groups
	# so let's look more closely at those groups

# Get a summary of respiration values by temperature group (hot or cold)
	# Using the "subset" function and "testing for equality", ==
?subset

subset(resptemp, tempgroup == "Cold")

# We can also just take a subset of a data.frame of only
	# a few of the columns by adding the select argument
subset(resptemp, tempgroup == "Cold", select = c("Resp", "tempgroup") )

# We can nest functions rather than making new named objects
	# if we want if we don't need the objects for later
# Let's do this while getting a summary of respiration
	# for each temperature group
summary( subset(resptemp, tempgroup == "Cold",
			 select = "Resp") )

summary( subset(resptemp, tempgroup == "Hot",
			 select = "Resp") )

# Exploratory graphics ----

# Exploratory graphics can be very helpful in understanding a dataset
	# but we generally don't need to spend a lot of time polishing them
# We will only be seeing basic exploratory graphics today

# There are three main plotting options in R -
	# base R plotting, package lattice, and package ggplot2

# I am just going to show you ggplot2 today,
	# using function qplot()
# The "q" in qplot() stands for quick, and we use this function
	# for making quick exploratory graphics that
	# aren't going to be polished up
# If you wanted to make nicer graphs with ggplot2, you would switch
	# to using the ggplot() function, which is a topic
	# for a different workshop

# Load the ggplot2 package
library(ggplot2)

# Make a basic scatterplot, which is the default type of plot in qplot()
# Note the use of the data argument, avoiding dollar sign notation
qplot(x = tempgroup, y = Resp, data = resptemp)

# If we don't want that NA value, we could
	# remove any missing values in tempgroup with is.na() and not (!)
# This means we only want the values of tempgroup that are NOT NA
qplot(x = tempgroup, y = Resp, data = subset(resptemp, !is.na(tempgroup) ) )

# How about a boxplot?
# We can do this with qplot(), as well, by adding the "geom" argument
qplot(x = tempgroup, y = Resp, data = resptemp, geom = "boxplot")

# Here is the plot without the missing values
qplot(x = tempgroup, y = Resp, data = subset(resptemp, !is.na(tempgroup) ),
	 geom = "boxplot")

# Maybe it's time to remove that NA point and make a new object
	# as we will not be using this row in our analysis
resptemp2 = subset(resptemp, !is.na(tempgroup) )

# The boxplot shows the range (max and min), the median,
	# and the interquartile values (25% and 75% of data)
	# If we want to show the means, as well, we can add them as points
	# This can help us evaluate skewness

# This means adding a layer (literally, with the plus sign)
	# to qplot()  - in this case, stat_summary
qplot(x = tempgroup, y = Resp, data = resptemp2, geom = "boxplot") +
	stat_summary(fun.y = mean, geom = "point", color = "red", size = 3)


# Histograms can be used
	# to visually check for the symmetry of a distribution
	# if you find boxplots hard to read (or have <7 data points)

# Let's plot a histogram of respiration
	# making the colors different for each temperature group (Cold and Hot),

qplot(x = Resp, fill = tempgroup, data = resptemp2,
	 geom = "histogram")

# Notice the message in the R console (this is neither a warning nor an error)

# The order of the factor affects which group gets assigned which color

# We'll make a density plot (kind of like a smoothed histogram)
	# to see this in action
qplot(x = Resp, fill = tempgroup, data = resptemp2,
	 geom = "density", alpha = I(.5) )

# Let's quickly change the order of the levels of
	# our "tempgroup" factor to see how the factor affects the graph
resptemp2$tempgroup = factor(resptemp2$tempgroup, levels = c("Hot", "Cold") )

qplot(x = Resp, fill = tempgroup, data = resptemp2,
	 geom = "density", alpha = I(.5) )

# The take home message is the being able to control a factor can
	# control the output you get in R


# Analysis using two sample test (finally) ----

# Compare mean respiration rates under hot and cold conditions
	# using a two sample t-test

# Is this appropriate?
  	# Think about your assumptions and what the data look like
	# What do you think about normality?  Equal variances? Independence?


# Using the function t.test() to do a test of a difference in means
?t.test

# Notice that unequal variance is the default setting in t.test
# I named the resulting output, but also printed it
	# to the console using an extra pair of paranetheses
# Using the built-in "data" argument avoids the use of dollar sign notation

( respunequal = t.test(Resp ~ tempgroup, data = resptemp2) )

# If we wanted to do a t test assuming equal variances:

( respequal = t.test(Resp ~ tempgroup, data = resptemp2, var.equal = TRUE) )

# If we thought these data were too skewed for a parametric t-test,
	# we could consider something like the wilcoxon rank-sum test
	# using the wilcox.test() function
( respwilcox = wilcox.test(Resp ~ tempgroup, data = resptemp2) )

# Obviously you would not perform all of these tests, but only the one
	# you decided was appropriate based on any assumptions of the tests

# This concludes our work in R
# As you gain R skills, you may start creating final graphics for your
	# publications/presentations, but that is beyond the scope
	# of this workshop

# end workshop
