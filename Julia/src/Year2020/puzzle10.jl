lines = open("../inputFiles/Year2020/puzzle10.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

numbers = parse.(Int, lines)

push!(numbers, 0)
push!(numbers, findmax(numbers)[1]+3)
sorted = sort(numbers)
sortedDiff = diff(sorted)

NumberofOnes = length(findall(x->x==1, sortedDiff))
NumberofThrees = length(findall(x->x==3, sortedDiff))
println(NumberofOnes)
println(NumberofThrees)
println(NumberofOnes*NumberofThrees)

function CountSequenceofOnes(Arrangements)
counter = 0
for n in 1:length(sortedDiff)
    if sortedDiff[n] == 1
        counter = counter + 1

    else
        counter = counter + 1
        Arrangements = [Arrangements;counter]
        counter = 0

    end
   
end
return Arrangements
end

Arrangements = CountSequenceofOnes([])
for i in 1:length(Arrangements)
    if Arrangements[i] == 2 
        Arrangements[i] = 1
    elseif Arrangements[i] == 3
        Arrangements[i] = 2
    elseif Arrangements[i] == 4
        Arrangements[i] = 4
    elseif Arrangements[i] == 5
        Arrangements[i] = 7
    end
end

prod(Arrangements)