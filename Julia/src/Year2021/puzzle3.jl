using CSV, DataFrames, DelimitedFiles

input = open("../inputFiles/Year2021/puzzle3.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

df = DataFrame([String[] for i in 1:length(split(input[1], ""))])

for i in 1:length(input)
    push!(df, split(input[i],""))
end

function parta(df)
GR = []
for j in 1:ncol(df)
    addnumber = sum(parse.(Int,df[:,j])) > nrow(df)/2 ? 1 : 0
    append!(GR, addnumber)
end
 num1 = parse(Int, join(GR), base=2)
 num2 = 2^ncol(df) - 1 - num1
return num1*num2
end

part1 = parta(df)

function partb(data)
    dataforones = deepcopy(data)
    dataforzeros = deepcopy(data)
    for j in 1:ncol(df)
        
        common1 = sum(parse.(Int,dataforones[:,j])) >= nrow(dataforones)/2 ? 1 : 0
        common2 = sum(parse.(Int,dataforzeros[:,j])) >= nrow(dataforzeros)/2 ? 0 : 1
        mask1 = dataforones[:, names(data)[j]] .== string(common1)
        mask2 = dataforzeros[:, names(data)[j]] .== string(common2)
        if nrow(dataforzeros) > 1 
            dataforzeros = dataforzeros[mask2, :]
        end
        if nrow(dataforones) > 1 
            dataforones = dataforones[mask1, :]
        end
    end
    a = parse(Int,join(vec(convert(Array,dataforones))), base =2)*parse(Int,join(vec(convert(Array,dataforzeros))), base =2)
    return a
end



a = partb(df)