###Introduction 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

###Original data info
Information about data sets can be found in ReadMe.txt in the data set main directory.

###Traning and test sets transformations

* merging activity ids and measurments values file
* merging subject ids and measurments values file
* adding activities descriptions

###Features names transformations

* deduplication - new name is build by concatenation of variable id and feature name
* renaming
	+ variables starting with "f" replaced by "Frequency"
	+ variables starting with "t" replaced by "Time"
	+ variables starting with "angle" replaced by "Angle"
	+ "BodyBody" replaced by "Body"
	+ Characters "()" removed from feature name
	+ new names: subject_id (for subject) and activity_descr (for activity description)

###Full set preparation

Full set is done by union of transformated test and train sets with mean and sd measures selected.

###Aggregarion
Result set is an aggregartion of full set by subject_id and activity_descr with mean of all measurments from full set.
	
