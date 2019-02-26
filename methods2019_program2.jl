

# ask user to enter a phrase
println("hello, enter a phrase")
phrase = readline(stdin)

# tell user what they entered
print("you said \"$phrase\"")

# determine length of phrase
phrase_length = length(phrase)
println("... your phrase is $phrase_length characters long")

# use a while loop to ensure that the the string is 
# at least 10 characters long
while phrase_length < 10
	println("TOO SHORT!")
	print("enter another phrase")
	second_phrase = readline(stdin)
	global phrase_length = length(second_phrase)

end

# report out the first 3 characters
three_char = phrase[1:3]
println("the first three characters are \"$three_char\"")

# tell user if a pattern is in the phrase
# lowercase letter, digit, uppercase letter
if occursin(r"[a-z][0-9][A-Z]", phrase)
	println("found a secret code... but i won't tell you what it is.")
end







