library(arules)
library(rmarkdown)
library(arulesViz)
book<-read.csv(file.choose())
View(book)
rules<-apriori(as.matrix(book),parameter = list(support=0.02,confidence=0.5,minlen=5))
rules
inspect(rules)
#inspect(head(sort(rules,by="lift")))
#head(quality(rules))
plot(rules)
# Sorting rules by confidence 
rules_conf<-sort(rules,by="confidence")
inspect(rules_conf)
# Sorint rules by lift ratio
rules_lift<-sort(rules,by="lift")
inspect(rules_lift)
plot(rules,method = "graph")
