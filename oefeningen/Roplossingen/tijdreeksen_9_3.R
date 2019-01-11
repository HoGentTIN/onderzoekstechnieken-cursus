# Oefening 9.3 -- Voorspellen ahv Holt-Winters

DiskUsage <- read.csv('../oef9_3_backup.csv')
DiskUsageTS <- ts(DiskUsage$disk.usage, frequency = 7)

DiskUsageModel <- HoltWinters(DiskUsageTS)
DiskUsageForecast <- predict(DiskUsageModel, n.ahead = 14)
plot(DiskUsageModel, DiskUsageForecast)
