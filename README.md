# 625-hw3

## Overview
 - linear_regression(): linear regression
 - glm_regression(): generalized linear regression (binomial/poisson)
 - logistic():logistic regression
 - miceanalyze(): help you analyze the mice results based on RE

##Installation
download the hw3 file in your path
then install.packages("hw3")

## implement
1.miceanalyze(): Because there is no function that automatically analyzes the results after the imputation, it can help you to analyze the result of imputation using mice.

2.for binary outcome, the speed of glm is improved.

![Screenshot 2023-11-14 225342](https://github.com/sangyisu/625-hw3/assets/117102360/c2b9aa03-0847-400a-8741-133389d19f18)

## test(vignette file)
### correctness and efficency
- linear_regression()

![Screenshot 2023-11-14 230908](https://github.com/sangyisu/625-hw3/assets/117102360/dbe393b6-7041-4e9e-8295-3581de798212)

![Screenshot 2023-11-14 225410](https://github.com/sangyisu/625-hw3/assets/117102360/a809f70d-0f86-4ff1-9977-032bb78c56c6)

- glm_regression()
for poisson distribution:
![Screenshot 2023-11-14 230908](https://github.com/sangyisu/625-hw3/assets/117102360/df618930-fdc6-431e-aa6e-86078bb164c8)

![Screenshot 2023-11-14 225410](https://github.com/sangyisu/625-hw3/assets/117102360/5f4ac17b-1758-4063-879c-8e34cb96c6bf)

for binomial distribution:
![Screenshot 2023-11-14 230908](https://github.com/sangyisu/625-hw3/assets/117102360/c1588c2e-e59c-4197-babd-5dacec1e91c4)

![Screenshot 2023-11-14 225403](https://github.com/sangyisu/625-hw3/assets/117102360/6db0f174-70c4-4d3b-b1dc-7c2da20d6dfe)

- 
