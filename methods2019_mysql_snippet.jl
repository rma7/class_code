# methods2019_mysql_snippet.jl
# MySQL snippet
#
# MySQL package
# https://github.com/JuliaDatabases/MySQL.jl
#
# DataFrames package
# https://github.com/JuliaData/DataFrames.jl
# https://juliadata.github.io/DataFrames.jl/stable/
# https://en.wikibooks.org/wiki/Introducing_Julia/DataFrames

using MySQL
using DataFrames

# function for getting password (not shown)
function get_pass(msg::String = "")
    if isempty(msg)
        msg = "Enter password: "
    end 
    cstring = ccall(:getpass, Cstring, (Cstring,), msg)
    ptr = pointer(cstring)
    pswd = unsafe_string(ptr)
    return pswd
end

# get basic connection variables -- host, username, and database name
db_host = "pursamydbcit.services.brown.edu"
db_name = "emrbots"

# ask user for username
print("Enter username: ")
db_user = readline()

# ask user to type in password
db_password = get_pass()

# create connection (emrbots_db)
emrbots_db = MySQL.connect(db_host, db_user, db_password; db = "$db_name", opts=Dict(MySQL.API.MYSQL_ENABLE_CLEARTEXT_PLUGIN=>"true"))

###
### Retrieve rows from emrbots for 10 patients who are married
status = "Married"
query = "SELECT PatientId, Gender, DateOfBirth, TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE()) as age FROM patient limit 10;"

# get results as a DataFrame (tabular data structure)
query_results_df = MySQL.Query(emrbots_db, query) |>  DataFrame

# print out the size, number of rows and columns of the result set
println("size = $(size(query_results_df))")
println("rows = $(size(query_results_df, 1))")
println("columns = $(size(query_results_df, 2))")

# give basic description of columns in result set
describe(query_results_df)
#println(description)

# print out the result set
for row in eachrow(query_results_df)
    println("$(row[1]) --- $(row[2]) --- $(row[3]) --- $(row[4])")
end

# filter results for those where age is greater than 50 yo
query_results_filtered_df = query_results_df[query_results_df[:age].> 50, :]

# print out filtered results
println("... ONLY THOSE greater than 50:")
for row in eachrow(query_results_filtered_df)
    println("$(row[1]) --- $(row[2]) --- $(row[3]) --- $(row[4])")
end

# close the MySQL connection
MySQL.disconnect(emrbots_db)
