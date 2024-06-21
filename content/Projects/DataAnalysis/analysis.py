import pandas as pd
# Load data
data = pd.read_csv('data.csv')
# Perform analysis
summary = data.describe()
# Save summary to a file
summary.to_csv('summary.csv')
print("Analysis complete. Summary saved to summary.csv.")