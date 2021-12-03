using CSV, DataFrames 

input = open("../inputFiles/Year2021/puzzle2.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

FilterInput = DataFrame(Command = String[], Value = Int[])

for i in 1:length(input)
    fillcol1 = string.(split(input[i], " "))[1]
    fillcol2 = parse(Int, string.(split(input[i], " "))[2])
    push!(FilterInput, (fillcol1, fillcol2))
end

function algo_parta(FilterInput)
    hpos = 0
    depth = 0 
    
    for i in 1:nrow(FilterInput)
        if FilterInput[:, :Command][i] == "forward"
            hpos = hpos + FilterInput[:, :Value][i]
        elseif  FilterInput[:, :Command][i] == "down"
            depth = depth + FilterInput[:, :Value][i]
        elseif  FilterInput[:, :Command][i] == "up"
            depth = depth - FilterInput[:, :Value][i]
        end
    end
    return hpos, depth
end

function algo_partb(FilterInput)
hpos = 0
depth = 0 
aim = 0

for i in 1:nrow(FilterInput)
    if FilterInput[:, :Command][i] == "forward"
        hpos = hpos + FilterInput[:, :Value][i]
        depth = depth + FilterInput[:, :Value][i]*aim 
    elseif  FilterInput[:, :Command][i] == "down"
        aim = aim + FilterInput[:, :Value][i]
    elseif  FilterInput[:, :Command][i] == "up"
        aim = aim - FilterInput[:, :Value][i]
    end
end
return hpos, depth, aim
end


h, d = algo_parta(FilterInput)
println(h*d)
h, d, a = algo_partb(FilterInput)
println(h*d)