
require(tidyverse)

depth <- 30
alt <- 25

mut_VAF_CI <- Vectorize(function(depth, alt, plot=FALSE){
  
  alpha = alt + 1
  beta = depth - alt + 1
  
  
  CI <- qbeta(c(0.025,0.975), alpha, beta)
  
  VAF_hat <- alt/depth
  
  CI_low <- CI[1]
  CI_up <- CI[2]
  
  if(plot==TRUE){
    
    gg <- ggplot(data.frame(x=c(0, 1)), aes(x=x)) + 
      stat_function(fun = function(x) dbeta(x, alpha, beta) ) + 
      geom_vline(xintercept = VAF_hat, colour="blue", linetype=2) +
      geom_vline(xintercept = CI, colour="red", linetype=2)
    print(gg)
  }
  
  out <- c(CI_low= CI_low, VAF_hat= VAF_hat, CI_up= CI_up)
  out
  
})


# mut_VAF_CI(59, 10)
# 
# df <- data.frame(DEP=c(50,67,43,100,10), ALT= c(3,56,34,10,4))
# 
# mut_VAF_CI(df$DEP, df$ALT)




mut_VAF_CI(250, 13, plot=T)


dbinom(10, 100, 0.10)

pbinom(10, 250, 0.1, lower.tail = F)

pbinom(5, 233, 0.05, lower.tail = F)



library(ggplot2)

# Parameters
size <- 210
prob <- 0.05
x <- 0:size

# Calculate PMF
pmf <- dbinom(x, size, prob)

# Create data frame
df_pmf <- data.frame(x, pmf)

# Plot PMF with ggplot2 as a line plot
ggplot(df_pmf, aes(x = x, y = pmf)) +
  geom_line(color = "blue", size = 1) +
  labs(title = "Binomial Distribution (n=210, p=0.05)",
       x = "Number of Successes (Mutant Reads)",
       y = "Probability") +
  geom_vline(xintercept = 5, color = "red", linetype = "dashed") +
  theme_minimal() 

pbinom(5, 207, 0.05, lower.tail = F)

qbinom(c(0.05,0.95), 207, 0.05)

207*0.05


 ggplot(data.frame(x=c(0, 210)), aes(x=x)) + 
      stat_function(fun = function(x) dbinom(x, size, prob) )



library(ggplot2)
df <- data.frame(x=1:200, prob=dbinom(1:200, 200, prob=0.8))
ggplot(df, aes(x = x, y = prob)) + 
   geom_line() +
   geom_ribbon(data = subset(df, x >= 160 & x <= 200),
               aes(ymax = prob),
               ymin = 0,
               fill = "red",
               colour = NA, 
               alpha = 0.5)




prop.test(1000, 520, 0.5, alternative = "two.sided", conf.level = 0.95)
