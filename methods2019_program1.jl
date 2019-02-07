# 
# isarkar_program1.jl 
# First awesome program in Julia
# 
# 2019-02-07
#

# introduce program to user
println("hello, world!")

# ask if the user is having a nice day
print("Are you having a nice day? ")

# get response
user_response = readline(stdin)

# tell user their response
println("great! happy to hear that you are \"$user_response\"")

# ask the user for their favorite number
print("what is your favorite number? ")
fav_number = parse(Int64, readline(stdin))

# tell user thier number is inadequate
println("hmm... you can do better than $fav_number")

double_fav_number = fav_number * 2


# report twice the favorite number
println("a better number is: $double_fav_number")


# indicate if twice the value is larger than 5
if double_fav_number > 5
	println("double your number is bigger than 5..")
end

# introduce bmi calculator
println("we will now calculate body mass index (BMI) in lbs and inches")


# get weight
print("enter weight ") 
weight = parse(Float64, readline(stdin))

# get height
print("enter height ")
height = parse(Float64, readline(stdin))

# calculate bmi
bmi = (weight / height^2) * 703

# print bmi to screen
println("BMI is $bmi")

# use bmi value to determine user status
if bmi < 18.5
	status = "underweight"
end

if bmi > 18.5 && bmi < 25.0
	status = "normal"
end

if bmi >= 25.0 && bmi < 30.0
	status = "overweight"
end

if bmi >= 30.0
	status = "obese"
end

# report user status
println("... which indicates that this individual is $status")























