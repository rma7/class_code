################################################################################
#
# Program:		methods2019_asg3.jl
# Purpose: 		Process ClinicalTrials.gov titles
# Description:	For each ClinicalTrials.gov title, gets and prints length,
#						prints first five characters if length is less than 75 or
#						prints last five characters otherwise, and checks if title
#						includes any numbers.
# Created by: 			BCBI (bcbi@brown.edu)
# Created on: 			2017-02-21
# Last modified by:		BCBI (bcbi@brown.edu)
# Last modified on:		2019-02-19
#
################################################################################

# asks user for ClinicalTrials.gov title
print("Enter a ClinicalTrials.gov Title: ")
title = readline(stdin)

# keeps asking for a ClinicalTrials.gov title until "qqq" is entered

# options: use != or !ismatch
while title != "qqq"
#while !occursin(r"^qqq$", title)
#while occursin(r"[^q]{3}", title)
	# gets length of title
	title_length = length(title)
	println("Length = $title_length")

	# determine if title length is less than 75
	# prints first five characters
	if title_length < 75
		#option 1: use for loop
		#print("First Five Characters = ")
		# for i in 1:5
		# 	print(title[i])
		# end
		# print("\n")

		# option 2: use substring
		#println("First Five Characters = $(title[1:5])")

		if title_length < 5
			println("First Five Characters = $(title)")
		else
			println("First Five Characters = $(title[1:5])")
		end

	# otherwise, prints last five characters
	else
		# option 1: use for loop
		# print("Last Five Characters = ")
		# for j in title_length-4:title_length
		# 	print(title[j])
		# end
		# print("\n")

		# option 2: use substring
		#println("Last Five Characters = $(title[title_length-4:title_length])")
		println("Last Five Characters = $(title[end-4:end])")
	end

	# checks if title includes any numbers
	print("Includes Numbers? = ")
	if occursin(r"[0-9]", title)
		println("Yes")
	else
		println("No")
	end

	# asks user for another ClinicalTrials.gov title
	println()
	print("Enter another ClinicalTrials.gov Title: ")
	global title = readline(stdin)
end

##################### USE THE FOLLOWING TITLES FOR TESTING #####################
# Go to https://clinicaltrials.gov/
# Search for each ClinicalTrials.gov Identifier (NCTID)
#
# NCT02283749
# BrUOG L301 With Non-Small Cell Lung Cancer and Bone Metastases
#
# NCT02332239
# Text-Message-Based Depression Prevention for High-Risk Youth in the ED
#
# NCT02607566
# Yoga for Type 2 Diabetes
#
# NCT02738749
# Sodium Channel Splicing in Heart Failure Trial (SOCS-HEFT) Prospective Study
#
# NCT03007849
# A Pilot Study of Fecal Microbiome and Neutrophil Cellular Adhesion Molecules in Patients With Sickle Cell Disease (SCD)
################################################################################
