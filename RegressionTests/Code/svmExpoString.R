library(caret)
timestamp <- format(Sys.time(), "%Y_%m_%d_%H_%M")

model <- "svmExpoString"

#########################################################################

library(kernlab)
data(reuters)

cctrl1 <- trainControl(method = "cv", number = 3, returnResamp = "all")
cctrl2 <- trainControl(method = "LOOCV", savePredictions = TRUE)
cctrl3 <- trainControl(method = "none",
                       classProbs = TRUE, summaryFunction = twoClassSummary)
cctrlR <- trainControl(method = "cv", number = 3, returnResamp = "all", search = "random")

set.seed(849)
test_class_cv_model <- train(matrix(reuters, ncol = 1), rlabels, 
                             method = "svmExpoString",
                             tuneLength = 2, 
                             trControl = cctrl1)

test_class_pred <- predict(test_class_cv_model, matrix(reuters, ncol = 1))

set.seed(849)
test_class_rand <- train(matrix(reuters, ncol = 1), rlabels, 
                         method = "svmExpoString", 
                         trControl = cctrlR,
                         tuneLength = 4)

set.seed(849)
test_class_loo_model <- train(matrix(reuters, ncol = 1), rlabels, 
                              method = "svmExpoString",
                              tuneLength = 2, 
                              trControl = cctrl2)

set.seed(849)
test_class_none_model <- train(matrix(reuters, ncol = 1), rlabels, 
                               method = "svmExpoString", 
                               trControl = cctrl3,
                               tuneGrid = test_class_cv_model$bestTune,
                               metric = "ROC")

test_class_none_pred <- predict(test_class_none_model, matrix(reuters, ncol = 1))
test_class_none_prob <- predict(test_class_none_model, matrix(reuters, ncol = 1), type = "prob")

test_levels <- levels(test_class_cv_model)
if(!all(levels(rlabels) %in% test_levels))
  cat("wrong levels")

#########################################################################

tests <- grep("test_", ls(), fixed = TRUE, value = TRUE)

sInfo <- sessionInfo()

save(list = c(tests, "sInfo", "timestamp"),
     file = file.path(getwd(), paste(model, ".RData", sep = "")))

q("no")


