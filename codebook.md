# CodeBook for Tidy Dataset

## Variables

- **subject**: ID of the subject.
- **activity**: Activity performed (e.g., WALKING, SITTING).
- **features**: Average values of selected features for each subject and activity.

## Data Transformation

1. Merged training and test sets.
2. Extracted only `mean()` and `std()` measurements.
3. Applied descriptive activity names.
4. Labeled variables appropriately.
5. Created a summary dataset with averages for each variable by activity and subject.
