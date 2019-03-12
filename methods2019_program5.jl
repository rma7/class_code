# program5-- interacting with eUtils

# call HTTP package
using HTTP

## https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?db=pubmed&term="brown university"[ad]

# define base URL
base_search_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"

# define query term
query_term = "\"brown university\"[ad] and \"computational biology\"[mh] and \"smoking\"[mh]"


println("hello. I will search for $query_term")

# define a dictionary to send to the URL
query_dict  = Dict()
query_dict["db"] = "pubmed"
query_dict["term"] = query_term


search_result = String(HTTP.post(base_search_query,body=HTTP.escapeuri(query_dict)))

print(search_result)

pmid_set = Set()

# parse through result set
for result_line in split(search_result, "\n")

	pmid_capture = match(r"<Id>(\d+)<\/Id>", result_line)

	if pmid_capture != nothing
		push!(pmid_set, pmid_capture[1])
	end

end


id_string = join(collect(pmid_set), ",")

base_fetch_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

query_dict["db"] = "pubmed"
query_dict["id"] = id_string
query_dict["rettype"] = "medline"
query_dict["retmode"] = "text"

fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))

print(fetch_result)

# pull out MeSH descriptors from efetch results
mesh_dict = Dict()
for fetch_line in split(fetch_result, "\n")
    
    # define the mesh capture RegEx
    mesh_capture = match(r"MH  - \*?([^/]+)", fetch_line)

    # if the line has the pattern, extract the MeSH descriptor
    # and store into MeSH dictionary & tracking frequency
    if mesh_capture != nothing

        # store MeSH descriptors, keeping track of occurence 
        if haskey(mesh_dict, mesh_capture[1])
            mesh_dict[mesh_capture[1]] += 1
        else
            mesh_dict[mesh_capture[1]] = 1
        end

    end

end

for mesh_descriptor in keys(mesh_dict)
	if mesh_dict[mesh_descriptor] > 1
		println("$mesh_descriptor occurs $(mesh_dict[mesh_descriptor])")
	end
end































