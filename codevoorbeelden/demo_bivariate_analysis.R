# Examples Bivariate Analysis

library(vcd)
View(mtcars)
?mtcars

#
# Case 1: qualitative independent / qualitative dependent variable
#

# Is there a relation between engine type (vs) and number of cylinders (cyl)?
# vs: 0 = V-engine, 1 = straight engine

# Frequency tables
table(mtcars$vs)
table(mtcars$cyl)
table(mtcars$vs, mtcars$cyl)
addmargins(table(mtcars$vs, mtcars$cyl))

vs_cyl <- t(table(mtcars$vs, mtcars$cyl))
prop_vs_cyl <- prop.table(vs_cyl, margin = 2)

# Mosaic plot
plot(t(vs_cyl))

# Strip chart
barplot(prop_vs_cyl, legend = TRUE, horiz = TRUE)

# Clustered bar chart
barplot(vs_cyl, beside = TRUE, legend = TRUE)

# Chi squared and Cramér's V
assocstats(vs_cyl)

#
# Case 2: quantitative independent / quantitative dependent variable
#

# Do heavier cars (wt) have a higher fuel consumption (mpg)?

# Build a linear model
regr <- lm(mtcars$mpg ~ mtcars$wt)

# Scatter plot with regression line
plot(mtcars$wt, mtcars$mpg)
abline(regr, col = 'red')

# Correlation coefficient
cor(mtcars$wt, mtcars$mpg)

# Covariance
cov(mtcars$wt, mtcars$mpg)

#
# Case 3: qualitative independent / quantitative dependent variable
#

# Is there a relation between the transmission type (am) and fuel consumption (mpg)?
# am: 0 = automatic, 1 = manual

# Box plot of the two groups:
boxplot(mtcars$mpg ~ mtcars$am)
summary(mtcars$mpg)

# Two sample t-test
t.test(mtcars$mpg ~ mtcars$am, alternative = 'less')
