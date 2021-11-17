using CSV, DataFrames

input = CSV.read("E:\\rbionics\\EXO\\Data\\RX_testfolder\\puzzle2.csv", DataFrame)

FilterInput = DataFrame(MinNumber = Int[], MaxNumber = Int[] , Character = String[], Password = String[])

for i in 1:nrow(input)
    
    fillcol1 = parse(Int, String(split(split(input[i,:Data])[1], "-")[1]))
    fillcol2 = parse(Int, String(split(split(input[i,:Data])[1], "-")[2]))
    fillcol3 = String(split(split(input[i,:Data])[2], ":")[1])
    fillcol4 = split(input[i,:Data])[3]
    push!(FilterInput, (fillcol1, fillcol2, fillcol3, fillcol4))
end

i = 0 

function countme(counter, FilterInput)
    for i in 1:nrow(FilterInput)
    cond = count(FilterInput[i, :Character], FilterInput[i, :Password])
    if cond >= FilterInput[i, :MinNumber] && cond <= FilterInput[i, :MaxNumber]
        counter = counter + 1
    end
end
    return counter
end

times = countme(i, FilterInput)



rename!(FilterInput, :MinNumber => :Pos1)
rename!(FilterInput, :MaxNumber => :Pos2)

j = 0

function positionbasedcounter(counter, FilterInput)
    for i in 1:nrow(FilterInput)
    switch = false 
        if  string(FilterInput[i, :Password][FilterInput[i, :Pos1]]) == FilterInput[i, :Character]
            switch = !switch
        end

        if  string(FilterInput[i, :Password][FilterInput[i, :Pos2]]) == FilterInput[i, :Character]
            switch = !switch
        end

        if switch == true
            counter = counter + 1
        end
    end 

    return counter
end

posbasedtimes = positionbasedcounter(j, FilterInput)