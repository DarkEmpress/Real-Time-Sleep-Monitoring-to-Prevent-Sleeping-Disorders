
# Real-Time Sleep Monitoring to Prevent Sleeping Disorders
Sleep is an essential and vital element of a person's life and health that
helps to refresh and recharge the mind and body of a person. Bad sleep is a
big problem for a lot of people for a very long time. People suffering from
various diseases are dealing with various sleeping disorders, commonly
known as sleep apnea. On that note, a system to monitor sleep is very
important.


## Documentation

[Documentation](https://drive.google.com/file/d/1XXLSFhftKAG-CcEd0oERwiF2RFMKF2WZ/view)


## Methodology
1. Preprocess the data which may include structural anomalies, outliers, errors, inconsistency, encoding the data if needed and normalisation (which is not needed for classification problems).

2. Use appropriate data amputation methods to increase the length of the data set. Here we have used the rbind() method to increase the number of rows (not advised).

3. For sleep quality prediction we used a linear regression model on the train dataset to get the machine model we need for our predictions.

4. For sleep disorder which is a categorisation problem we used logistic
regression (families: gaussian, poisson, gamma) on the train dataset.


5. Apply the models to the test dataset and predict sleep quality and
disorders.

6. compare the target variables in the test dataset and the predictions to
analyse the accuracy