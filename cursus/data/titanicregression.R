# Creeer de modus function.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}


# Geeft ons het aantal elementen die NA zijn per variabele
sapply(train,function(x) sum(is.na(x)))
# Geeft ons het aantal unique elementen
sapply(train, function(x) length(unique(x)))
library(Amelia)

#Geeft ons een visuele voorstelling van de missing waarden
missmap(train, main = "Missing values vs observed")

#We nemen een subset van de kolommen om mee verder te werken
data <- subset(train,select=c(2,3,5,6,7,8,10,12))

#Missende elementen opvullen met het gemiddelde
data$Age[is.na(data$Age)] <- mean(data$Age,na.rm=T)

sibSpMode <- getmode(data$SibSp)
parchMode <- getmode(data$Parch)


#Modus gebruiken voor resterende variabelen
data$SibSp[is.na(data$SibSp)] <- sibSpMode
data$Parch[is.na(data$Parch)] <- parchMode
data$Parch[is.na(data$Embarked)] <- embarkedMode

#Rijen verwijderen waarbij embarked niet juist is
data <- data[!is.na(data$Embarked),]
rownames(data) <- NULL

missmap(data, main = "Missing elements from dataset")

#We hebben nu een probere dataset

library(caTools)

set.seed(88)
split <- sample.split(data$Survived, SplitRatio = 0.89)

dresstrain <- subset(data, split == TRUE)
dresstest <- subset(data, split == FALSE)

#Train the data
model <- glm(Survived ~Pclass+Sex+Age+SibSp+Parch+Fare+Embarked,family=binomial(link='logit'),data=dresstrain)
summary(model)
anova(model)

fitted.results <- predict(model,newdata=dresstest,type='response')
fitted.results <- ifelse(fitted.results > 0.5,1,0)

misClasificError <- mean(fitted.results != dresstest$Survived)
print(paste('Accuracy',1-misClasificError))
library(ROCR)
library(ROCR)
p <- predict(model, newdata=dresstest, type="response")
pr <- prediction(p, dresstest$Survived)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc

