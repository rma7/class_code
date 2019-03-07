################################################################################
#
# Program:      methods2019_asg11.jl
# Purpose:      Process full BRFSS lines for weight question
# Description:  Get weight values and determine frequency of weights
#				in imperial units, metric units, or not reported.
# Last modified by:	BCBI (bcbi@brown.edu)
# Last modified on:	2019-03-04
#
################################################################################

# open input and output files
input_file = open("brfss2017_ri.txt", "r")

# Dictionary for counts
weight_count_dict = Dict()
weight_count_dict["imperial"]     = 0
weight_count_dict["metric"]       = 0
weight_count_dict["not reported"] = 0
weight_count_dict["weird"]		  = 0

# read in each line in input file
for line in readlines(input_file)

	# get weight
	weight = line[183:186]
	#println("weight = *$weight*")
	# check if imperial, metric, or not reported
	if weight == "7777" || weight == "9999" || weight == "    "
		weight_count_dict["not reported"] += 1
	elseif occursin(r"^9", weight)
		weight_count_dict["metric"] += 1
	elseif occursin(r"^0", weight)
		weight_count_dict["imperial"] += 1
	else
		weight_count_dict["weird"] += 1
	end
end

# close input and output files
close(input_file)

# print weight types
println("Distribution of Weight Types")
println("------------------------------")

output_file = open("methods2019_asg11_output.txt", "w")
for (count_value, weight_key) in sort(collect(zip(values(weight_count_dict),keys(weight_count_dict))), rev=false)
	println("$(weight_key) = $(weight_count_dict[weight_key])")
	write(output_file, "$(weight_key) = $(weight_count_dict[weight_key])\n")
end

# close second file handle
close(output_file)
