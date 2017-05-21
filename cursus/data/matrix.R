> A = matrix(
+   c(2, 4, 3, 1, 5, 7), # the data elementen
+   nrow=2,              # aantal rijen
+   ncol=3,              # aantal kolommen
+   byrow = TRUE)        # vul de matrix aan per rij

> A                      # print de matrix
     [,1] [,2] [,3]
[1,]    2    4    3
[2,]    1    5    7

> A[2, 3]      # element op 2de rij, 3de kolom
[1] 7

> A[2, ]       # de 2de rij
[1] 1 5 7

> A[ ,c(1,3)]  # de eerste en de derde kolom 
     [,1] [,2]
[1,]    2    3
[2,]    1    7
