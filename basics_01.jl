println("I am super excited to learn Julia");

a = 42 
my_pi = 3.1415 
name = "arvind"
println(typeof(name)) ;
name = 42 

typeof(name) ;

# this is easy
#= this is easy, 
athough needs some practice =#

book = Dict("Roger" => "1234", "Rafa" => "1234,", "Novak" => "1234") ;
book["Stan"] = "1234" ;

myfavoriteanimals = ("penguins", "cats", "sugargliders")
myfavoriteanimals[1] ;

#tuples are immutable

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshall"] ;
myfriends[1] ;
mixture = [1, 1, 2, 3, "Ted", "Robyn"] ;
typeof(mixture) 
push!(mixture, 21)
pop!(mixture)

numbers = [[1, 2, 3], [4, 5], [6, 7, 8, 9]] ;