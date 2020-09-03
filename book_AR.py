import pandas as pd
from mlxtend.frequent_patterns import apriori,association_rules #pip install mlxtend --user #apriori creates item sets and association rules create rules.
book=pd.read_csv("C:\\Users\\Shinkar\\Desktop\\vss 2020\\Excelr\\Assignments\\Association Rules\\book.csv")
book.head()
frequent_itemsets=apriori(book,min_support=0.02,use_colnames=True)
frequent_itemsets.shape
rules=association_rules(frequent_itemsets,metric="confidence",min_threshold=0.3)
rules.shape
rules.head()
rules.sort_values('conviction',ascending=False,inplace=True)
import matplotlib.pyplot as plt
plt.scatter(rules.support,rules.confidence,alpha=0.5,marker="*");plt.xlabel("support");plt.ylabel("confidence")

########################## To eliminate Redudancy in Rules #################################### 
def to_list(i):
    return (sorted(list(i)))


ma_X = rules.antecedents.apply(to_list)+rules.consequents.apply(to_list)


ma_X = ma_X.apply(sorted)

rules_sets = list(ma_X)

unique_rules_sets = [list(m) for m in set(tuple(i) for i in rules_sets)]
index_rules = []
for i in unique_rules_sets:
    index_rules.append(rules_sets.index(i))


# getting rules without any redudancy 
rules_no_redudancy  = rules.iloc[index_rules,:]

# Sorting them with respect to list and getting top 10 rules 
rules_no_redudancy.sort_values('lift',ascending=False).head(10)
