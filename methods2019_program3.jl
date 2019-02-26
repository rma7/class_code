# methods2019_program3.jl
# Collections - arrays, sets, and dictionaries
# Date: 2019-02-26

# ask for phrase
print("Enter a phrase: ")
phrase = readline(stdin)

# tell user length and characters
println("length of phrase is (# characters) is: $(length(phrase))")
println("first three characters: $(phrase[1:3])")
println("last three characters: $(phrase[end-2:end])")
println("fifth character: $(phrase[5])")

# create array of words
word_array = []
word_array = split(phrase, " ")

# if the phrase is less than 5 words, have user re-enter phrase
while length(word_array) < 5
	print("length of phrase (# words): $(length(word_array))\n")
	print("too short! enter a phrase of at least 5 words: ")
	phrase = readline(stdin)
	global word_array = split(phrase, " ")
	println()
end

# println(phrase)	# demo local/global scope

# report words from array
for word_num in 1:length(word_array)
	println("<array> word $word_num in phrase is $(word_array[word_num])")
end

# equivalent to above
for word in word_array
	println("<array again> word in phrase is $word")
end

println("first two words are: $(word_array[1:2])")
println("third word is: $(word_array[3])")

last_words = join(word_array[end-1:end], " ")
println("last two words are: $last_words")

# load the array into a set
word_set = Set()
for word in word_array
	push!(word_set, word)
end

# print set
for word in word_set
	println("<set> word in phrase is: $word")
end
println()

# create dictionary of translations
translated_word_dict = Dict()
translated_word_dict["to"] = "2"
translated_word_dict["be"] = "B"

for key in keys(translated_word_dict)
	println("<dict> \"$key\" translated to \"$(translated_word_dict[key])\"")
end

# translate original phrase
# example: "to be or not to be" translates to "2 B OR NOT 2 B"
translated_phrase_array = []
for word in word_array
	if haskey(translated_word_dict, word)
		translated_word = translated_word_dict[word]
		push!(translated_phrase_array, translated_word)
	else
		push!(translated_phrase_array, uppercase(word))
	end
end
println("input phrase is: $phrase")
println("translated phrase is: $(join(translated_phrase_array, " "))")
