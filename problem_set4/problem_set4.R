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

# Mean Price by Clarity
pf.fc_by_age_months <- pf %>% group_by(age_with_months) %>% 
  summarise(friend_count_mean = mean(friend_count),
            friend_count_median = median(friend_count),
            n = n()) %>%
  arrange(age_with_months)

library(dplyr)

diamondsByClarity <- diamonds %>% group_by(clarity) %>%
  summarise(mean_price = mean(price),
            median_price = median(as.numeric(price)),
            min_price = min(price),
            max_price = max(price),
            n = n()) %>%
  arrange(clarity)

# Bar Charts of Mean Price
diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

library(gridExtra)

p1 <- ggplot(aes(x = clarity, y = mean_price), data = diamonds_mp_by_clarity) +
  geom_bar(stat = "identity")

p2 <- ggplot(aes(x = color, y = mean_price), data = diamonds_mp_by_color) +
  geom_bar(stat = "identity")

grid.arrange(p1,p2)
 