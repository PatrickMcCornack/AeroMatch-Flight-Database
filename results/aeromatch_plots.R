# ----
# The following creates simple visualizations of run-time comparisons between
# graph database queries using different numbers of partitions in Pyspark
# as well as a breadth-first-search in Neo4j.
#
# Author: Pat McCornack
# Date: 12/8/2022
# ----


library(ggplot2)
library(dplyr)

# Set to your working directory path: 
setwd("G:/My Drive/WSU DA/CPTS 415 - Big Data/Project/aeromatch_code/results")

# Read in data
df <- read.csv("./run_data_1.csv")
df2 <- read.csv("./run_data_5.csv")
df3 <- read.csv("./run_data_10.csv")
neo4j <- read.csv("./neo4j_query.csv")

# Configure data
neo4j$hops <- df$hops[1:249]
df <- rbind(df, df2)
df <- rbind(df, df3)

df$hops <- as.factor(df$hops)
df$partition <- as.factor(df$partition)


# 1 partition
ggplot(data = filter(df, df$partition == 1), aes(x=hops, y = time)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = .2) +
  labs(title = "Shortest Path Execution time vs. Number of Hops",
       subtitle = "1 partition",
       x = "Number of Hops",
       y = "Shortest Path Execution Time (s)") +
  theme_bw()
ggsave("./plots/partitions_1.jpeg", 
       width = 7,
       height = 5.5)

# 5 partitions
ggplot(data = filter(df, df$partition == 5), aes(x=hops, y = time)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = .2) +
  labs(title = "Shortest Path Execution time vs. Number of Hops",
       subtitle = "5 partitions",
       x = "Number of Hops",
       y = "Shortest Path Execution Time (s)") +
  theme_bw()
ggsave("./plots/partitions_5.jpeg", 
       width = 7,
       height = 5.5)


# 10 partitions
ggplot(data = filter(df, df$partition == 10), aes(x=hops, y = time)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = .2) +
  labs(title = "Shortest Path Execution time vs. Number of Hops",
       subtitle = "10 partitions",
       x = "Number of Hops",
       y = "Shortest Path Execution Time (s)") +
  theme_bw()
ggsave("./plots/partitions_10.jpeg", 
       width = 7,
       height = 5.5)


# Neo4j
ggplot(data = neo4j, aes(x=hops, y = times)) +
  geom_boxplot() +
  geom_jitter(width = 0.2, alpha = .2) +
  labs(title = "Shortest Path Execution time vs. Number of Hops",
       subtitle = "Neo4j Breadth First Search",
       x = "Number of Hops",
       y = "Shortest Path Execution Time (s)") +
  theme_bw()
ggsave("./plots/neo4j_results.jpeg", 
       width = 7,
       height = 5.5)


# Comparison
ggplot(data = df, aes(x=hops, y = time, fill = partition)) +
  geom_boxplot() +
  labs(title = "Shortest Path Execution time vs. Number of Hops",
       x = "Number of Hops",
       y = "Shortest Path Execution Time (s)") +
  coord_cartesian(ylim = c(0, 45)) +
  scale_fill_brewer(palette = "Blues") +
  theme_bw() +
  guides(fill=guide_legend(title="# Partitions"))
ggsave("./plots/partition_comparison.jpeg", 
       width = 7,
       height = 5.5)

