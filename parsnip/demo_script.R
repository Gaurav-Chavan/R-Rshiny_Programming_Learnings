library(parsnip)
library(tidymodels)

# 1.0 Perform Split ----
set.seed(4831)
split <- initial_split(mtcars, props =8/10)
car_train <- training(split)
car_test  <- testing(split)

# 2.0 Scale and center ----
car_rec <- 
  recipe(mpg ~ ., data = car_train) %>%
  step_center(all_predictors()) %>%
  step_scale(all_predictors()) %>%
  prep(training = car_train, retain = TRUE)


# 3.0 The processed versions ----
train_data <- juice(car_rec)
test_data  <- bake(car_rec, car_test)

# 4.0 Predictive Modelling ----
car_model <- linear_reg()
car_model

lm_car_model <- 
  car_model %>%
  set_engine("lm")
lm_car_model

lm_fit <-
  lm_car_model %>%
  fit(mpg ~ ., data = car_train)

lm_fit

# 5.0  Model Parameters ----
lm_fit$fit %>%
  broom::tidy() %>%
  arrange(p.value)


predict(lm_fit, car_test)






