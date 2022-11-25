#library("csv")
library("rstan")
library(car)

iris_data_set <- read.csv(file = 'iris.csv')
shuffled =  iris_data_set[sample(1:nrow(iris_data_set)),]
split <- round(nrow(shuffled) * 0.80)
training_set =  shuffled[1:split, ]
test_set = shuffled[(split + 1):nrow(shuffled),]

k = 3
y = training_set$Species
y = recode(y, "'Iris-setosa'=1; 'Iris-versicolor'=2; 'Iris-virginica'=3;")
drops <- c("species")
x = data.matrix(subset(training_set, select = -c(Id, Species)))

N_test = nrow(test_set)
x_test = data.matrix(subset(test_set, select = -c(Id, Species)))

N = nrow(training_set)
D = ncol(x)

data = list(K = k, N=N, D=D, y=y, x=x, N_test=N_test, x_test=x_test)
fit1 <- stan(
  file = "model.stan",  
  data = data,    
  chains = 1,             
  warmup = 1000,          
  iter = 5000,           
  cores = 4,             
  refresh = 0             
)
print(fit1, pars=c("x_beta"), probs=c(.1,.5,.9))