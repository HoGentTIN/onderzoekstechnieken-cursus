> a <- c("Sometimes","Sometimes","Never","Always","Always","Sometimes","Sometimes","Never")
> b <- c("Maybe","Maybe","Yes","Maybe","Maybe","No","Yes","No")
> results <- table(a,b)
> results
           b
a           Maybe No Yes
  Always        2  0   0
  Never         0  1   1
  Sometimes     2  1   1
