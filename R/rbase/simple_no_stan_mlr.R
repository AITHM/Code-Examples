library("nnet")
iris_data_set <- read.csv(file = 'iris.csv')
shuffled =  iris_data_set[sample(1:nrow(iris_data_set)),]
split <- round(nrow(shuffled) * 0.80)
training_set =  shuffled[1:split, ]
test_set = shuffled[(split + 1):nrow(shuffled),]

y = training_set$Species
y = recode(y, "'Iris-setosa'=1; 'Iris-versicolor'=2; 'Iris-virginica'=3;")
training_set$Species = y
x = data.matrix(subset(training_set, select = -c(Id, Species)))

N_test = nrow(test_set)
x_test = data.matrix(subset(test_set, select = -c(Id, Species)))

N_train = nrow(training_set)
D_train = ncol(x)

test <- multinom(Species ~ SepalLengthCm + SepalWidthCm + PetalLengthCm + PetalWidthCm, data = training_set)

summary(test)