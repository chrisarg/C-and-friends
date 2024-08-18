library(data.table)
library(knitr)
library(ggplot2)
library(viridisLite)
# Load the data from C and Perl and Cbind them
data <- rbindlist(list(
  fread("Perl_alloc_results_avx2.csv")
))
data[, IPS := 1 / Time]

## convert Iteration to a factor in log10 scale
data[, Length := as.factor(paste("10^",log10(Length),sep=""))]

## after loading data, create a new column that has the value "Set" if the
## Operation contains the word "set", "Zero" if it contains the word "zero"
## and "Non-init" otherwise
data[, Init := ifelse(grepl("set", Operation),
                           "Set",
                           ifelse(grepl("zero", Operation), "Zero", "Non-init"))]

num_of_colors = nlevels(factor(data$Operation))
ggplot(data[], aes(x = Length, y = IPS, color = Operation)) +
  geom_boxplot(outlier.shape = 1,outlier.size = 0.5)+
  scale_y_log10() +
  theme_minimal() +
  theme(legend.position = "top") +
  labs(x = "Buffer Length (bytes)", y = "Buffers Per Second (IPS)", color = "Allocation Type") +
  ggtitle("Benchmark for Buffer Generations C/Perl ") +
  facet_grid(Init~Language)+
  scale_color_discrete(type=viridis(num_of_colors,option="H"))+
  theme(plot.title = element_text(hjust = 0.5))






## print statistics by operation 
stats <- data[, .(
  mean = mean(IPS),
  sd = sd(IPS),
  median = median(IPS),
  IQR = IQR(IPS),
  min = min(IPS),
  max = max(IPS)
), by = .(Operation,Length,Language)]
kable(stats[order(Length,-mean,Language)], format = "markdown",digits=2)
