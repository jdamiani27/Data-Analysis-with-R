# Price Histograms with Facet and Color
#======================================================
library(ggplot2)
data(diamonds)

ggplot(aes(x = price, fill = cut), data = diamonds) +
  geom_histogram() +
  facet_wrap(~color) +
  scale_fill_brewer(type = 'qual')

# Price vs. Table Colored by Cut
#======================================================
ggplot(aes(x = table, y = price, color = cut), data = diamonds) +
  geom_point() +
  scale_color_brewer(type = 'qual')

# Price vs. Volume and Diamond Clarity
#======================================================
diamonds$volume <- with(diamonds, x*y*z)

ggplot(aes(x = volume, y = price, color = clarity), 
       data = subset(diamonds, volume < quantile(diamonds$volume, 0.9))) +
  geom_point() +
  scale_y_log10() +
  scale_color_brewer(type = 'div')

# Proportion of Friendships Initiated
#======================================================
setwd('/Users/jasondamiani/Udacity/Data Analysis with R/problem_set5/')

pf <- read.delim('pseudo_facebook.tsv')
pf$prop_initiated = pf$friendships_initiated/pf$friend_count

# prop_initiated vs. tenure
#======================================================
pf$year_joined <- floor(2014 - pf$tenure/365.)
pf$year_joined.bucket <- cut(pf$year_joined, breaks = c(2004, 2009, 2011, 2012, 2014))

ggplot(aes(x = tenure, y = prop_initiated), 
       data = subset(pf, !is.na(prop_initiated))) +
  geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y = median)

# Smoothing prop_initiated vs. tenure
#======================================================
ggplot(aes(x = tenure, y = prop_initiated), 
       data = subset(pf, !is.na(prop_initiated))) +
  geom_smooth(aes(color = year_joined.bucket))

# Largest Group Mean prop_initiated
#======================================================
summary(with(subset(pf, year_joined.bucket == "(2012,2014]"), prop_initiated))

# Price/Carat Binned, Faceted, & Colored
#======================================================
ggplot(aes(x = cut, y = price/carat, color = color), data = diamonds) +
  geom_jitter() +
  facet_wrap(~clarity) +
  scale_color_brewer(type = 'div')