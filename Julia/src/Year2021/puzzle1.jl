using CSV, DataFrames 

lines = open("../inputFiles/Year2021/puzzle1.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

input = parse.(Int, lines)
answer_a = sum(diff(input) .> 0)


function slidingWindow(input)
    modified = Array{Int64}(undef,length(input)-2)
for i in 1:length(input)-2 
    modified[i] = input[i] + input[i+1] + input[i+2]
end
return modified
end

SlidingArray = slidingWindow(input)

answer_b = sum(diff(SlidingArray) .>0)