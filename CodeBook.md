## Project Description
The original dataset used for this project is the ***Human Activity Recognition Using Smartphones Data Set*** from the UCI Machine Learning Repository. In the experiment, each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The full description can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and the dataset can be manually downloaded [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

From that, we:

**1. Merged the training and the test sets to create one data set;**

**2. Extracted only the measurements on the mean and standard deviation for each measurement;**

**3. Used descriptive activity names to name the activities in the data set;**

**4. Appropriately labeled the data set with descriptive variable names;**

**5. From the data set in item 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.**


##Data processing

**1. Reading Data**

The code starts reading all of the data that will be used in this project from both the **`train`** and **`test`** folders (records, subject and activity mapping), as well as the activity and variable labels from `activity_labels.txt` and `features.txt` files respectively.

**2. Merging `train` And `test` Subject and Activity Data**

The subject and activity data are combined into separate columns first by row binding the corresponding files (`subject_train.txt`, `subject_test.txt`, `y_train.txt`, and `y_test.txt`) from the `train` and `test` folders, and then column binding the two columns.

**3. Subsetting `mean` and `std` Data**

The `grep` function is then used to find the column indices of any variable that contains "mean" or "std" (standard deviation) data. The subset of data for these variables is then column bound with the subject and activity dataframe to create a dataframe.

**4. Using correct label names**

Adjustments were made in order to make the variable names more descriptive:

- "^f" --> "freq"

- "^t" --> "time" which indicates time domain values


**5. Creating New Dataset with Averages of Each Variable/Activity/Subject**

The `ddply` function from the `plyr` library is used to summarize the data by taking the mean of the other variables grouped by subject and then activity, such that each subject will have 6 rows of data averages for each of the 6  correponding activities.

**6. Output the New Dataset**

The `write.table` function is used to store the dataframe to a text file named `UCI HAR Averages Dataset.txt`.
