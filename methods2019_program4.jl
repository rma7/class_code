# methods2019_program4.jl
# File input/output
# Created: 2019-03-05

# open input file
input_file = open("class_code/brfss2017_ri.txt", "r") # relative path
# input_file = open("/Users/eschen/methods2019/code/class_code/brfss2017_ri.txt", "r") # absolute path

# create dictionary for counts
asthma_dx_count_dict = Dict()

# dictionary for asthma values
asthma_dx_dict = Dict()
asthma_dx_dict["1"] = "Yes"
asthma_dx_dict["2"] = "No"
asthma_dx_dict["7"] = "Don't know/Not Sure"
asthma_dx_dict["9"] = "Refused"
asthma_dx_dict[" "] = "BLANK"

# read in each line in input file
for line in readlines(input_file)
	#println("***$line***")

	# get asthma dx value
	asthma_dx_value = string(line[109])

	# keep track of number of times each asthma dx value occurs
	if haskey(asthma_dx_count_dict, asthma_dx_value)
		asthma_dx_count_dict[asthma_dx_value] += 1
	else
		asthma_dx_count_dict[asthma_dx_value] = 1
	end

	# get tobacco interval value
	tobacco_interval_value = line[201:202]

	#println("$asthma_dx_value --- $tobacco_interval_value")

end

# close file
close(input_file)

# print frequency of each value for asthma dx
println("Distribution of Asthma Diagnosis")

output_file = open("methods2019_program4_output.txt", "w")

for key in keys(asthma_dx_count_dict)
	println("$key = $(asthma_dx_count_dict[key])")
	println("... translates to $(asthma_dx_dict[key]) = $(asthma_dx_count_dict[key])")
	write(output_file, "$(asthma_dx_dict[key]) = $(asthma_dx_count_dict[key])\n")
end

close(output_file)








