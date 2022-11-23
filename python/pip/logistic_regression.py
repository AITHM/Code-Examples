from sklearn.linear_model import LogisticRegression
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import preprocessing

data = pd.read_csv("iris.csv")
x = data.loc[:,"SepalLengthCm":"PetalWidthCm"]
y = data.loc[:,"Species"]

le = preprocessing.LabelEncoder()
le.fit(y)
y = le.transform(y)

x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2)

model = LogisticRegression().fit(x_train, y_train)
print(model.score(x_test, y_test))