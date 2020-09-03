library(arules)
library(rmarkdown)
library(arulesViz)
mymovies<-read.csv(file.choose())
rules<-apriori(as.matrix(mymovies[,6:15]),parameter= list(support= 0.02,confidence= 0.5,minlen=3)) #minlength is minimum number of items in each rule & maxlen is maximum number of items
#Support: % of cases that include both 'if' and 'then' items.
#Confidence: % of cases with 'if' that also have 'then' items.
#Lift= confidence/(% of cases with 'then' items)
rules
inspect(rules)
summary(rules)
plot(rules)
#Sorting rules by confidence
rules_conf<-sort(rules,by="confidence")
rules_conf
inspect(rules_conf)
#Sorting rules by lift
rules_lift<-sort(rules,by="lift")
inspect(rules_lift)
plot(rules,method = "graph") # support value is between 0.1-0.4  and shown by size of circle bigger the circle, higher is value. lift value is between 0.714-10 darker the color of circle, greater is lift value.
plot(rules,method = "grouped") #big circle means high support value, dark color means high lift value.
#plot(rules,method = "mosaic")
#change minlength
rules<-apriori(as.matrix(mymovies[,6:15]),parameter= list(support= 0.02,confidence= 0.5,minlen=4))
rules
rules<-apriori(as.matrix(mymovies[,6:15]),parameter= list(support= 0.02,confidence= 0.5,minlen=5))
rules
# finding redundant rules
rules<-apriori(as.matrix(mymovies[,6:15]),parameter= list(support= 0.02,confidence= 0.5,minlen=3)) #minlength is minimum number of items in each rule & maxlen is maximum number of items
rules
subset.matrix<-is.subset(rules_lift,rules_lift)
subset.matrix[lower.tri(subset.matrix,diag=T)]<-NA
redundant<-colSums(subset.matrix,na.rm = T)>=1
which(redundant)
# Removing Redundant rules
rules.pruned<-rules_lift[!redundant]
#rules.pruned<-sort(rules.pruned,by="lift")
inspect(rules.pruned)
#rules.pruned=rules_lift