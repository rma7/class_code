################################################################################
#
# Program:      methods2019_asg9.jl
# Purpose:      Process words in PubMed titles
# Description:  For each PubMed title, gets and prints the number of words
#               and unique words; checks if the words begins with a letter,
#               begins with a number, or ends with a '.'; and converts number
#               words that are less than ten to digits and prints the
#               updated title
# Created by: BCBI (bcbi@brown.edu)
# Created on: 2017-06-11
# Last modified by: BCBI (bcbi@brown.edu)
# Last modified on: 2019-02-27
#
################################################################################

# create number dictionary
num_dict = Dict("zero" => "0", "one" => "1", "two" => "2", "three" => "3", "four" => "4", "five" => "5", "six" => "6", "seven" => "7", "eight" => "8", "nine" => "9")
#=
num_dict = Dict()
num_dict["zero"] = "0"
num_dict["one"] = "1"
num_dict["two"] = "2"
num_dict["three"] = "3"
num_dict["four"] = "4"
num_dict["five"] = "5"
num_dict["six"] = "6"
num_dict["seven"] = "7"
num_dict["eight"] = "8"
num_dict["nine"] = "9"
=#

while (true)

  # asks user for PubMed title
  println()
  print("Enter a PubMed Title: ")
  title = chomp(readline(stdin))
  
  if title == "qqq"
  	break
  end

  # determine and print the number of words
  title_array = split(title, " ")
  title_array_length = length(title_array)
  println()
  println("Number of Words = $title_array_length")
  println("Number of Unique Words = $(length(unique(title_array)))")
  println()

  # checks each word to determine if it starts with a letter, starts with a number, and ends with a '.'
  # also check if a word is a number word (one, two, three, etc.) and convert to digit (1, 2, 3, etc.)
  new_title = ""                # option 1: keep track of new title as string
  new_title_array = []          # option 2: keep track of new title as array
  new_title_regex = title       # option 3: keep track of new title using regex

  for word in title_array

      # start with letter
      if occursin(r"^[a-zA-Z]", word)
          println("$word = Starts with Letter")
      end

      # starts with number
      if occursin(r"^[0-9]", word)
          println("$word = Starts with Number")
      end

      # ends with '.'
      if occursin(r"\.$", word)
          println("$word = Ends with '.'")
      end

      # check if number word and convert
      if haskey(num_dict, lowercase(word))
      	 println("$word = Convert to $(num_dict[lowercase(word)])")

        new_title = new_title * num_dict[lowercase(word)] * " "   # option 1
        push!(new_title_array, num_dict[lowercase(word)])         # option 2
        #new_title_regex = replace(new_title_regex, Regex(word), num_dict[lowercase(word)]) # option 3
        new_title_regex = replace(new_title_regex, word => num_dict[lowercase(word)]) # option 3
      else
        new_title = new_title * word * " "
        push!(new_title_array, word)
      end
  end

  # print new title from string or array
  println()
  println("Original title: $title")
  println("New title (from string) = $(chop(new_title))")
  println("New title (from array) = $(join(new_title_array, " "))")
  println("New title (from regex) = $new_title_regex")

end

#
# 27502265  Four Diseases, Two Associations, One Patient: A Case of Frontal Fibrosing Alopecia, Lichen Planus Pigmentosus, Acne Rosacea, and Morbihan Disease.
# 27225129  Genome-wide association study identifies 74 loci associated with educational attainment.
# 27301809  Six ways for governments to get value from health IT.
# 26381908  Prosthetic joint infection following hip fracture and degenerative hip disorder: a cohort study of three thousand, eight hundred and seven consecutive hip arthroplasties with a minimum follow-up of five years.
# 23920926  3D visualization environment for analysis of telehealth indicators in public health.
