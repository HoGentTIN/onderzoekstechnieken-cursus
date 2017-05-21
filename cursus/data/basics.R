> attach(computers)
> mean(price)
[1] 2219.577
> median(price)
[1] 2144
> quantile(price)
  0%  25%  50%  75% 100%
 949 1794 2144 2595 5399
> min(price)
[1] 949
> max(price)
[1] 5399
> var(price)
[1] 337333.2
> sd(price)
[1] 580.804

> summary(computers)
     price          speed              hd              ram             screen           cd               multi             premium
 Min.   : 949   Min.   : 25.00   Min.   :  80.0   Min.   : 2.000   Min.   :14.00   Length:6259        Length:6259        Length:6259
 1st Qu.:1794   1st Qu.: 33.00   1st Qu.: 214.0   1st Qu.: 4.000   1st Qu.:14.00   Class :character   Class :character   Class :character
 Median :2144   Median : 50.00   Median : 340.0   Median : 8.000   Median :14.00   Mode  :character   Mode  :character   Mode  :character
 Mean   :2220   Mean   : 52.01   Mean   : 416.6   Mean   : 8.287   Mean   :14.61
 3rd Qu.:2595   3rd Qu.: 66.00   3rd Qu.: 528.0   3rd Qu.: 8.000   3rd Qu.:15.00
 Max.   :5399   Max.   :100.00   Max.   :2100.0   Max.   :32.000   Max.   :17.00
      ads            trend
 Min.   : 39.0   Min.   : 1.00
 1st Qu.:162.5   1st Qu.:10.00
 Median :246.0   Median :16.00
 Mean   :221.3   Mean   :15.93
 3rd Qu.:275.0   3rd Qu.:21.50
 Max.   :339.0   Max.   :35.00  
