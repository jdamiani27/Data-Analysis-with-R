library(ggplot2)
data(diamonds)

head(diamonds)

# price vs x scatterplot
ggplot(aes(x = x, y = price), data = diamonds) +
  geom_point(alpha = 0.05)

# correlations
## price vs x
cor.test(diamonds$price, diamonds$x)

## price vs y
cor.test(diamonds$price, diamonds$y)

## price vs z
cor.test(diamonds$price, diamonds$z)

# price vs depth scatterplot
ggplot(aes(x = depth, y = price), data = diamonds) +
  geom_point(alpha = 0.05)

# price vs depth adjustments
ggplot(data = diamonds, aes(x = depth, y = price)) + 
  geom_point(alpha = 1/100) +
  scale_x_continuous(breaks = seq(min(diamonds$depth),max(diamonds$depth),2))

# Correlation - price and depth
cor.test(diamonds$price, diamonds$depth)

# price vs. carat scatterplot - remove top 1%
ggplot(aes(x = carat, y = price), 
       data = subset(diamonds, 
                     price <= quantile(price, probs = 0.99) & carat <= quantile(carat, probs = 0.99))) +
  geom_point()

# scatterplot of price vs. volume (x * y * z)
diamonds$volume <- with(diamonds, x*y*z)

ggplot(aes(x = volume, y = price), data = diamonds) +
  geom_point()

## correlation removing outliers
with(subset(diamonds, volume > 0 & volume < 800), cor.test(price, volume))

## price vs. volume adjustments
ggplot(aes(x = volume, y = price), data = subset(diamonds, volume > 0 & volume < 800)) +
  geom_point(alpha = 0.01) +
  stat_smooth(method = "lm")
