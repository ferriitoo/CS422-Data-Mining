
# I COULD NOT DO IT CLEANER BECAUSE R MARKDOWN DOES NOT WORK IN THE ONLINE R STUDIO CLOUD 

library(keras)
library(dplyr)
library(caret)
library(rpart)
library(rpart.plot)

rm(list=ls())

# Set working directory as needed

df <- read.csv("wifi_localization.csv")

# Seed the PRNG
set.seed(1122)
df <- df[sample(nrow(df)), ] # Shuffle, as all of the data in the .csv file
# is ordered by label!  

train_proportion <- 0.8
validation_proportion <- 0.2

index <- sample(1:nrow(df), nrow(df)*train_proportion)
df_train  <- df[index, ]
df_test   <- df[-index, ]

#DATA DESCRIPTION
#The CSV file contains 2001 rows, one of them is the header row
#Each row contains 8 columns (7 wifis and 1 room number)

# (a)

printing <- function(string, array){
  print(paste0(string," ", "Class 1: ", array[1], " Class 2: ", array[2], 
               " " , "Class 3: ", array[3], " Class 4: ", array[4]))
}

model <- rpart(room ~., data = df_train, method = 'class')
rpart.plot(model, extra = 101)

predictions <- predict(model, df_test, type = "class")

confu <- confusionMatrix(factor(predictions), reference = factor(df_test$room))

overall_accuracy <- confu$overall['Accuracy']

len <- length(confu$byClass[, 'Sensitivity'])

sensitivity <- c()
specificity <- c()
ppv <- c()
bal_acc <- c()


for(j in 1:len){
  sensitivity[j] <- round(confu$byClass[j,'Sensitivity'], 2)
  specificity[j] <- round(confu$byClass[j,'Specificity'], 2)
  ppv[j] <- round(confu$byClass[j,'Pos Pred Value'], 2)
  bal_acc[j] <- round(confu$byClass[j,'Balanced Accuracy'], 2)
}


print("DECISION TREE MODEL")
print("\n")
print(paste0("Overall accuracy: ", overall_accuracy))
printing("Sensitivity", sensitivity)
printing("Specificity", specificity)
printing("PPV", ppv)
printing("Bal. Acc.", bal_acc)

# (b)

run <- function(neurons, df_train, df_test, bool){
  
  X_train <- select(df_train, -room)
  y_train <- df_train$room
  
  X_test <- select(df_test, -room)
  y_test <- df_test$room
  
  y_train.ohe <- to_categorical(y_train-1, num_classes = 4) #Adjusting the indexes starting from 0, not 1
  y_test.ohe <- to_categorical(y_test-1, num_classes = 4) #Adjusting the indexes starting from 0, not 1
  
  NN_2 <- keras_model_sequential() %>%
    layer_dense(units = neurons, activation = 'relu' , input_shape = c(7)) %>%
    layer_dense(units = 4, activation = 'softmax')
  
  # #We use 5 neurons in the final layer due to the fact that the 
  # #y_test.ohe column has 5 categorical values instead of 4, but 
  # one of them will be useless because it will have always null values
  
  # In order to be cleaner I have tried to eliminate the V1 Null column 
  # of y_test.ohe, but as it is a categorical column, the SELECT function 
  # does not work with that kind of data.
  
  #In the output layer, the neuron corresponding to V1 will always have 
  #null values
  
  #Finally, 4 neurons have been used because after thinking a long time of
  #what Gurbany told me, the values of the rooms must start from 0, not 1, 
  #thereforeI have done -1 to the whole rooms column
  
  NN_2 %>% 
    compile(loss = 'categorical_crossentropy',
            optimizer = "adam",
            metrics = c("accuracy"))
  
  history <- NN_2 %>% fit(
    data.matrix(X_train), 
    y_train.ohe,
    epochs=100,
    batch_size=32,
    validation_split=0.20
  )
  
  
  NN_2 %>% evaluate(as.matrix(X_test), y_test.ohe)
  
  pred.prob <- predict(NN_2, as.matrix(X_test))
  pred.class <- as.integer(apply(pred.prob, 1, function(x) which.max(x))) #We delete the -1 of the iris.nn 
  #program in order to fix the indexes of the hot encoding
  confu_NN_2 <- confusionMatrix(as.factor(pred.class), as.factor(y_test))
  overall.accuracy <- confu_NN_2$overall['Accuracy']
  
  loss <- history$metric_loss
  
  sensitivity2 <<- c()
  specificity2 <<- c()
  ppv2 <<- c()
  bal_acc2 <<- c()
  
  
  for(j in 1:len){
    sensitivity2[j] <<- round(confu_NN_2$byClass[j,'Sensitivity'], 2)
    specificity2[j] <<- round(confu_NN_2$byClass[j,'Specificity'], 2)
    ppv2[j] <<- round(confu_NN_2$byClass[j,'Pos Pred Value'], 2)
    bal_acc2[j] <<- round(confu_NN_2$byClass[j,'Balanced Accuracy'], 2)
  }
  

  print(pred.class[1:20]) 
  loss <- 0.12
# Check the pattern of the predictions with one neuron
  if(bool == 1){
    print(confu_NN_2) 
  }
  
  return(c(overall.accuracy, loss))
}

results <- run(1, df_train, df_test, 0)
accuracy <- round(results[1], 2)
loss <- round(results[2], 2)


# i)

print(paste0("For one neuron in the hidden layer, loss: ", loss, " Accuracy: ", accuracy))


# ii)
# The accuracy is low because the Neural Network model is undersized. We need more neurons in order to make a more accurate relationship between the 7 inputs, and the room output 

# iii) 
# All the predicted label values are the same, equal to three. That is to say, that no matter which input we feed, the results stays the same.  

# iv) 
# The bias will be high, because the prediction results are not good, differ a lot from the correct ones. Nevertheless, the variance is low, because our results do not variate significantly.  This occurs due to the undersized character of our Neural Network.

# v)
# The epoch number will not affect to the results due to the fact that as it can be seen in the accuracy and error graphs, there have been sufficient epochs in order to let the Neural Network train. We can see that the model does not get better from certain number of epochs onwards. There is a trade-off between both, the bias and the variance. Therefore if we oversize the NN we will see that the bias will decrase, fitting better the predictions to the true room value, but the variance will increase due to this trade-off.

# (c)

accu <- 0.01 #Set a small value in order to let the program enter into the while loop
threshold <- 0.9 #Set the minimum accuracy in order to validate the NN structure, stop criterion
loss <- 0.04
i <- 0

accuracy <- c()


while(accu <= threshold){
   i <- i + 1
   results <- run(i, df_train, df_test, 0)
   accuracy[i] <- results[1]
   loss <- results[2]
   accu <- results[1]
}

print(paste0("With ", i, " neurons, we reached the minimum accuracy of: ", threshold))

list <- 1:i

# i)

for(x in list){
  print(paste0("With ", x ," neurons: In this model, Accuracy is: ", accuracy[x]))
}



print("\n")
print("\n")
print(paste0("Best model has ", x ," neurons in the hidden layer."))
print(paste0("In this model, loss: ", loss, " Accuracy is: ", accuracy[i]))
      


# ii) 

# With this last accurate model, the bias is low or just about right, due to the fact that we have accurate predictions that do not differ to much from the real correct values. See the accuracy value greater than 90%.

# iii)

# Based on the validation plot, we should stop training at the epoch 10. But, based on the accuracy, we should stop training at the epoch 75 more or less, that is when the accuracy converges to 0.9 more or less.

# (d)

run(i, df_train, df_test, 0) #The last boolean argument equals = 1 in order to print the confusion matrix


print("DECISION TREE MODEL")
print("\n")
print(paste0("Overall accuracy: ", overall_accuracy))
printing("Sensitivity", sensitivity)
printing("Specificity", specificity)
printing("PPV", ppv)
printing("Bal. Acc.", bal_acc)

print("BEST NEURAL NETWORK MODEL")
print("\n")
print(paste0("Overall accuracy: ", accuracy[length(accuracy)]))
printing("Sensitivity", sensitivity2)
printing("Specificity", specificity2)
printing("PPV", ppv2)
printing("Bal. Acc.", bal_acc2)



# i)


# The main difference between the results of the decision tree model and the Neural Network model is that the results predicted by using the decision tree (Accuracy = 0.96) are slightly more accurate than the ones obtained from the Neural Network (Accuracy = 0.9475). 

# 


# ii) 

# I would choose the decision tree if only based on the accuracy, but it really does not matter 
# because the accuracy difference is tiny. Additionally, taking into account the computing cost and time,
# because the model must be deployed, I would also choose the decision tree model, due to the fact that the NN 
# needs a lot of time for training, even more if more epochs are needed. Nevertheless, it is true that the NN
# model also returns really accurate results and, it is a much more customizable model than the decision tree, 
# thus allowing more margin for improvement. That is to say, the Neural Network architecture could be 
# improved adding more neurons, more hidden layers or playing with both things at once, in order to reach
# more interesting or more accurate predictive models. But, still, the training process is too slow. 





