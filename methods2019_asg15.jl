################################################################################
#
# Program:      methods2019_asg15.jl
# Purpose:      BMI calculator and classifier for BRFSS
# Description:	Calculate and classify body mass index (BMI) from height
#				and weight values provided in BRFSS 2017 (Rhode Island only)
# Last modified by:	BCBI (bcbi@brown.edu)
# Last modified on:	2019-03-04
#
################################################################################

# open input and output files
input_file = open("brfss2017_ri.txt", "r")

# initiatialize variables
weight_status_dict = Dict()
weight = height = ""
weight_value = height_value = bmi = 0
status = "N/A"

# read in each line in input file
for line in readlines(input_file)

	# get weight (183-186)
	# 50-0999: pounds
	# 7777: don't know/not sure
	# 9000-9998: kilograms (9 indicates metric)
	# 9999: refused
	# BLANK: not asked or missing
	weight = line[183:186]
	if weight == "7777" || weight == "9999" || weight == "    "
		weight_value = 0
	elseif occursin(r"^9", weight) # kilograms -> pounds
		weight_value = parse(Int64, weight[2:4]) * 2.20462
	elseif occursin(r"^0", weight) # pounds
		weight_value = parse(Int64, weight)
	end

	# get height (187-190)
	# 200-711: ft/inches (0_/__)
	# 7777: don't know/not sure
	# 9000-9998: meters/centimeters (9 indicates metric)
	# 9999: refused
	# BLANK: not asked or missing
	height = line[187:190]
	if height == "7777" || height == "9999" || height == "    "
		height_value = 0
	elseif occursin(r"^9", height) # centimeters -> inches
		height_value = parse(Int64, height[2:4]) * 0.393701
	elseif occursin(r"^0", height) # inches
		height_value = parse(Int64, height[2]) * 12 + parse(Int64, height[3:4])
	end

	# get bmi and status
	if weight_value != 0 && height_value != 0
		# calculate bmi
		bmi = (weight_value / height_value^2) * 703
		# determine weight status based on calculated BMI (if-elseif-else)
		if bmi < 18.5
			status = "Underweight"
		elseif bmi < 25.0
			status = "Normal Weight"
		elseif bmi < 30.0
			status = "Overweight"
		elseif bmi < 40.0
			status = "Obese"
		else
			status = "Extreme or high risk obesity"
		end
	end
	println("$weight_value --- $height_value --- $status")

	# count frequency of weight status
	if haskey(weight_status_dict, status)
		weight_status_dict[status] += 1
	else
		weight_status_dict[status] = 1
	end

	# reset variables
	weight_value = height_value = bmi = 0
	global status = "N/A"
end

# close input and output files
close(input_file)

# print frequency of each weight status
total = 0
println("Distribution of Weight Status")
println("------------------------------")
for key in sort(collect(keys(weight_status_dict)))
	println("$(key) = $(weight_status_dict[key])")
	global total += weight_status_dict[key]
end
println("TOTAL = $total")

# print frequency of each weight status
println()
println("Distribution of Weight Status")
println("------------------------------")
output_file = open("methods2019_asg11_output.txt", "w")
for (count_value, weight_key) in sort(collect(zip(values(weight_status_dict),keys(weight_status_dict))), rev=true)
	println("$(weight_key) = $(weight_status_dict[weight_key])")
	write(output_file, "$(weight_key) = $(weight_status_dict[weight_key])\n")
end
