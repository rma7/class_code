################################################################################
#
# Program:		methods_asg13.jl
# Purpose: 		Process PubMed search results in MEDLINE format (from NCBI E-Utilities)
# Description:	Get and print PMID, Date Created, and Date Completed.
#				Summarizes number of articles per year based on Date Created.
#				Does not include error checking, validation, etc. - 
#				assumes all records have PMID, Date Created, and Data Completed
#
#				option 1: use variables
#				option 2: use arrays
#				option 3: use two dictionaries
#				option 4: use dictionary of dictionaries
#
# Last modified by:		BCBI (bcbi@brown.edu)
# Last modified on:		2019-03-18
#
################################################################################

# call HTTP package
using HTTP

# open output files
output_file_name1 = "methods2019_asg13_output1.txt"
output_file1 = open(output_file_name1, "w")
output_file_name2 = "methods2019_asg13_output2.txt"
output_file2 = open(output_file_name2, "w")

# dictionary for keeping track of years
year_dict = Dict()

# define base URL for ESearch
base_search_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"

# define query term
query_term = "\"brown university\"[ad] and \"electronic health records\"[mh]"
#query_term = "\"brown university\"[ad] and \"computational biology\"[mh] and \"smoking\"[mh]"
println("Search = $query_term")

# define query dictionary to send to the URL
query_dict = Dict()
query_dict["db"] = "pubmed"
query_dict["term"] = query_term
query_dict["retmax"] = 100

# send query to ESearch
search_result = String(HTTP.post(base_search_query, body=HTTP.escapeuri(query_dict)))
println("Searching and getting PMIDs ...")
#print(search_result)

# retrieve the PMIDs into a Set
pmid_set = Set()
for result_line in split(search_result, "\n")
  # get list of pmids
  pmid = match(r"<Id>(\d+)<\/Id>", result_line)
  if pmid != nothing
    push!(pmid_set,pmid[1])
  end
end

println("Articles = $(length(pmid_set))")

# concatenate PMIDs into a single comma separated string
id_string = join(collect(pmid_set), ",")

# update query dictionary for EFetch query
base_fetch_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"
query_dict["db"] = "pubmed"
query_dict["id"] = id_string
query_dict["rettype"] = "medline"
query_dict["retmode"] = "text"

# send query dictionary to EFetch
fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))
println("Searching and getting MEDLINE records for PMIDs ...")

#print(fetch_result)

# initialize collections
medline_array = []						# option 2
medline_date_completed_dict = Dict()	# option 3
medline_date_created_dict = Dict()		# option 3
medline_date_dict = Dict{ String, Dict{String,String}}()	# option 4

# pull out PMID and dates from EFetch results
for fetch_line in split(fetch_result, "\n")

  	# get pmid
  	# Example: PMID- 30591012
  	pmid = match(r"PMID- ([0-9]+)", fetch_line)
  	if pmid != nothing
		global pmid_full = pmid[1]			# option 1
		push!(medline_array, pmid[1])		# option 2
		medline_date_dict[pmid_full] = Dict("pmid" => pmid[1]) # option 4
  	end

  	# get date completed - full
  	# Example: DCOM- 20190204
  	date_completed = match(r"DCOM- ([0-9]{8})", fetch_line)
  	if date_completed != nothing
		global date_completed_full = date_completed[1]	# option 1
		push!(medline_array, date_completed[1])			# option 2
		medline_date_completed_dict[pmid_full] = date_completed[1]	# option 3
		medline_date_dict[pmid_full]["date_completed"] = date_completed[1] # option 4
  	end

	# get date created - year, month, day
	# Example: CRDT- 2018/12/29 06:00
  	date_created = match(r"CRDT- (([0-9]{4})\/([0-9]{2})\/([0-9]{2}))", fetch_line)
  	if date_created != nothing
		date_created_full = date_created[1]
		date_created_year = date_created[2]
		date_created_month = date_created[3]
		date_created_day = date_created[4]

		# keep track of years
		if haskey(year_dict, date_created_year)
			year_dict[date_created_year] += 1
		else
			year_dict[date_created_year] = 1
		end

		# option 1: print PMID, Date Created, and Date Completed
		println("VAR: $pmid_full|$date_created_full|$date_completed_full")
		#write(output_file1, "$pmid_full|$date_created_full|$date_completed_full\n")

		push!(medline_array, date_created[1])		# option 2
		medline_date_created_dict[pmid_full] = date_created[1]	# option 3	
		medline_date_dict[pmid_full]["date_created"] = date_created[1] # option 4
	end
end

# option 2: print from array
for i in 1:3:length(medline_array)
	println("ARRAY: $(medline_array[i])|$(medline_array[i+2])|$(medline_array[i+1])")
end	

# option 3: print from dictionaries
for pmid in keys(medline_date_created_dict)
	println("DICT: $(pmid)|$(medline_date_created_dict[pmid])|$(medline_date_completed_dict[pmid])")
end	

# option 4: print from dictionary of dictionaries
for pmid in keys(medline_date_dict)
	println("DICT2: $(pmid)|$(medline_date_dict[pmid]["date_created"])|$(medline_date_dict[pmid]["date_completed"])")
end	

# distribution of years for date created

# sorted by year
println("sort by year")
for year in sort(collect(keys(year_dict)))
	println("  $year\t$(year_dict[year])")
end

# sorted by frequency
println("sort by count")
for (count, year) in sort(collect(zip(values(year_dict),keys(year_dict))), rev=true)
	println("  $year\t$count")
	write(output_file2, "  $year\t$count\n")
end

println("All done! See $output_file_name1 and $output_file_name2")

# close files
close(output_file2)
close(output_file1)

