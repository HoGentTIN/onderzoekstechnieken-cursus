> x <- array(1:20, dim=c(4,5)) # Generate a 4 by 5 array.
> x
[,1] [,2] [,3] [,4] [,5]
[1,] 1 5 9 13 17
[2,] 2 6 10 14 18
[3,] 3 7 11 15 19
[4,] 4 8 12 16 20
> i <- array(c(1:3,3:1), dim=c(3,2))
> i # i is a 3 by 2 index array.
[,1] [,2]
[1,] 1 3
[2,] 2 2
[3,] 3 1
> x[i] # Extract those elements
[1] 9 6 3
> x[i] <- 0 # Replace those elements by zeros.
> x
[,1] [,2] [,3] [,4] [,5]
[1,] 1 5 0 13 17
[2,] 2 0 10 14 18
[3,] 0 7 11 15 19
[4,] 4 8 12 16 20
>
