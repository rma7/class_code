################################################################################
#
# Program: bmi_calculator.jl
# Purpose: Clinical decision support (CDS) tool for BMI
# Description: Calculates a patient’s body mass index (BMI) based on provided
#	weight and height and determines patient’s weight status.
#	Assumes no error checking (e.g., out-of-range values).
#	Future versions should includes more robust validation and error
#	checks (e.g., invalid values).
#	https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html
# Created by: BCBI (bcbi@brown.edu)
# Created on: 2018-02-12
# Last modified by: BCBI (bcbi@brown.edu)
# Last modified on: 2019-02-11
#
################################################################################

#using Printf    # if using @printf

println("\n==============================================================")
println("Welcome to the Body Mass Index (BMI) Calculator and Classifier")
println("==============================================================")

# ask if Imperial (lb and in) or Metric (kg and cm)
print("Imperial [I] or Metric [M]? ")
system = readline(stdin)

# get weight as entered by the user
if system == "I"
	print("Weight (lb)? ")
elseif system == "M"
	print("Weight (kg)? ")
end
weight = parse(Float64, readline(stdin))

# get height as entered by the user
if system == "I"
	print("Height (in)? ")
elseif system == "M"
	print("Height (cm)? ")	
end
height = parse(Float64, readline(stdin))

# calculate bmi
if system == "I"
	bmi = (weight / height^2) * 703
elseif system == "M"
	bmi = weight / (height / 100) ^ 2
end
bmi = round(bmi, digits=4) # round result to 2 digits after decimal

# prints calculated BMI
println("\nBMI = $bmi")	# print calculated BMI
#@printf("\nBMI = %.4f\n", bmi)	# print calculated BMI with 2 digits after decimal; need to do "using Printf" at top

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

# print status
println("Status = $status")

