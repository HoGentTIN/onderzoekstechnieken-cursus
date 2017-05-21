> a <- c(1,2,3,4)
> b <- c(2,4,6,8)
> levels <- factor(c("A","B","A","B"))
> bubba <- data.frame(first=a,
                      second=b,
                      f=levels)
> bubba
first second f
1     1      2 A
2     2      4 B
3     3      6 A
4     4      8 B
> summary(bubba)
    first          second    f
Min.   :1.00   Min.   :2.0   A:2
1st Qu.:1.75   1st Qu.:3.5   B:2
Median :2.50   Median :5.0
Mean   :2.50   Mean   :5.0
3rd Qu.:3.25   3rd Qu.:6.5
Max.   :4.00   Max.   :8.0
> bubba$first
[1] 1 2 3 4
> bubba$second
[1] 2 4 6 8
> bubba$f
[1] A B A B
Levels: A B
