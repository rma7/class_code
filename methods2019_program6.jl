
# load needed packages

using CSV
using DataFrames

using Distributions
using HypothesisTests

using Random


adult_df = CSV.File("../../data/adult.data", header=0, footerskip=1) |> DataFrame

#println(adult_df)
println(describe(adult_df))
#println("$(describe(adult_df))")

# print out first element (all the rows of a column)
#println(adult_df[1])

# print out contents of the 7th element (all the rows of a column)
#println(adult_df[7])

# print out the 7th row, 10th column
println(adult_df[7,10])

avg_age_val = mean(adult_df[1])

med_val = median(adult_df[1])
max_val = maximum(adult_df[1])

println("avg = $avg_age_val")
println("median is $med_val")
println("max value is $max_val")

# get the ages for those who were never married and those who are married
nvr_age_array = adult_df[adult_df[6] .== " Never-married", 1]
mar_age_array = adult_df[adult_df[6] .== " Married-civ-spouse", 1]


# calculate the means and stdevs for nvr and mar
nvr_age_avg = mean(nvr_age_array)
mar_age_avg = mean(mar_age_array)

nvr_age_std = std(nvr_age_array)
mar_age_std = std(mar_age_array)

println("Avg NVR age is: $nvr_age_avg (+/- $nvr_age_std)")
println("Avg MAR age is: $mar_age_avg (+/- $mar_age_std)")


# create gaussian distributions for each population
nvr_gaussian = Normal(nvr_age_avg, nvr_age_std)
mar_gaussian = Normal(mar_age_avg, mar_age_std)

Random.seed!(42)


n = 2500

nvr_sample = rand(nvr_gaussian, n)
mar_sample = rand(mar_gaussian, n)

display(EqualVarianceTTest(nvr_sample,mar_sample))




























