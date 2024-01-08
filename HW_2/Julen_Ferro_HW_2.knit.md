
<!-- rnb-text-begin -->

---
title: "CS 422"
author: "Julen Ferro Bañales. Master's in CDS&OR, Illinois Institute of Technology"
output:
  html_document:
    toc: yes
    df_print: paged
  html_notebook:
    toc: yes
    toc_float: yes
  pdf_document:
    toc: yes
---

<!-- More information in R Markdown can be found at:
1. https://www.ssc.wisc.edu/sscc/pubs/RFR/RFR_RMarkdown.html  This is 
   the place to start since it is a short tutorial.
2. https://rmarkdown.rstudio.com/index.html This contains a longer 
   tutorial.  Take a look at the cheatsheet in 
   https://rmarkdown.rstudio.com/lesson-15.html, it is a concise 
   reference of R Markdown on two pages.
<-->

## Use this as a template for your homeworks.
#### Rename it to firstname-lastname.Rmd.
#### Run all the chunks by clicking on "Run" at the top right of the edit 
#### window and choose "Run All".  Assuming there were no errors in the
#### chunk, you should see a "Preview" button become visible on the top
#### left of the edit window.  Click this button and a html document should
#### pop up with the output from this R markdown script.

### Assignment number 2


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5saWJyYXJ5KHRpZHl2ZXJzZSlcbmxpYnJhcnkocm1zKVxubGlicmFyeShNQVNTKVxuXG5cbmBgYCJ9 -->

```r

library(tidyverse)
library(rms)
library(MASS)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

### Part 2.1 

a)


### 2.1.a.i)

Because the attibute name of the 'Auto' dataset is not quantitative, so it does not serve in order to predict anything. It is a qualitative nominal attibute that cannot be used in the regression equation.Apart from that, the name has nothing to do with the mpg.


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuc2V0LnNlZWQoMTEyMilcbmluZGV4IDwtIHNhbXBsZSgxOm5yb3coQXV0byksIDAuOTUqZGltKEF1dG8pWzFdKVxudHJhaW4uZGYgPC0gQXV0b1tpbmRleCwgXVxudGVzdC5kZiA8LSBBdXRvWy1pbmRleCwgXVxuXG5zdW1tYXJ5KEF1dG8pXG5gYGAifQ== -->

```r
set.seed(1122)
index <- sample(1:nrow(Auto), 0.95*dim(Auto)[1])
train.df <- Auto[index, ]
test.df <- Auto[-index, ]

summary(Auto)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgbXBnICAgICAgICAgIGN5bGluZGVycyAgICAgIGRpc3BsYWNlbWVudCAgICAgaG9yc2Vwb3dlciAgIFxuIE1pbi4gICA6IDkuMDAgICBNaW4uICAgOjMuMDAwICAgTWluLiAgIDogNjguMCAgIE1pbi4gICA6IDQ2LjAgIFxuIDFzdCBRdS46MTcuMDAgICAxc3QgUXUuOjEwNS4wICAgMXN0IFF1LjogNzUuMCAgXG4gTWVkaWFuIDoyMi43NSAgIE1lZGlhbiA6NC4wMDAgICBNZWRpYW4gOjE1MS4wICAgTWVkaWFuIDogOTMuNSAgXG4gTWVhbiAgIDoyMy40NSAgIE1lYW4gICA6NS40NzIgICBNZWFuICAgOjE5NC40ICAgTWVhbiAgIDoxMDQuNSAgXG4gM3JkIFF1LjoyOS4wMCAgIDNyZCBRdS46OC4wMDAgICAzcmQgUXUuOjI3NS44ICAgM3JkIFF1LjoxMjYuMCAgXG4gTWF4LiAgIDo0Ni42MCAgIE1heC4gICA6OC4wMDAgICBNYXguICAgOjIzMC4wICBcbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcbiAgICAgd2VpZ2h0ICAgICAgYWNjZWxlcmF0aW9uICAgICAgICB5ZWFyICAgICAgICAgICBvcmlnaW4gICAgIFxuIE1pbi4gICA6MTYxMyAgIE1pbi4gICA6IDguMDAgICBNaW4uICAgOjcwLjAwICAgTWluLiAgIDoxLjAwMCAgXG4gMXN0IFF1LjoyMjI1ICAgMXN0IFF1LjoxMy43OCAgIDFzdCBRdS46NzMuMDAgICAxc3QgUXUuOjEuMDAwICBcbiBNZWRpYW4gOjI4MDQgICBNZWRpYW4gOjE1LjUwICAgTWVkaWFuIDo3Ni4wMCAgIE1lZGlhbiA6MS4wMDAgIFxuIE1lYW4gICA6Mjk3OCAgIE1lYW4gICA6NzUuOTggICBNZWFuICAgOjEuNTc3ICBcbiAzcmQgUXUuOjM2MTUgICAzcmQgUXUuOjE3LjAyICAgM3JkIFF1Ljo3OS4wMCAgIDNyZCBRdS46Mi4wMDAgICBNYXguICAgOjUxNDAgICBNYXguICAgOjI0LjgwICAgTWF4LiAgIDo4Mi4wMCAgIE1heC4gICA6My4wMDAgIFxuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXG4gICAgICAgICAgICAgICAgIG5hbWUgICAgXG4gYW1jIG1hdGFkb3IgICAgICAgOiAgNSAgXG4gZm9yZCBwaW50byAgICAgICAgOiAgNSAgXG4gdG95b3RhIGNvcm9sbGEgICAgOiAgNSAgXG4gYW1jIGdyZW1saW4gICAgICAgOiAgNCAgXG4gYW1jIGhvcm5ldCAgICAgICAgOiAgNCAgXG4gY2hldnJvbGV0IGNoZXZldHRlOiAgNCAgXG4gKE90aGVyKSAgICAgICAgICAgOjM2NSAgXG4ifQ== -->

```
      mpg          cylinders      displacement     horsepower   
 Min.   : 9.00   Min.   :3.000   Min.   : 68.0   Min.   : 46.0  
 1st Qu.:17.00   1st Qu.:105.0   1st Qu.: 75.0  
 Median :22.75   Median :4.000   Median :151.0   Median : 93.5  
 Mean   :23.45   Mean   :5.472   Mean   :194.4   Mean   :104.5  
 3rd Qu.:29.00   3rd Qu.:8.000   3rd Qu.:275.8   3rd Qu.:126.0  
 Max.   :46.60   Max.   :8.000   Max.   :230.0  
                                                                
     weight      acceleration        year           origin     
 Min.   :1613   Min.   : 8.00   Min.   :70.00   Min.   :1.000  
 1st Qu.:2225   1st Qu.:13.78   1st Qu.:73.00   1st Qu.:1.000  
 Median :2804   Median :15.50   Median :76.00   Median :1.000  
 Mean   :2978   Mean   :75.98   Mean   :1.577  
 3rd Qu.:3615   3rd Qu.:17.02   3rd Qu.:79.00   3rd Qu.:2.000   Max.   :5140   Max.   :24.80   Max.   :82.00   Max.   :3.000  
                                                               
                 name    
 amc matador       :  5  
 ford pinto        :  5  
 toyota corolla    :  5  
 amc gremlin       :  4  
 amc hornet        :  4  
 chevrolet chevette:  4  
 (Other)           :365  
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



### 2.1.a.ii)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5cbnRyYWluX2MuZGYgPC0gc3Vic2V0KHRyYWluLmRmLCBzZWxlY3QgPSAtbmFtZSlcbnRlc3RfYy5kZiA8LSBzdWJzZXQodGVzdC5kZiwgc2VsZWN0ID0gLW5hbWUpXG5zdW1tYXJ5KHRyYWluX2MuZGYpXG5gYGAifQ== -->

```r


train_c.df <- subset(train.df, select = -name)
test_c.df <- subset(test.df, select = -name)
summary(train_c.df)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgbXBnICAgICAgICAgIGN5bGluZGVycyAgICAgIGRpc3BsYWNlbWVudCAgICAgaG9yc2Vwb3dlciAgICBcbiBNaW4uICAgOjMuMDAwICAgTWluLiAgIDogNjguMCAgIE1pbi4gICA6IDQ2LjAwICBcbiAxc3QgUXUuOjE3LjAwICAgMXN0IFF1Ljo0LjAwMCAgIDFzdCBRdS46MTA1LjAgICAxc3QgUXUuOiA3NS43NSAgXG4gTWVkaWFuIDo0LjAwMCAgIE1lZGlhbiA6MTUxLjAgIFxuIE1lYW4gICA6NS40OTIgICBNZWFuICAgOjE5NS40ICAgTWVhbiAgIDoxMDQuNTIgIFxuIDNyZCBRdS46MjkuMDAgICAzcmQgUXUuOjguMDAwICAgM3JkIFF1LjoxMjkuMDAgIFxuIE1heC4gICA6NDYuNjAgICBNYXguICAgOjguMDAwICAgTWF4LiAgIDo0NTUuMCAgIE1heC4gICA6MjMwLjAwICBcbiAgICAgd2VpZ2h0ICAgICAgYWNjZWxlcmF0aW9uICAgICAgICB5ZWFyICAgICAgICAgICBvcmlnaW4gICAgXG4gTWluLiAgIDoxNjEzICAgTWluLiAgIDogOC4wMCAgIE1pbi4gICA6NzAuMDAgICBNaW4uICAgOjEuMDAgICAxc3QgUXUuOjIyMjUgICAxc3QgUXUuOjEzLjc4ICAgMXN0IFF1Ljo3My4wMCAgIDFzdCBRdS46MS4wMCAgXG4gTWVkaWFuIDoyODExICAgTWVkaWFuIDoxNS41MCAgIE1lZGlhbiA6NzYuMDAgICBNZWRpYW4gOjEuMDAgIFxuIE1lYW4gICA6Mjk3OCAgIE1lYW4gICA6MTUuNTQgICBNZWFuICAgOjc1Ljk2ICAgTWVhbiAgIDoxLjU3ICBcbiAzcmQgUXUuOjE3LjEyICAgM3JkIFF1Ljo3OS4wMCAgIDNyZCBRdS46Mi4wMCAgXG4gTWF4LiAgIDo1MTQwICAgTWF4LiAgIDoyNC44MCAgIE1heC4gICA6ODIuMDAgICBNYXguICAgOjMuMDAgIFxuIn0= -->

```
      mpg          cylinders      displacement     horsepower    
 Min.   :3.000   Min.   : 68.0   Min.   : 46.00  
 1st Qu.:17.00   1st Qu.:4.000   1st Qu.:105.0   1st Qu.: 75.75  
 Median :4.000   Median :151.0  
 Mean   :5.492   Mean   :195.4   Mean   :104.52  
 3rd Qu.:29.00   3rd Qu.:8.000   3rd Qu.:129.00  
 Max.   :46.60   Max.   :8.000   Max.   :455.0   Max.   :230.00  
     weight      acceleration        year           origin    
 Min.   :1613   Min.   : 8.00   Min.   :70.00   Min.   :1.00   1st Qu.:2225   1st Qu.:13.78   1st Qu.:73.00   1st Qu.:1.00  
 Median :2811   Median :15.50   Median :76.00   Median :1.00  
 Mean   :2978   Mean   :15.54   Mean   :75.96   Mean   :1.57  
 3rd Qu.:17.12   3rd Qu.:79.00   3rd Qu.:2.00  
 Max.   :5140   Max.   :24.80   Max.   :82.00   Max.   :3.00  
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucm91bmQoY29yKHRyYWluX2MuZGYpLDIpXG5gYGAifQ== -->

```r
round(cor(train_c.df),2)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgICAgICAgICAgbXBnIGN5bGluZGVycyBkaXNwbGFjZW1lbnQgaG9yc2Vwb3dlciB3ZWlnaHRcbm1wZyAgICAgICAgICAgMS4wMCAgICAgLTAuNzggICAgICAgIC0wLjgwICAgICAgLTAuNzggIC0wLjgzXG5jeWxpbmRlcnMgICAgLTAuNzggICAgICAxLjAwICAgICAgICAgMC45NSAgICAgICAwLjg0ICAgMC45MFxuZGlzcGxhY2VtZW50IC0wLjgwICAgICAgMC45NSAgICAgICAgIDEuMDAgICAgICAgMC45MCAgIDAuOTNcbmhvcnNlcG93ZXIgICAtMC43OCAgICAgIDAuODQgICAgICAgICAwLjkwICAgICAgIDEuMDAgICAwLjg2XG53ZWlnaHQgICAgICAgLTAuODMgICAgICAwLjkwICAgICAgICAgMC45MyAgICAgICAwLjg2ICAgMS4wMCAgMC40MyAgICAgLTAuNTEgICAgICAgIC0wLjU1ICAgICAgLTAuNzAgIC0wLjQzXG55ZWFyICAgICAgICAgIDAuNTcgICAgIC0wLjM0ICAgICAgICAtMC4zNyAgICAgIC0wLjQxICAtMC4zMFxub3JpZ2luICAgICAgICAwLjU3ICAgICAtMC41NyAgICAgICAgLTAuNjIgICAgICAtMC40NiAgLTAuNTlcbiAgICAgICAgICAgICBhY2NlbGVyYXRpb24gIHllYXJcbm1wZyAgICAgICAgICAgICAgICAgIDAuNDMgICAwLjU3XG5jeWxpbmRlcnMgICAgLTAuMzQgIC0wLjU3XG5kaXNwbGFjZW1lbnQgICAgICAgIC0wLjU1IC0wLjM3ICAtMC42MlxuaG9yc2Vwb3dlciAgICAgICAgICAtMC43MCAtMC40MSAgLTAuNDZcbndlaWdodCAgICAgICAtMC4zMCAgLTAuNTlcbmFjY2VsZXJhdGlvbiAgICAgICAgIDEuMDAgIDAuMzAgICAwLjIwXG55ZWFyICAgICAgICAgIDEuMDAgICAwLjE4XG5vcmlnaW4gICAgICAgICAgICAgICAwLjIwICAwLjE4ICAgMS4wMFxuIn0= -->

```
               mpg cylinders displacement horsepower weight
mpg           1.00     -0.78        -0.80      -0.78  -0.83
cylinders    -0.78      1.00         0.95       0.84   0.90
displacement -0.80      0.95         1.00       0.90   0.93
horsepower   -0.78      0.84         0.90       1.00   0.86
weight       -0.83      0.90         0.93       0.86   1.00  0.43     -0.51        -0.55      -0.70  -0.43
year          0.57     -0.34        -0.37      -0.41  -0.30
origin        0.57     -0.57        -0.62      -0.46  -0.59
             acceleration  year
mpg                  0.43   0.57
cylinders    -0.34  -0.57
displacement        -0.55 -0.37  -0.62
horsepower          -0.70 -0.41  -0.46
weight       -0.30  -0.59
acceleration         1.00  0.30   0.20
year          1.00   0.18
origin               0.20  0.18   1.00
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucm91bmQoY29yKHRlc3RfYy5kZiksMilcbmBgYCJ9 -->

```r
round(cor(test_c.df),2)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiICAgICAgICAgICAgICAgbXBnIGN5bGluZGVycyBkaXNwbGFjZW1lbnQgaG9yc2Vwb3dlciB3ZWlnaHRcbm1wZyAgICAgICAgICAgMS4wMCAgICAgLTAuNzkgICAgICAgIC0wLjgxICAgICAgLTAuODMgIC0wLjg4XG5jeWxpbmRlcnMgICAgLTAuNzkgICAgICAxLjAwICAgICAgICAgMC45NiAgICAgICAwLjg2ICAgMC45M1xuZGlzcGxhY2VtZW50IC0wLjgxICAgICAgMC45NiAgICAgICAgIDEuMDAgICAgICAgMC45NCAgIDAuOTVcbmhvcnNlcG93ZXIgICAtMC44MyAgICAgIDAuODYgICAgICAgICAwLjk0ICAgICAgIDEuMDAgICAwLjkwXG53ZWlnaHQgICAgICAgLTAuODggICAgICAwLjkzICAgICAgICAgMC45NSAgICAgICAwLjkwICAgMS4wMFxuYWNjZWxlcmF0aW9uICAwLjI0ICAgICAtMC4zNCAgICAgICAgLTAuNDIgICAgICAtMC40OSAgLTAuMjVcbnllYXIgICAgICAgICAgMC43NCAgICAgLTAuMzcgICAgICAgIC0wLjM4ICAgICAgLTAuNTQgIC0wLjQ0XG5vcmlnaW4gICAgICAgIDAuNDIgICAgIC0wLjYxICAgICAgICAtMC41OCAgICAgIC0wLjQ0ICAtMC41MlxuICAgICAgICAgICAgIGFjY2VsZXJhdGlvbiAgeWVhciBvcmlnaW5cbm1wZyAgICAgICAgICAgICAgICAgIDAuMjQgICAwLjQyXG5jeWxpbmRlcnMgICAgICAgICAgIC0wLjM0IC0wLjM3ICAtMC42MVxuZGlzcGxhY2VtZW50ICAgICAgICAtMC40MiAtMC4zOCAgLTAuNThcbmhvcnNlcG93ZXIgICAgICAgICAgLTAuNDkgLTAuNTQgIC0wLjQ0XG53ZWlnaHQgICAgICAgLTAuNDQgIC0wLjUyXG5hY2NlbGVyYXRpb24gICAgICAgICAxLjAwICAwLjExICAgMC40MSAgICAgICAgIDAuMTEgIDEuMDAgICAwLjE1XG5vcmlnaW4gICAgICAgIDAuMTUgICAxLjAwXG4ifQ== -->

```
               mpg cylinders displacement horsepower weight
mpg           1.00     -0.79        -0.81      -0.83  -0.88
cylinders    -0.79      1.00         0.96       0.86   0.93
displacement -0.81      0.96         1.00       0.94   0.95
horsepower   -0.83      0.86         0.94       1.00   0.90
weight       -0.88      0.93         0.95       0.90   1.00
acceleration  0.24     -0.34        -0.42      -0.49  -0.25
year          0.74     -0.37        -0.38      -0.54  -0.44
origin        0.42     -0.61        -0.58      -0.44  -0.52
             acceleration  year origin
mpg                  0.24   0.42
cylinders           -0.34 -0.37  -0.61
displacement        -0.42 -0.38  -0.58
horsepower          -0.49 -0.54  -0.44
weight       -0.44  -0.52
acceleration         1.00  0.11   0.41         0.11  1.00   0.15
origin        0.15   1.00
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5tb2RlbDEgPC0gbG0obXBnIH4gY3lsaW5kZXJzICsgZGlzcGxhY2VtZW50ICsgaG9yc2Vwb3dlciArIHdlaWdodCArIGFjY2VsZXJhdGlvbiArIHllYXIgKyBvcmlnaW4sIGRhdGEgPSB0cmFpbl9jLmRmKVxuc3VtbWFyeShtb2RlbDEpXG5gYGAifQ== -->

```r

model1 <- lm(mpg ~ cylinders + displacement + horsepower + weight + acceleration + year + origin, data = train_c.df)
summary(model1)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiXG5DYWxsOlxubG0oZm9ybXVsYSA9IG1wZyB+IGN5bGluZGVycyArIGRpc3BsYWNlbWVudCArIGhvcnNlcG93ZXIgKyB3ZWlnaHQgKyBcbiAgICBhY2NlbGVyYXRpb24gKyB5ZWFyICsgb3JpZ2luLCBkYXRhID0gdHJhaW5fYy5kZilcblxuUmVzaWR1YWxzOlxuICAgIE1pbiAgICAgIDFRICBNZWRpYW4gICAgICAzUSAgICAgTWF4IFxuLTkuNjgwNSAtMi4xNzg2IC0wLjA5NzcgIDEuOTE4MCAxMy4wMzY0IFxuXG5Db2VmZmljaWVudHM6XG4gICAgICAgICAgICAgICBFc3RpbWF0ZSBTdGQuIEVycm9yIHQgdmFsdWUgUHIoPnx0fCkgICAgXG4oSW50ZXJjZXB0KSAgLTEuNjYwZSswMSAgNC43ODBlKzAwICAtMy40NzIgMC4wMDA1NzggKioqXG5jeWxpbmRlcnMgICAgLTUuMjM1ZS0wMSAgMy4zNDBlLTAxICAtMS41NjcgMC4xMTc5NDcgICAgXG5kaXNwbGFjZW1lbnQgIDIuMDQyZS0wMiAgNy43NjBlLTAzICAgMi42MzIgMC4wMDg4NTcgKiogXG5ob3JzZXBvd2VyICAgLTEuNzUwZS0wMiAgMS40MjRlLTAyICAtMS4yMjkgMC4yMTk5MDggICAgXG53ZWlnaHQgICAgICAgLTYuNDE2ZS0wMyAgNi43ODVlLTA0ICAtOS40NTcgIDwgMmUtMTYgKioqXG5hY2NlbGVyYXRpb24gIDguNzQyZS0wMiAgMS4wMzFlLTAxICAgMC44NDggMC4zOTY4NTkgICAgXG55ZWFyICAgICAgICAgIDcuMzgzZS0wMSAgNS4yNTllLTAyICAxNC4wMzkgIDwgMmUtMTYgKioqXG5vcmlnaW4gICAgICAgIDEuNTE2ZSswMCAgMi44OTNlLTAxICAgNS4yNDAgMi43M2UtMDcgKioqXG4tLS1cblNpZ25pZi4gY29kZXM6ICAwIOKAmCoqKuKAmSAwLjAwMSDigJgqKuKAmSAwLjAxIOKAmCrigJkgMC4wNSDigJgu4oCZIDAuMSDigJgg4oCZIDFcblxuUmVzaWR1YWwgc3RhbmRhcmQgZXJyb3I6My4zNjcgIDM2NCBkZWdyZWVzIG9mIGZyZWVkb21cbk11bHRpcGxlIFItc3F1YXJlZDogMC44MTcsXHRBZGp1c3RlZCBSLXNxdWFyZWQ6IDAuODEzNSBcbkYtc3RhdGlzdGljOiAyMzIuMm9uIDdhbmQgMzY0IERGLCAgcC12YWx1ZTogPCAyLjJlLTE2XG4ifQ== -->

```

Call:
lm(formula = mpg ~ cylinders + displacement + horsepower + weight + 
    acceleration + year + origin, data = train_c.df)

Residuals:
    Min      1Q  Median      3Q     Max 
-9.6805 -2.1786 -0.0977  1.9180 13.0364 

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -1.660e+01  4.780e+00  -3.472 0.000578 ***
cylinders    -5.235e-01  3.340e-01  -1.567 0.117947    
displacement  2.042e-02  7.760e-03   2.632 0.008857 ** 
horsepower   -1.750e-02  1.424e-02  -1.229 0.219908    
weight       -6.416e-03  6.785e-04  -9.457  < 2e-16 ***
acceleration  8.742e-02  1.031e-01   0.848 0.396859    
year          7.383e-01  5.259e-02  14.039  < 2e-16 ***
origin        1.516e+00  2.893e-01   5.240 2.73e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error:3.367  364 degrees of freedom
Multiple R-squared: 0.817,	Adjusted R-squared: 0.8135 
F-statistic: 232.2on 7and 364 DF,  p-value: < 2.2e-16
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdSLXNxIHZhbHVlIGlzJyAsIHN1bW1hcnkobW9kZWwxKSRyLnNxKSlcbmBgYCJ9 -->

```r
print(paste0('R-sq value is' , summary(model1)$r.sq))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUi1zcSB2YWx1ZSBpczAuODE3MDMzNjE4NTI4MjAyXCJcbiJ9 -->

```
[1] "R-sq value is0.817033618528202"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdBZGp1c3RlZCBSLXNxIHZhbHVlIGlzJywgc3VtbWFyeShtb2RlbDEpJGFkai5yLnNxdWFyZWQpKVxuYGBgIn0= -->

```r
print(paste0('Adjusted R-sq value is', summary(model1)$adj.r.squared))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdXG4ifQ== -->

```
[1]
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdSU0UgaXMnICwgc3VtbWFyeShtb2RlbDEpJHNpZ21hKSlcbmBgYCJ9 -->

```r
print(paste0('RSE is' , summary(model1)$sigma))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUlNFIGlzMy4zNjY5MTgzOTIwMDYwOVwiXG4ifQ== -->

```
[1] "RSE is3.36691839200609"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdSTVNFIGlzJyAsIHNxcnQobWVhbihtb2RlbDEkcmVzaWR1YWxzXjIpKSkpXG5gYGAifQ== -->

```r
print(paste0('RMSE is' , sqrt(mean(model1$residuals^2))))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUk1TRSBpczMuMzMwNTE4MjA0ODg3MzlcIlxuIn0= -->

```
[1] "RMSE is3.33051820488739"
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

Taking into account the results, we can see that the model is good but some of the attributes or predictors are not really useful due to the fact that really do not influence the final mpg result.
### 2.1.a.iii)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuZ2dwbG90KHRyYWluX2MuZGYgLGFlcyggeCA9IG1wZywgeSA9IG1vZGVsMSRyZXNpZHVhbHMpKSArIGdlb21fcG9pbnQoKSsgbGFicyh0aXRsZSA9ICdSZXNpZHVhbHMgZ3JhcGgnLCB4ID0gJ21wZycsIHkgPSAnUmVzaWR1YWxzJylcbmBgYCJ9 -->

```r
ggplot(train_c.df ,aes( x = mpg, y = model1$residuals)) + geom_point()+ labs(title = 'Residuals graph', x = 'mpg', y = 'Residuals')
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjM0OS44MTQ2LCJ3aWR0aCI6NTY2LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkFcbmBgYCJ9 -->

```r
NA
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### 2.1.a.iv)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5nZ3Bsb3QobW9kZWwxLCBhZXMoIHggPSBtb2RlbDEkcmVzaWR1YWxzKSkgKyBnZW9tX2hpc3RvZ3JhbShmaWxsID0gJ2JsdWUnLCBjb2xvciA9ICdibGFjaycpICsgbGFicyh0aXRsZSA9ICdSZXNpZHVhbHMgY2hhcnQnLCB4ID0gJ1Jlc2lkdWFscycsIHkgPSAnUHJvYmFiaWxpdHknKVxuYGBgIn0= -->

```r

ggplot(model1, aes( x = model1$residuals)) + geom_histogram(fill = 'blue', color = 'black') + labs(title = 'Residuals chart', x = 'Residuals', y = 'Probability')
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjM0OS44MTQ2LCJ3aWR0aCI6NTY2LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbWzAsImBzdGF0X2JpbigpYCB1c2luZyBgYmlucyA9IDMwYC4gUGljayBiZXR0ZXIgdmFsdWUgd2l0aFxuYGJpbndpZHRoYC5cbiJdXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkFcbmBgYCJ9 -->

```r
NA
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

The residuals do follow a Gaussian distribution clearly.

b)

### 2.1.b.i)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucmFuayhzdW1tYXJ5KG1vZGVsMSkkY29lZmZpY2llbnRzWywnUHIoPnx0fCknXSwgbiA9IDMpIDwgNFxuYGBgIn0= -->

```r
rank(summary(model1)$coefficients[,'Pr(>|t|)'], n = 3) < 4
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiIChJbnRlcmNlcHQpICAgIGN5bGluZGVycyBkaXNwbGFjZW1lbnQgICBob3JzZXBvd2VyICAgICAgIHdlaWdodCAgICAgICAgRkFMU0UgICAgICAgIEZBTFNFICAgICAgICBGQUxTRSAgICAgICAgRkFMU0UgICAgICAgICBUUlVFIFxuYWNjZWxlcmF0aW9uICAgICAgICAgeWVhciBcbiAgICAgICBGQUxTRSAgICAgICAgIFRSVUUgICAgICAgICBUUlVFIFxuIn0= -->

```
 (Intercept)    cylinders displacement   horsepower       weight        FALSE        FALSE        FALSE        FALSE         TRUE 
acceleration         year 
       FALSE         TRUE         TRUE 
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

Weight, year and origin are the most significant ones. It could also be drawn from looking at the p values in the aforementioned analysis.

### 2.1.b.ii)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5tb2RlbDIgPC0gbG0obXBnIH4gd2VpZ2h0ICsgeWVhcisgb3JpZ2luLCBkYXRhID0gdHJhaW4uZGYpXG5wcmludChwYXN0ZTAoJ1Itc3EgdmFsdWUgaXMnICwgc3VtbWFyeShtb2RlbDIpJHIuc3EpKVxuYGBgIn0= -->

```r

model2 <- lm(mpg ~ weight + year+ origin, data = train.df)
print(paste0('R-sq value is' , summary(model2)$r.sq))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUi1zcSB2YWx1ZSBpczAuODEyNTgwNTkzNzk3ODNcIlxuIn0= -->

```
[1] "R-sq value is0.81258059379783"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdBZGp1c3RlZCBSLXNxIHZhbHVlIGlzJywgc3VtbWFyeShtb2RlbDIpJGFkai5yLnNxdWFyZWQpKVxuYGBgIn0= -->

```r
print(paste0('Adjusted R-sq value is', summary(model2)$adj.r.squared))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiQWRqdXN0ZWQgUi1zcSB2YWx1ZSBpczAuODExMDUyNzE4MjAzNzkxXCJcbiJ9 -->

```
[1] "Adjusted R-sq value is0.811052718203791"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdSU0UgaXMnICwgc3VtbWFyeShtb2RlbDIpJHNpZ21hKSlcbmBgYCJ9 -->

```r
print(paste0('RSE is' , summary(model2)$sigma))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUlNFIGlzMy4zODkwNzM2MDk5NjA2M1wiXG4ifQ== -->

```
[1] "RSE is3.38907360996063"
```



<!-- rnb-output-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxucHJpbnQocGFzdGUwKCdSTVNFIGlzJyAsIHNxcnQobWVhbihtb2RlbDIkcmVzaWR1YWxzXjIpKSkpXG5gYGAifQ== -->

```r
print(paste0('RMSE is' , sqrt(mean(model2$residuals^2))))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiUk1TRSBpczMuMzcwODAzNTM4MjY1NjFcIlxuIn0= -->

```
[1] "RMSE is3.37080353826561"
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


R-sq value is almost one, so there is a strong linear dependence, therefore the model is valid. 

### 2.1.b.iii)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkFcbmBgYCJ9 -->

```r
NA
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjM0OS44MTQ2LCJ3aWR0aCI6NTY2LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbXX0= -->

<img src="data:image/png;base64,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" />

<!-- rnb-plot-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkFcbk5BXG5gYGAifQ== -->

```r
NA
NA
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


### 2.1.b.iv)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkFcbk5BXG5gYGAifQ== -->

```r
NA
NA
```

<!-- rnb-source-end -->

<!-- rnb-plot-begin eyJoZWlnaHQiOjM0OS44MTQ2LCJ3aWR0aCI6NTY2LCJzaXplX2JlaGF2aW9yIjowLCJjb25kaXRpb25zIjpbWzAsImBzdGF0X2JpbigpYCB1c2luZyBgYmlucyA9IDMwYC4gUGljayBiZXR0ZXIgdmFsdWUgd2l0aFxuYGJpbndpZHRoYC5cbiJdXX0= -->

<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABGwAAAK7CAMAAACQxenDAAABWVBMVEUAAAAAADoAAGYAAP8AOjoAOmYAOpAAZrYzMzM6AAA6OgA6Ojo6OmY6OpA6Zjo6ZmY6ZpA6ZrY6kLY6kNtNTU1NTW5NTY5Nbo5NbqtNjshmAABmADpmOgBmOjpmOpBmZgBmZjpmZmZmZpBmkJBmkLZmtrZmtttmtv9uTU1ubm5ubo5ujqtujshuq+SOTU2Obk2Obm6Oq6uOq8iOq+SOyOSOyP+QOgCQZjqQZmaQkDqQkLaQtpCQtraQttuQ29uQ2/+rbk2rbm6rjm6ryOSr5P+2ZgC2Zjq2Zma2kDq2kGa2kJC2tpC2tra2ttu229u22/+2///Ijk3Ijm7IyKvI5P/I///bkDrbkGbbtmbbtpDbttvb25Db27bb29vb2//b/7bb///kq27kyI7kyKvk///r6+v/tmb/yI7/25D/27b/29v/5Kv/5Mj/5OT//7b//8j//9v//+T///8U9PjYAAAACXBIWXMAAB2HAAAdhwGP5fFlAAAgAElEQVR4nO2dbZscRZqdSywCGmEDQwmEDF4xw0LbAjG2F4HHxiNraAwzu0DPil5kCywNUktIbam7/v8HV2ZlVlVWVWa8VJzoiOj7XNcO6n5U58STEXlvvpZGE4QQiqDRaQ8AIXQ2BGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUaSEzaOd0ZKef/WLu/affXp5dO6P3V/tjUZvbPFxC7kkIITcFA82U5233/9zgc3td91jEDqTigobBwDkAZvj6z4xCJ1JiWHzwvzM6fj2O1PavLiFXYKw8YtB6EwqGmymuNlzObRZF7BBKGdFhE19WrXFBVhgg1DOigmb4+vABqEzq9OCza+fTQ9zzr323bz462cvV/fHX/t29uNiNz6+/e70b75+d46CJSQcLK4C3a4MR8+///PKx1d8uzr+piq+8kXzY+1cj+z59xcD7zpXmR8ef7UzOvfKf9txveyN0BnW6ZxGHX/V3p96/e7KL0bnawDNafHrO+0ePQSb9m9N/96Hyx9f8+3oX9vbZc0wK+cfd7p/fdW5hs1e/TOwQchBMS8QX2/3y+pPrWaw2Fu6P/7c95MFLRa3z5/7+37YTP929/Z6+/E132UdLGqzcU7/9oWVX605V5+a/aUX/g+wQche0WDzuD5jmaGl2stfn56VPK6OO96Y/c36F5PHXze/aWhRY6mq1DfOe2FT3ef64G51WrTT+fi6b3d4o/NfNEc/rfNoVJ3a1YczH250niHqN3cnj3/mmg1CDor7UN/5+uCiOlqYnZJMDmcHHEvXXpo/LtHig/r3NXZ6YNM1rADXfHzdd0l789Ong+ZPe3MiVY5vbHSuYdPmAxuErBUVNq/N9+35fr9X78wHLYfmanbjvcVfnV/xWYfN4Rwb1ee6sDm/evK0lNByZOmkqz3X2utzrjzngAE2CFkr4ouYv2uv0O7N9/J6b36j/t/R6NX//vPis7PduDqcmf/V4btRi89VvGgosO670BJHlhL6D4Qa5/lh0GKUCCELRblmc/z19GhgfjN5+fLwaHYdZ/6rV/6wOI6Y7sadnfnABJvjn/7y+c5oGTbrvgsdrr88YePcqQAbhKwV6QLx4c7ieGAVNtXvl353vn7qZQ6bxT2kwyHY3Kkfp6m1BJt134XWj12snIENQn6KdTfqcDSnzSbYVA/fzX+xuJ1kC5vFwzArsFnzXcgONmvOwAYhP0W79X0wanfSzoWYZT3+87v1VZ5q/3U6jWoehrnw6u/++f9eXoHNiu9CVrBZdwY2CPkp3ldMVMczM8YMvYJ03DwQY3eBuLmie9A8DDNZvUC87rvQ8gXiBiDrsFl3BjYI+SneE8SP2iusnfs59eHKBqYs7l0v3Xqew6bZ26vPrUDicPk0aiOrWi3d+m7/3jps1p2BDUJ+ivi6wvxEaumrJqZ/XGFK87bm0kN9zetU8yfuDuZPwxws7mUt/JaPbNZ9l7R4qK/lyBpsNjgDG4T8FPndqPk7AKPz3zbvALw4ad8cqP7unXe6V3irv1q9QHBn8bpCda35/P9oL/02xx/1yU79+sPyx9d9u8Obva4wP8PaeGSz4tyBzZZfmoHQWVLst77r/XX5ftT8zGqhpZeblv7quSvNjr306d/tzFm10OL68gbfZW16EXMFNuvOa7AZ9VzuRgh1FBM2ixOp4/n96PabHObf9jA9kqh+np+gtGg592F7N2rytP3WiQ8fzWCzwMa5f5hdfpl/fNW3o/brJJa/YmIx1M3O3btYhxsphhBaV1TYLN2RulN/I9UriwftHn9Tf3HDK1/M7/20V0PuvFv9/rv5re+pz48XZt+81cKm+S6u6sMzFiw+vuLb1aYvz5pp8U05K84rt8x/rAx+47V5EDpb4l/ERAhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEURsEEIRZEONg/c5PwBZ6kD6MAiQe1PB+YEtf9k6Y/ARuRPB+YEtT8dmBPU/sCGZWLhTwfmBLV/SR0AG5k/HZgT1P50YE5Q+wMblomFPx2YE9T+JXUAbGT+dGBOUPvTgTlB7Q9sWCYW/nRgTlD7l9QBsJH504E5Qe1PB+YEtT+wYZlY+NOBOUHtX1IHwEbmTwfmBLU/HZgT1P7AhmVi4U8H5gS1f0kdABuZPx2YE9T+dGBOUPsDG5aJhT8dmBPU/iV1AGxk/nRgTlD704E5Qe0PbFgmFv50YE5Q+5fUAbCR+dOBOUHtTwfmBLU/sGGZWPjTgTlB7V9SB8BG5k8H5gS1Px2YE9T+wIZlYuFPB+YEtX9JHQAbmT8dmBPU/nRgTlD7AxuWiYU/HZgT1P4ldQBsZP50YE5Q+9OBOUHtD2xYJhb+dGBOUPuX1AGwkfnTgTlB7U8H5gS1P7BhmVj4dwNGRrknhBpqn39pc6BIUPsDG5aJhT+wMSeo/UvqANjI/EvrYDT6u0EBG4V/SR0AG5l/aR0Am00Jav+SOgA2Mv/SOgA2mxLU/iV1AGxk/qV1AGw2Jaj9S+oA2Mj8S+sA2GxKUPuX1AGwkfmX1gGw2ZSg9i+pA2Aj8y+tA2CzKUHtX1IHwEbmX1oHwGZTgtq/pA6Ajcy/tA6AzaYEtX9JHQAbmX9pHQCbTQlq/5I6ADYy/9I6ADabEtT+JXUAbGT+pXUAbDYlqP1L6gDYyPxL6wDYbEpQ+5fUAbCR+ZfWAbDZlKD2L6kDYCPzL60DYLMpQe1fUgfARuZfWgfAZlOC2r+kDkLB5snupfv1H05u7o7HV28Bm+I6ADabEtT+JXUQCDYnN8Yz2Dy7Nq705g/AprQOgM2mBLV/SR0Egs29cQOb/fGlW5OjFj3ARpqg9gc25gS1f0kdhIHNk90GNk9262OaZ9cufglsxAHAxuxf2hwoEtT+gWEzPYn6T7NrNvfGb9e/uTf+GNiIA4CN2b+0OVAkqP0Dw2Z//HZzgXh//Gn9m4cNdICNMkHtD2zMCWr/kjoIAZuH01OoGWxObjSnT/ObU5OXGvkYo6gy/lMtJtgYdNr9obTksyDqCzTAJn8BGxRTPgtiv7o+swab1Zvf/gdfInEAvCoDTcywMZT1Haz5ZzcHa/4ldbA9bO7V96F6j2yAjS4hsB+w8UhQ+5fUwdawebJb8wXYrPln1wGw8UhQ+5fUwdawuTeea3rmxN2ohX92HQAbjwS1f0kdBIZN+3wNz9lk2AGw8UhQ+5fUwdawadScN/EE8cI/uw6AjUeC2r+kDgLD5uTG+C3ejZr5Z9cBsPFIUPuX1EFg2EyOeOu79c+uA2DjkaD2L6mD0LCZHN2csubq6nENsFEkBPYDNh4Jav+SOggFG6P8hygSy2RVwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn10HwMYjQe1fUgfARuafXQfAxiNB7V9SB8BG5p9dB8DGI0HtX1IHwEbmn14HI5OAjXOC2r+kDoCNzD+9DoBN+AS1f0kdABuZf3odbEcTYLMpQe1fUgfARuafXgfAJnyC2r+kDoCNzD+9DoBN+AS1f0kdABuZf3odAJvwCWr/kjoANjL/9DoANuET1P4ldQBsZP7pdQBswieo/UvqANjI/NPrANiET1D7l9QBsJH5p9cBsAmfoPYvqQNgI/NPrwNgEz5B7V9SB8BG5p9eB8AmfILav6QOgI3MXxFgfOHA8GlgEzpB7V9SB9Fgg0LICBvDp08VNpG2EcpEHNmE89cc2Rh26O0+vU2ZIxuJf0kdABuZP7Axji3LOegmqP1L6gDYyPyBjXFsWc5BN0HtX1IHwEbmD2yMY8tyDroJav+SOgA2Mn9gYxxblnPQTVD7l9QBsJH5Axvj2LKcg26C2r+kDoCNzB/YGMeW5Rx0E9T+JXUAbGT+wMY4tiznoJug9i+pA2Aj8wc2xrFlOQfdBLV/SR0AG5k/sDGOLcs56Cao/UvqANjI/IGNcWxZzkE3Qe1fUgfARuYPbIxjy3IOuglq/5I6ADYyf2BjHFuWc9BNUPuX1AGwkfkDG+PYspyDboLav6QOgI3MH9gYx5blHHQT1P4ldQBsZP7Axji2LOegm6D2L6kDYCPzBzbGsWU5B90EtX9JHQAbmT+wMY4tyznoJqj9S+oA2Mj8gY1xbFnOQTdB7V9SB8BG5g9sjGPLcg66CWr/kjoANjJ/YGMcW5Zz0E1Q+5fUAbCR+QMb49iynINugtq/pA6Ajcwf2BjHluUcdBPU/iV1AGxk/sDGOLYs56CboPYvqQNgI/MHNsaxZTkH3QS1f0kdABuZP7Axji3LOegmqP1L6gDYyPyBjXFsWc5BN0HtX1IHwEbmD2yMY8tyDroJav+SOgA2Mn9gYxxblnPQTVD7l9QBsJH5Axvj2LKcg26C2r+kDoCNzB/YGMeW5Rx0E9T+JXUAbGT+wMY4tiznoJug9i+pA2Aj8wc2xrFlOQfdBLV/SR0AG5k/sDGOLcs56Cao/UvqANjI/IGNcWxZzkE3Qe1fUgfARuYPbIxjy3IOuglq/5I6ADYyf2BjHFuWc9BNUPuX1AGwkfkDG+PYspyDboLav6QOgI3MH9gYx5blHHQT1P4ldQBsZP7Axji2LOegm6D2L6kDYCPzBzbGsWU5B90EtX9JHQAbmT+wMY4tyznoJqj9S+oA2Mj8gY1xbFnOQTdB7V9SB8BG5g9sjGPLcg66CWr/kjoANjJ/YGMcW5Zz0E1Q+5fUAbCR+QMb49iynINugtq/pA6Ajcwf2BjHluUcdBPU/iV1AGxk/sDGOLYs56CboPYvqQNgI/MHNsaxZTkH3QS1f0kdABuZP7Axji3LOegmqP1L6gDYyPyBjXFsWc5BN0HtX1IHwEbmD2yMY8tyDroJav+SOggBm18+GY8v/uf7sx9Obu6Ox1dvARtgYx5blnPQTVD7l9RBANjcG9d664fqh2fX6h/e/AHYABvj2LKcg26C2r+kDraHzZPdi/84mRx9Mn67+ml/fOnW5OjG+NJ9YCMwBTZOYhVZJKj9Q8Jmf/zxjDnV0czsf6fHNxe/BDYCU2DjJFaRRYLaX3CB+Nm1CjP3Zsc30/9+DGwEpsDGSawiiwS1vwA2T3arM6f98af1Tw8b6ACbsAI2TmIVWSSo/cPD5m+7FWZObjSnTzP0VHqpka8xWpZxh97u09uUzR+PtI1QJvJcEPvj8cU/TYCNXMAGFSO/BXHyP//D7vjif+nAZvXmt//Bl0hZHgBzGuUkVpFFgtpfcM3ml+o8asORDbAJKWDjJFaRRYLaX/G6wsPxpfvAZskf2BjHluUcdBPU/iV1EA42NV+4G7XwBzbGsWU5B90EtX9JHWwNm5MbDV9q2LTP1/CcDbCxGFuWc9BNUPuX1MHWsJkezLy9+C9PEC/8gY1xbFnOQTdB7V9SB9vD5snu+KP7k5O/jiu+TI9z3uLdqJk/sDGOLcs56Cao/UvqYHvYTB7O3vq+WJ9NHfHWd+sPbIxjy3IOuglq/5I6CACbydHvp6hpv8Lm6OaUNVdXj2uATRgBGyexiiwS1P6Ku1EG+Q9RpCyXCbBxEqvIIkHtD2wyXSbGHdqg7WgxWAY2Ev+SOgA2Mn9gs1LesI0Em6jjzyoyJ6j9gU2my0SKC2DjkaD2L6kDYCPzBzYr5Q3bSLCJOv6sInOC2h/YZLpMgI2TWEUWCWp/YJPpMgE2TmIVWSSo/YFNpssE2DiJVWSRoPYHNpkuE2DjJFaRRYLaH9hkukyAjZNYRRYJan9gk+kyATZOYhVZJKj9gU2mywTYOIlVZJGg9gc2mS4TYOMkVpFFgtof2GS6TICNk1hFFglqf2CT6TIBNk5iFVkkqP2BTabLBNg4iVVkkaD2BzaZLhNg4yRWkUWC2h/YZLpMgI2TWEUWCWp/YJPpMgE2TmIVWSSo/YFNpssE2DiJVWSRoPYHNpkuE2DjJFaRRYLaH9hkukyAjZNYRRYJan9gk+kyATZOYhVZJKj9gU2mywTYOIlVZJGg9gc2mS4TYOMkVpFFgtof2GS6TLKGjUGCzcUqskhQ+wObTJcJsHESq8giQe0PbDJdJlnDxlAWbC5WkUWC2h/YZLpMgI2TWEUWCWp/YJPpMgE2TmIVWSSo/YFNpssE2DiJVWSRoPZ3hM3Tf/f6z8DG1R/YuJUFm4tVZJGg9neFzeXR6Pn37wIbJ39g41YWbC5WkUWC2t8RNsdf1fcmz3+xBW/8hyhSlssE2DiJVWSRoPZ3v2Zz592aN698AWxs/YGNW1mwuVhFFglqf68LxLdnvHntO2Bj5Q9s3MqCzcUqskhQ+3vejTq+/U6Fm3Pve1wu9h+iSFkuE2DjJFaRRYLa3//W9+PPdurTKefDG/8hipTlMgE2TmIVWSSo/X2PbL55ef4my+vAxuAPbNzKgs3FKrJIUPv7wKYlTXVP6vFXo9EbwGbYH9i4lQWbi1VkkaD2d4ZNc7Vm8bTN4egFt/vg/kMUKctlAmycxCqySFD7uz5nc320emH46eXnvgc2g/7Axq0s2FysIosEtb/HE8Tnure8n17myMbgD2zcyoLNxSqySFD7O8PmtW9XfnX8z463v/2HKFKWywTYOIlVZJGg9uet70yXCbBxEqvIIkHt73rN5vPfLs6ZHl35Nz6vSPkPUaQslwmwcRKryCJB7e98GrV0Ndj50jCwCSdg4yRWkUWC2n8b2DzaATZW/sDGrSzYXKwiiwS1vz1sqhtRq3K8DwVswgnYOIlVZJGg9nc4sjlch82HHqxBQVQybE5726LIWp/x4//13ntXds69+l6r363eBbeTPw9FyvL/J5UMG8HmYhVZJKj9t7lm4yn/IYqU5TIBNk5iFVkkqP23ufUNbCz9gY1bWbC5WEUWCWp/HurLdJkAGyexiiwS1P7WsDn+/L3pQc30f5fldZjjP0SRslwmwMZJrCKLBLW/NWyeXh499/3q/W+es7HyBzZuZcHmYhVZJKj9gU2mywTYOIlVZJGg9ueaTabLBNg4iVVkkaD2BzaZLhNg4yRWkUWC2h/YZLpMgI2TWEUWCWp/l7tR6+JulJU/sHErCzYXq8giQe3vcoF4XVwgtvIHNm5lweZiFVkkqP2BTabLBNg4iVVkkaD255pNpssE2DiJVWSRoPYHNpkuE2DjJFaRRYLaH9hkukyAjZNYRRYJan/ejcp0mQAbJ7GKLBLU/ryukOkyATZOYhVZJKj9gU2mywTYOIlVZJGg9ueaTabLBNg4iVVkkaD2BzaZLhNg4yRWkUWC2t8PNsc/ARsHf2DjVhZsLlaRRYLa3wM2t9+tr9e89h2wsfQHNm5lweZiFVkkqP2dYXN8fX55+HW/7z73H6JIWS4TYOMkVpFFgtrfFTYVa869+od/+vOVKW1eBDZW/sDGrSzYXKwiiwS1vytsDkejNxrsfO35L2L6D1GkLJcJsHESq8giQe3vCJvpgc0b8x/2/A5t/IcoUpbLBNg4iVVkkaD2d4TN08vn/jj/4dEOD/VZ+QMbt7Jgc7GKLBLU/s6wWeKL57/F6z9EkbJcJsDGSawiiwS1v/NpVOfI5gVexLTxBzZuZcHmYhVZJKj9XS8QHyxdpzlYun4DbAb8gY1bWbC5WEUWCWp/V9g8vTz6zd2WNV5nUcAmiICNk1hFFglqf2vYtN9kc2X2nM1f3tsZjV7l+2ys/IGNW1mwuVhFFglqf2vY8IXn/v7Axq0s2FysIosEtT+wyXSZABsnsYosEtT+fm99byX/IYqU5TIBNk5iFVkkqP2BTabLBNg4iVVkkaD2BzaZLhNg4yRWkUWC2t8HNsc/Nbr977lmY+MPbNzKgs3FKrJIUPs7w+bXz7hA7OoPbNzKgs3FKrJIUPt7PNS3pBeAjY0/sHErCzYXq8giQe3v/rrC6NyrV3aq/xud+8ADNcAmjICNk1hFFglqf+cXMUcv3K3+98OKO17vYQKbIAI2TmIVWSSo/R1h03yfzewVzD2+qc/OH9i4lQWbi1VkkaD2d4ZNfU34sH73+5Bv6rPzBzZuZcHmYhVZJKj9fWFTnUE9vcz32Vj5Axu3smBzsYosEtT+ztds6tOo2ReC8k19lv5eARteRetKur9vUwY2Ev+SOrCCzWSvvlozu3TDdxBb+gMbt3LoCXhwdleRU4La3xU2j3aqfwpz9o8s7PndjvIfokhpLpOEaQJsNiWo/UvqwA42U8JUzw0fjkbndkZ8LaidP7BxK4eegAdndxU5Jaj93d+N+tfq5Ol4r36AmOdsrPyBjVs59AQ8OLuryClB7e/zIub/njLm+McLF97n3/q28wc2buXQE/Dg7K4ipwS1vw9s+vXL78fji1dvzX44ubk7Hrc/ABtXJUwTYLMpQe1fUgcusDn+aeOv/zqudfHL6odn1+of3vwB2AAbt3LoCXhwdleRU4La3wM2t9+t77y+9t1q4eH44j9OJkc3ZoDZH1+6Vf1w6T6w8flUwjQBNpsS1P4ldWAJm+Pr8wc9Xu9eszm5Mf60OaSZ/vfJbo2cZ9dmxznAxlUJ0wTYbEpQ+5fUgR1sKtZU/27Un69MadN9NerZteaUaX/88WRyb/x2/cO96gdg466EaQJsNiWo/UvqwA42h/OHa46/HvW89V3DZn92mDM9t3ob2Ph8KmGaAJtNCWr/kjqwgs3s0eFGe5vf+q7PnE5uNKdPT3bbizYvNdpMMbSihGmihs1pb3oUWYPfZzNTz7tR9QkUsNlWCdME2KCgGvyKiQ0/zPWwvvW9BJvVm9/+B18ipXkAnDBNOI3alKD2L6kDK9g0XzEx06OdDe8rPNy9WF2s2XBkA2yclDBNgM2mBLV/SR1YwWZysHSd5mDDi5j3mkf6gM2SP7BxK4eegAdndxU5Jaj9XWHz9PLoN3db1qyfRf113D5Ww92ohT+wcSuHnoAHZ3cVOSWo/a1hc/z5e7WuzJ6z+ct7O6PRq79deaxvf/xWe4Gmfb6G52yAjWs59AQ8OLuryClB7W8Nm+6/Trf5X8TcX3o3gSeIF/7Axq0cegIenN1V5JSg9g8Jm3vL70Gd3Bi/xbtRM39g41YOPQEPzu4qckpQ+wf8ionmNe9K1WWaI976bv2BjVs59AQ8OLuryClB7R8QNg/HHdhMjm5O/3R19bgG2FgqYZoAm00Jav+SOtgaNrbyH6JIaS6ThGkCbDYlqP1L6sAaNo+/uTAanbvw/s/AxtJ/Y4Dxn2pJlybAZlOC2r+kDmxhczDfGbz+bQVg0wjY9JajzUHQBLV/SR1YwqZizfOvvnflZW/a+A9RpNOCjXaPPb0ysJH4l9SBHWwe7YxemH0f6K/XR0vvSQGbAX9g41aONgdBE9T+JXVgB5ulfwXz+Prm77MBNqv+wMatHG0Ogiao/UvqwAo25re+gc26P7BxK0ebg6AJav+SOrCCjcX32QCbNX9g41aONgdBE9T+JXUAbGT+wMatHG0Ogiao/UvqwAo2x9eXvuT80O8f+/YfokjAJmwZ2Ej8S+rACjZcIPbxBzZu5WhzEDRB7V9SB3awebQzOv9t/ac773Dr29If2LiVo81B0AS1f0kd2MFm9gDxhQsX/B8h9h+iSMAmbBnYSPxL6sASNpMfd5qn6c994MUaYDMTsOktR5uDoAlq/5I6sIXN5Pj2lemRzatf+FwcBjZzAZvecrQ5CJqg9i+pA2vYbCv/IYoEbMKWgY3Ev6QO7GCz99p3wMbVH9i4laPNQdAEtX9JHVjB5unlpedsgI2lP7BxK0ebg6AJav+SOrCEjddDw8BmXcCmtxxtDoImqP1L6sAKNp0XMYGNpT+wcStHm4OgCWr/kjqwgs3koP06G2Bj7w9s3MrR5iBogtq/pA7sYPP46/qL+hr9lnejbPyBjVs52hwETVD7l9SBFWxW/qk63vq28gc2buVocxA0Qe1fUgfARuYPbNzK0eYgaILav6QOrGATQv5DFAnYhC0DG4l/SR0AG5k/sHErR5uDoAlq/5I6sION779MB2xWBWx6y9HmIGiC2r+kDsywOf6qeuH7+Q9838AENssCNr3laHMQNEHtX1IHRtg8ar9b4vx2DxH7D1EkYBO2DGwk/iV1YIJNfSPq+X9b/UuYXl89DGy6Aja95WhzEDRB7V9SBybYHIxmXwN6e3qAs9XLmP5DFAnYhC0DG4l/SR0YYHN8vWXMlDpeX3QObDoCNr3laHMQNEHtX1IHZtg072BW/9z3NudR/kMUCdiELQMbiX9JHRhg8/Ry+7zw4k/Axs4f2LiVo81B0AS1f0kdABuZP7BxK80+uM0AABQlSURBVEebg6AJav+SOgA2Mn9g41aONgdBE9T+JXUAbGT+wMatHG0Ogiao/UvqANjI/IGNWznaHARNUPuX1AGwkfkDG7dytDkImqD2L6kDYCPzBzZu5WhzEDRB7V9SB2bYrIsvz7LyBzZu5WhzEDRB7V9SB8BG5g9s3MrR5iBogtq/pA4MsDn+/L118YXnVv7Axq0cbQ6CJqj9S+rAAJtw8h+iSMAmbBnYSPxL6gDYyPyBjVs52hwETVD7l9QBsJH5Axu3crQ5CJqg9i+pA2Aj8wc2buVocxA0Qe1fUgfARuYPbNzK0eYgaILav6QOgI3MH9i4laPNQdAEtX9JHQAbmT+wcSsPbs0Nj3t15TAHIQVsjP6nABtUC9j0lg3bzaBI84fCiSObcP4c2biVB7em36dLXUVBE9T+nEYBm9BlYCPxL6kDYCPzBzZu5cGtCWxkCWp/YANsQpeBjcS/pA6Ajcwf2LiVB7cmsJElqP2BDbAJXQY2Ev+SOgA2Mn9g41Ye3JrARpag9gc2wCZ0GdhI/EvqANjI/IGNW3lwawIbWYLaH9gAm9BlYCPxL6kDYCPzBzZu5cGtCWxkCWp/YANsQpeBjcS/pA6Ajcwf2LiVB7cmsJElqP2BDbAJXQY2Ev+SOgA2Mn9g41Ye3JrARpag9gc2wCZ0GdhI/EvqANjI/IGNW3lwawIbWYLaH9gAm9BlYCPxL6kDYCPzBzZu5cGtCWxkCWp/YANsQpeBjcS/pA6Ajcwf2LiVB7cmsJElqP2BDbAJXd7a3SDDpx3mIKSAjdEf2ACb0GVgI/EvqQNgI/MHNjHLDnMQUsDG6A9sgE3oMrCR+JfUAbCR+QObmGWHOQgpYGP0BzbAJnQZ2Ej8S+oA2Mj8gU3MssMchBSwMfoDG2ATugxsJP4ldQBsZP7AJmbZYQ5CCtgY/YENsAldBjYS/5I6ADYyf2ATs+wwByEFbIz+wAbYhC4DG4l/SR0AG5k/sIlZdpiDkAI2Rn9gA2xCl4GNxL+kDoCNzB/YxCw7zEFIARujP7ABNqHLwEbiX1IHwEbmD2xilh3mIKSAjdEf2ACb0GVgI/EvqQNgI/MHNjHLDnMQUsDG6A9sgE3oMrCR+JfUAbCR+QObmGWHOQgpYGP0BzbAJnQZ2Ej8S+oA2Mj8gU3MssMchBSwMfoDG2ATugxsJP4ldQBsZP7AJmbZINksq4xb/5L2A2Aj8wc2McvAxjdB7Q9sgE3ocspjAzYDCWp/YANsQpdTHhuwGUhQ+wMbYBO6nPLYgM1Agtof2ACb0OWUxwZsBhLU/sFh8+za282fTm7ujsdXbwEbYJNSWTbLKuPWv6T9IBBs9sdvt9QZV3rzB2ADbBIqy2ZZZdz6l7QfBIHNyf64hc3++NKtydGN8aX7wGbTb7PeYwfLKY8N2AwkqP3DwuaXT8YtbJ7s1sc0z65d/BLYbPpt1nvsYDnlsQGbgQS1f1DY3BuPP/pbA5t78/9+DGw2/TbrPXawnPLYgM1Agto/LGze+tPkYQOZ/fGn9X/bn4HNirLeYwfLKY8N2AwkqP2DXyBu4HJyozl9erLbXrR5qZGncWnKeo8dLKc8tpHukQ7kLWAjVtZ77GA55bEBmxQVDjarN7/9D75E4jQqbDnlsXEaNZCg9o94GgVsOsp6jx0spzw2YDOQoPYHNsAmdDnlsQGbgQS1vwo23I1a8gc2CZVls6wybv1L2g8Cw6Z9vobnbIBNUmXZLKuMW/+S9oPAsOEJ4oU/sEmoLJtllXHrX9J+EBg2JzfGb/Fu1Mwf2CRUls2yyrj1L2k/CAybyRFvfbf+wCahsmyWVcatf0n7QWjYTI5uTllzdfW4Btg0ynqPHSynPDZgM5Cg9ueb+oBN6HLKYwM2Awlqf2ADbEKXUx4bsBlIUPsDG2ATupzy2IDNQILaH9gAm9DllMcGbAYS1P7ABtiELqc8NmAzkKD2BzbAJnQ55bEBm4EEtT+wATahyymPDdgMJKj9gQ2wCV1OeWzAZiBB7Q9sgE3ocspjAzYDCWp/YANsQpdTHhuwGUhQ+wMbYBO6nPLYgM1Agtof2ACb0OWUxwZsBhLU/sAG2IQupzw2YDOQoPYHNrKNPDJpcK9Ie48dLKc8NmAzkKD2BzbAJnQ55bEBm4EEtT+wEcJmm70i7T12sJzy2IDNQILaH9gAm9DllMcGbAYS1P7ABtiELqc8NmAzkKD2BzbAJnQ55bEBm4EEtT+wATahyymPDdgMJKj9gQ2wCV1OeWzAZiBB7Q9sgE3ocspjAzYDCWp/YANsQpdTHhuwGUhQ+wMbYBO6nPLYgM1Agtof2ACb0OWUxwZsBhLU/sDGfyNv9z5C1nvsYDnlsQGbgQS1P7ABNqHLKY8N2AwkqP2BzTawEe4Vae+xg+WUxwZsBhLU/sAG2IQupzw2YDOQoPYHNsAmdDnlsQGbgQS1P7ABNqHLKY8N2AwkqP2BDbAJXU55bMBmIEHtD2yATehyymMDNgMJan9gA2xCl1MeG7AZSFD7AxtgE7qc8tiAzUCC2h/YAJvQ5ZTHBmwGEtT+wAbYhC6nPDZgM5Cg9gc2wCZ0OeWxAZuBBLU/sAE2ocspjw3YDCSo/YENsAldTnlswGYgQe0PbIBN6HLKYwM2Awlqf2ADbEKXUx4bsBlIUPsDG2ATupzy2IDNQILaH9gAm9DllMcGbAYS1P7ABtiELqc8NmAzkKD2BzbAJnQ55bEBm4EEtT+wATahyymPDdgMJKj9gQ2wCV1OeWzAZiBB7Q9sgE3ocspjAzYDCWp/YDOwkaX/VkvWe+xgOeWxAZuBBLX/KcAmHwEbr3LKYxuxrhMURzbi86Ss99jBcspj48hmIEHtz2kUsAldTnlswGYgQe0PbIBN6HLKYwM2Awlqf2ADbEKXUx4bsBlIUPsDG2ATupzy2IDNQILaH9gAm9DllMcGbAYS1P7ABtiELqc8NmAzkKD2BzbAJnQ55bEBm4EEtT+wATahyymPDdgMJKj9gQ2wCV1OeWzAZiBB7Q9sgE3ocspjM76B4g0jYGP0BzbAJnQ55bEBm4EEtT+wATahyymPzTz04KsokIANsBEu+1zLKY8N2AwkqP2BDbAJXU55bMBmIEHtD2yATehyymMDNgMJan9gA2xCl1MeG7AZSFD7AxtgE7qc8tiAzUCC2h/YAJvQ5ZTHBmwGEtT+wAbYhC6nPDZgM5Cg9gc2wCZ0OeWxAZuBBLU/sAE2ocspjw3YDCSo/QuHjfnp9FP7t1qK3mNzLZtgI3vZQW5uIWADbLIrpzw2YNMvYLMtbE5v4Z7lPTbXshk223x628W6jbmFgA2wya6c8tiATb+ADbDJrpzy2IBNv4ANsMmunPLYgE2/gA2wya6c8tiATb+ADbDJrpzy2IBNv4ANsMmunPLYgE2/gA2wya6c8tiATb+ADbDJrpzy2IBNv4ANsMmunPLYgE2/gA2wya6c8tjOLmzML0MAG2CTXTnlsQEbYGM3RHclvK6L3mNzLRcNG5M7sAE22ZVTHhuw6XcHNsAmu3LKYwM2/e7ABthkV055bMCm3x3YAJvsyimPDdj0uwMbYJNdOeWxAZt+d2ADbLIrpzw2YNPvDmyATXbllMcGbPrdgQ2wya6c8tiATb/7mYfNlt84n/C6LnqPzbX8d8b1Zvi0z05ovVi3lNTdoj9gk2o55bEVPfTt9linxe26WLeU1N2ivwxgs9XsJryui95jcy1v7e60uIMu1lPerBb9AZtUyymPjaH3lp0Wd9DFCmyAjW855bEx9N6y0+IOuliBDbDxLac8NobeW3Za3EEX69mGzcnN3fH46i1g41VOeWwMvbfstLiDLtYzDZtn18aV3vwB2PiUUx4bQ+8tOy3uoIv1TMNmf3zp1uToxvjSfWDjUU55bAy9t+y0uIMu1rMMmye79THNs2sXvwQ2HuWUx8bQe8tOizvoYj3LsLk3frv578fAxqOc8tgYem/ZaXEHXaxnGTb740/r/z5soANs3Mopj42h95adFnfQxXqGYXNyozl9erLbXrR5qZGTz9bPaCOE9NqKFsAGIWSrrWgRDjarN78dDy63+ooJuwS1Px2YE9T+dGBOUPtHPI0CNroEtT8dmBPU/iV1AGxk/nRgTlD704E5Qe2f+t2owjayKkHtTwfmBLV/SR0Ehk37fM2Wz9kUtpFVCWp/OjAnqP1L6iAwbAI9QVzYRlYlqP3pwJyg9i+pg8CwObkxfivAu1GFbWRVgtqfDswJav+SOggMm8lRkLe+C9vIqgS1Px2YE9T+JXUQGjaTo5tT1lxdPa4BNooEtT8dmBPU/iV1EBw2ffIfokgsE6M/HZgT1P4ldQBsZP50YE5Q+9OBOUHtD2xYJhb+dGBOUPuX1AGwkfnTgTlB7U8H5gS1P7BhmVj404E5Qe1fUgfARuZPB+YEtT8dmBPU/sCGZWLhTwfmBLV/SR0AG5k/HZgT1P50YE5Q+wMblomFPx2YE9T+JXUAbGT+dGBOUPvTgTlB7Q9sWCYW/nRgTlD7l9QBsJH504E5Qe1PB+YEtT+wYZlY+NOBOUHtX1IHwEbmTwfmBLU/HZgT1P7AhmVi4U8H5gS1f0kdRIONoxz/VbsERQenLzo4ffV3AGyCiQ5OX3Rw+gI2EUQHpy86OH0Bmwiig9MXHZy+gE0E0cHpiw5OX8Amgujg9EUHpy9gE0F0cPqig9MXsIkgOjh90cHpKwPYIITKFrBBCEURsEEIRRGwQQhFEbBBCEURsEEIRRGwQQhFEbBBCEVRIrB5du3t5k8nN3fH46u3TnU0fnp2bVzrzR9OeyReynfDN8p8+xewD8w76JmKRGCzP+4OM8cF82Q358We8YZvlPf2L2EfmHfQMxVJwOZkf9wOc3986dbk6Mb40v3THZKHHrY9ZKmMN3yjvLd//vvAUgc9U5ECbH75ZNwO88luDcNn1y5+ebpj8tD++OPTHoK/ct7wjbLe/vnvA0sd9E1FArC5Nx5/9LdmmPfm/81u4ZzcyGtxdJXxhm+U9fbPfx9Y7qBvKlKAzVt/mh937Y8/rf+b4SHxs2uX/mUK9/+Y33W9Shlv+EZZb//894HlDvqmIgHYVGqGOUfik93MTlgXF8WapZKXct7wjbLe/pXy3wcezk8EN08FsAmlh9PjyPuT/3dznOPRfM4bvlHW279S/vtAC5u+qUgWNtnd+Ls3PwrO6VS7Uc4bvlHW279S/vvAw5WrTqtTkSxscqP6XA9zu2VZqYQN3yjL7V8p/31g9SrT6lScGmweds7q8t3QD1fPTvP7f0iTLDd8n7Lc/pXy3QdarcJmdSrSgk2GV+I3wCa3NVIpvw3fpzy3/yTnfaDVOmwSObLp6uHKswV5PWNQ6eRGtmukUr4bvlHm239Swj4wPzbrmYrEYJPp05OV9le2dF7KeMM3ynv7T0rYBxbHZpunIjHYTMf3Vo7vhUzqhws+uj85+iTDoU+y3vCN8t7+kxL2gaXnbDZORWKwmRzl+sZr/cB2PfQsH2HNecM3ynv7l7APzDvomYrUYDM5ujkd5dXcmF7r6Pfj8cWPshz6JOsN3yjv7V/APrDUwcapSAQ2CKHSBWwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGwQQlEEbBBCUQRsEEJRBGxQr/ZGc5278P5dy8+80PmLB6Pnvvf4GCpQwAb1agk2FW/+aPcZYIM2C9igXnVh40cNYINaARvUq70FKB5/szMaveHhAWxQK2CDerW3DIrDkRcPgA1qBWxQrzqweXoZ2KCtBGxQr3pg8+tn01Oqc6991xTqH0evfNF+pvlbt9+d/qXX785gM/1wcw42h8+d+mPtTa72Y10zVJSADepVBzY/tqdRB+0F49fb3890/vvZZ+q/dXy9uaj82WbYHH+18WMrZqgoARvUqyXY/FTBoebFlDXVQc3jr2a0ebQzemH64/HXo9GLs8/U1NibVu/OkLIRNgd1ffLrO52PrZqhogRsUK9Wbn3XFJnyoOHAQf3kzfy0qCHTnBpvNH9pI2ymP89c2pOz2cdWzVBRAjaoV3vrrFm64Ds9U3qxRc7yZ6q/N4fFFCabYHPYfmpqssSoVTNUlIAN6tUybF75tv7VjDBteQqIw+pa8bfLn5n+culv7fVdIO7UG9ismqGiBGxQrxoQHH+zMzrf3HuaUmPlmeLZld7n3/+5/cyUGvOzpKXTpnXYPL7zT5+/PFqGzaoZKkrABvVqfjL0aGd07sP6T+uwqe9x1zeQvph9Zgab9mnjPtj8+HLHpL313TVDRQnYoF4tLtMetu9hLh2zLOnO5zU6PpzYHtnM7oxfeO8PP+91YdM1Q0UJ2KBeLd0T2muOQKaU2Pyob3W7enZpePiazezn5s73ZOWazaoZKkrABvVqCTbVoUjzQEx7w6jmzhpWVu5hN3eb5oc6s58XyGruVvUwChUlYIN6tbzHP9qZndlUz93NOHFY/+Jg6Sb2/Mhm8TRO85zNnC6Hoy5sDjrXbFbNUFECNqhXncOLFgsHs6u37ZnO9NDk3AfVs8DXl67ZtM8Zz58grn5+4bv6vtbyadSdd9ov5drbaIaKErBBverAZn4iNX83anbsUR3yzPTG7DOzXzfvPp3/r/NrPbPPfD07rXqn+cxrX3cYtWKGihKwQb3qXjhpT6Qmv35W3S6av5l9/M2F6tmY139uPtOc/9xZfuu7+lvTDz3/wfxFzOrH6gG+5mpO+7GuGSpKwAYhFEXABiEURcAGIRRFwAYhFEXABiEURcAGIRRFwAYhFEXABiEURcAGIRRFwAYhFEXABiEURcAGIRRFwAYhFEXABiEURcAGIRRFwAYhFEXABiEURcAGIRRFwAYhFEXABiEURf8f6Ilo5dN53cQAAAAASUVORK5CYII=" />

<!-- rnb-plot-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The residuals of the both models, follow more or less a Gaussian distribution as it can be seen in both graphs

### 2.1.b.v)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5tb2QxIDwtIGMoc3VtbWFyeShtb2RlbDEpJHIuc3EsIHN1bW1hcnkobW9kZWwxKSRhZGouci5zcXVhcmVkLCBzdW1tYXJ5KG1vZGVsMSkkc2lnbWEsIHNxcnQobWVhbihtb2RlbDEkcmVzaWR1YWxzXjIpKSlcbm1vZDIgPC0gYyhzdW1tYXJ5KG1vZGVsMikkci5zcSwgc3VtbWFyeShtb2RlbDIpJGFkai5yLnNxdWFyZWQsIHN1bW1hcnkobW9kZWwyKSRzaWdtYSwgc3FydChtZWFuKG1vZGVsMiRyZXNpZHVhbHNeMikpKVxuXG5wcmludChtb2QxKVxuYGBgIn0= -->

```r

mod1 <- c(summary(model1)$r.sq, summary(model1)$adj.r.squared, summary(model1)$sigma, sqrt(mean(model1$residuals^2)))
mod2 <- c(summary(model2)$r.sq, summary(model2)$adj.r.squared, summary(model2)$sigma, sqrt(mean(model2$residuals^2)))

print(mod1)
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIDAuODE3MDMzNiAwLjgxMzUxNTAgMy4zNjY5MTg0IDMuMzMwNTE4MlxuWzFdIDAuODEyNTgwNiAwLjgxMTA1MjcgMy4zODkwNzM2IDMuMzcwODAzNVxuIn0= -->

```
[1] 0.8170336 0.8135150 3.3669184 3.3305182
[1] 0.8125806 0.8110527 3.3890736 3.3708035
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


The second model is more cost-efficient due to the fact that perfomrs less calculations taking into account that uses a lower number of predictors or attributes. We have get rid of the non-important ones. Therefore we get the same results with less.

Also p and F values are more important in this second analysis, so it is more credible. 

c)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5uYW1lcyhwcmVkKSA8LSBjKCdDb25maWRlbmNlJywgJ0xvd2VyJywgJ1VwcGVyJylcbnByZWQkUmVzcG9uc2UgPC0gdGVzdC5kZlssICdtcGcnXVxuXG4gIGZvciAoeCBpbiAxOmRpbShwcmVkKVsxXSl7XG4gICAgaWYocHJlZFt4LCAnTG93ZXInXSA8IHByZWRbeCwgJ1Jlc3BvbnNlJ10gJiBwcmVkW3gsICdSZXNwb25zZSddIDwgcHJlZFt4LCAnVXBwZXInXSkge1xuICAgICAgcHJlZFt4LCAnTWF0Y2hlcyddID0gMVxuICAgIH0gZWxzZXtcbiAgICAgIHByZWRbeCwgJ01hdGNoZXMnXSA9IDBcbiAgICB9XG4gIH0gIFxucHJpbnQocHJlZClcbmBgYCJ9 -->

```r

names(pred) <- c('Confidence', 'Lower', 'Upper')
pred$Response <- test.df[, 'mpg']

  for (x in 1:dim(pred)[1]){
    if(pred[x, 'Lower'] < pred[x, 'Response'] & pred[x, 'Response'] < pred[x, 'Upper']) {
      pred[x, 'Matches'] = 1
    } else{
      pred[x, 'Matches'] = 0
    }
  }  
print(pred)
```

<!-- rnb-source-end -->

<!-- rnb-frame-begin eyJtZXRhZGF0YSI6eyJjbGFzc2VzIjpbImRhdGEuZnJhbWUiXSwibnJvdyI6MjAsIm5jb2wiOjUsInN1bW1hcnkiOnsiRGVzY3JpcHRpb24iOlsiZGYgWzIwIMOXIDVdIl19fSwicmRmIjoiSDRzSUFBQUFBQUFBQmd0eWlURG1pdUJpWUdCZ1ptQmhZbVJnWmdVeUdWaERROXgwTFJpQUlrQU9Jd01MQXllSXJnQXFFZ2JKQWpFZkVJczRtQjNkOU9vc0M2K0R0a2g5NXM2WlpnNUtrZkhaTjU1bE9WalYyaXkyWXV0ek1OMzB6SFNLekFRSDFVSitucmVkUmc0bW5VbXpBOHZQT3hoc0RUalRmbGpjd1ZadWN1TTV5YzhPRmprZWs5MUVJaHpNbFhvdHRUYnZjOUI5WTNoRHMrYVNnK243VHk0M1l3d2Q3RGsrRzZTOCtPOWdLL1gvVkl2RFV3YzdycmozYmpQeUhHejNkUDlaTVdHRGcwUEluL0JwUVI0T2pvdlhpdnp0OUhLd2J3elRhbE85QVhlbjZjbnkzRk4rNlE2YXBSdXZGQ20vY1pBTFoyelBaOGx6c0Z6NGJYbSsrWDhIazkzWG90NHdDemtvcy80OHlpSDV4Y0g0VFZHWFJNY1ZCMzExYWVFTDNrb09OdUY4cXgwUEZEbVlyNThpOG11emxZT1oyOVRaTXdJbk8rZ2tOOGpkV0N2cllKcjJjSXJnMFU0SHU1VExnaXMzSFhLdzRjeWFuV1hHNldBcldIQlAzZXF3ZzgyYWJaT21yZzF4c0YrL2ZGb0piNStEbzdMVnZCTXIweHpzMnFkclpkL2pnYnZUL09DNzlQTTdOenZvYlBiNXo4alg0S0RhYmlmOHkydXVnM1ZFMDN5V3E3SU9aaXUvQ2RpWThUbW8zMUVKdWZTandNRlVMV2hOVjlvcEI4UHJJdnpxQ1hNZGJKOUpSRVFWbHpoWWF2d1ZuRmhhNW1EK3IrWGFYdEdYRHZvbGp5ZFcrYlE3bUZVeWZWM3c2YWFEL1ZwaGZ3VjVHd2M3blNrLzUza2ZkTEJuOW1WSS9TYnBZSGNtTVcxM0NZK0R3eVdWeDUvbW5uUndVcEh2TnNyVWMzQ3c3Wm9hWUhZSjdrNUxCakJ3MElMU0dsRGFERW9iUTJrZE5MNGhsTGFGMHVab3RBR1VOcGtKQXJNYzdCc2dmRWRKQ04vMkRBaWNkYkNEcW5PR3lqdEJhWHVJUHBnN0dhREEvZ01EU1FDbUhsMGZMbk53cVNPc0hpV0RzZVlsNXFZV0F4a0NJQTVVa01zNVB5OHRNeVUxTHprVnBzd252enkxQ01ZSkxTaUFjemlDVW9zTDh2T0tZU3JaZlJOTGtqTkFScUxZdzFtVVg2NkhiSmNJVklMSnlCakdzakNEc1N4aExHWkRRME00MHdqQk5ER0FNMDJONFV3emhBSnpoQW5tRmdpbUpaeHBBV2NhbVNLWUNBWEdCa1p3cGlGQzFNUVl3VFJGTU9GV0dBTU5Rd3ZoNUp6RVlwaXZZWUpjS1lrbGlYcHBSY0FBQWZMK29XbGh6eThveVFTR0tUQWtZR1Vmc21iR0lqUUJ3ZEk4VU5DbTZDWm5sT1psNnhvYW1ZQ3NBQ3VBWUY0b0xZTEVab1ZZeXZRZkxmTFpVdlBTTS9QZ0VaK1RtSlNhQStYd0FTTVJISWQ2QlVXWmVTVXd2d0JGaS9WSzhrc1NZZXE0a3ZOellDSmczekg4QXdET1d5KzA5QVVBQUE9PSJ9 -->

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["Confidence"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["Lower"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Upper"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Response"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Matches"],"name":[5],"type":["dbl"],"align":["right"]}],"data":[{"1":"22.772261","2":"21.786979","3":"23.75754","4":"25.0","5":"0","_rn_":"23"},{"1":"13.540035","2":"12.729872","3":"14.35020","4":"13.0","5":"1","_rn_":"86"},{"1":"9.174556","2":"7.584967","3":"10.76415","4":"12.0","5":"0","_rn_":"96"},{"1":"26.489207","2":"25.632670","3":"27.34574","4":"22.0","5":"0","_rn_":"111"},{"1":"21.698825","2":"20.733740","3":"22.66391","4":"19.0","5":"0","_rn_":"121"},{"1":"10.720818","2":"9.511671","3":"11.92996","4":"14.0","5":"0","_rn_":"140"},{"1":"20.536661","2":"19.923623","3":"21.14970","4":"19.0","5":"0","_rn_":"153"},{"1":"16.708264","2":"15.576378","3":"17.84015","4":"17.0","5":"1","_rn_":"161"},{"1":"29.119438","2":"28.340068","3":"29.89881","4":"29.0","5":"1","_rn_":"176"},{"1":"24.422982","2":"23.685853","3":"25.16011","4":"23.0","5":"0","_rn_":"178"},{"1":"23.134967","2":"22.275720","3":"23.99421","4":"23.0","5":"1","_rn_":"179"},{"1":"14.961318","2":"14.194337","3":"15.72830","4":"16.0","5":"0","_rn_":"189"},{"1":"21.937290","2":"21.401880","3":"22.47270","4":"20.6","5":"0","_rn_":"259"},{"1":"31.034961","2":"30.393846","3":"31.67608","4":"31.5","5":"1","_rn_":"279"},{"1":"29.105466","2":"28.036783","3":"30.17415","4":"34.2","5":"0","_rn_":"302"},{"1":"30.040511","2":"29.068128","3":"31.01289","4":"29.8","5":"1","_rn_":"319"},{"1":"29.736511","2":"28.674661","3":"30.79836","4":"30.0","5":"1","_rn_":"343"},{"1":"32.663951","2":"31.686151","3":"33.64175","4":"39.0","5":"0","_rn_":"345"},{"1":"35.278720","2":"34.275226","3":"36.28221","4":"37.0","5":"0","_rn_":"348"},{"1":"31.505221","2":"30.529650","3":"32.48079","4":"31.6","5":"1","_rn_":"359"}],"options":{"columns":{"min":{},"max":[10],"total":[5]},"rows":{"min":[10],"max":[10],"total":[20]},"pages":{}}}
  </script>
</div>

<!-- rnb-frame-end -->

<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubnVtYmVyID0gYXBwbHkocHJlZFtjKCdNYXRjaGVzJyldLCAyLCBzdW0pXG5wcmludChwYXN0ZTAoJ09ic2VydmF0aW9ucyBwcmVkaWN0ZWQ6ICcsIG51bWJlcikpXG5gYGAifQ== -->

```r
number = apply(pred[c('Matches')], 2, sum)
print(paste0('Observations predicted: ', number))
```

<!-- rnb-source-end -->

<!-- rnb-output-begin eyJkYXRhIjoiWzFdIFwiT2JzZXJ2YXRpb25zIHByZWRpY3RlZDogOFwiXG4ifQ== -->

```
[1] "Observations predicted: 8"
```



<!-- rnb-output-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->


e)


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5wcmVkIDwtICBkYXRhLmZyYW1lKHByZWRpY3QobW9kZWwxLCB0ZXN0LmRmLCBpbnRlcnZhbCA9IFwicHJlZGljdGlvblwiLCBsZXZlbCA9IDAuOTUpKVxubmFtZXMocHJlZCkgPC0gYygnQ29uZmlkZW5jZScsICdMb3dlcicsICdVcHBlcicpXG5wcmVkJFJlc3BvbnNlIDwtIHRlc3QuZGZbLCAnbXBnJ11cblxuICBmb3IgKHggaW4gMTpkaW0ocHJlZClbMV0pe1xuICAgIGlmKHByZWRbeCwgJ0xvd2VyJ10gPCBwcmVkW3gsICdSZXNwb25zZSddICYgcHJlZFt4LCAnUmVzcG9uc2UnXSA8IHByZWRbeCwgJ1VwcGVyJ10pIHtcbiAgICAgIHByZWRbeCwgJ01hdGNoZXMnXSA9IDFcbiAgICB9IGVsc2V7XG4gICAgICBwcmVkW3gsICdNYXRjaGVzJ10gPSAwXG4gICAgfVxuICB9ICBcbnByaW50KHByZWQpXG5udW1iZXIgPSBhcHBseShwcmVkW2MoJ01hdGNoZXMnKV0sIDIsIHN1bSlcbnByaW50KHBhc3RlMCgnT2JzZXJ2YXRpb25zIHByZWRpY3RlZDogJywgbnVtYmVyKSlcblxuIFxuYGBgIn0= -->

```r

pred <-  data.frame(predict(model1, test.df, interval = "prediction", level = 0.95))
names(pred) <- c('Confidence', 'Lower', 'Upper')
pred$Response <- test.df[, 'mpg']

  for (x in 1:dim(pred)[1]){
    if(pred[x, 'Lower'] < pred[x, 'Response'] & pred[x, 'Response'] < pred[x, 'Upper']) {
      pred[x, 'Matches'] = 1
    } else{
      pred[x, 'Matches'] = 0
    }
  }  
print(pred)
number = apply(pred[c('Matches')], 2, sum)
print(paste0('Observations predicted: ', number))

 
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->







### Part 2.1.f

The confidence interval defines to which stand do we accept the errors. That is to say, the limit f that we accept will only be defined by the confidence interval that we choose.

In the 'e' one, we chose the confidence interval, whereas in the 'f' one, we choose the prediction interval. As it will be explained later, the predicton interval it is usually wider than the confidence one. That is why in the prediction interval we got 20 observations predicted within the interval. It is less restrictive the analysis. 




### Part 2.1.f.i
The f one, with the prediction interval got more many matches, 12 more.


### Part 2.1.f.ii

It happens because the prediction interval is usually bigger than the confidence interval due to the fact that it contains more types of errors. For example, compared to the confidence interval, it also contains the reducible error appart from the irreducible. 



### References
Multiple regression model

https://www.analyticsvidhya.com/blog/2020/12/predicting-using-linear-regression-in-r/

<!-- rnb-text-end -->

