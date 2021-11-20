using DataFrames 

lines = open("../inputFiles/Year2020/puzzle9.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

numbers = parse.(Int, lines)



function puzzle1_parta_2020(list, NumberOfInterest)

    for i in 1:length(list)
        for j in 1:length(list)
            if list[i] + list[j] == NumberOfInterest && i !=j
            return false
            end
        end
    end
    return true
end


function movelist(numbers)
    faultyflag = false
    NumberLength = 25 
    IndexOfInterest = NumberLength + 1
    list = numbers[IndexOfInterest - NumberLength : IndexOfInterest-1]
    while faultyflag == false && IndexOfInterest <=length(numbers)
        faultyflag = puzzle1_parta_2020(list, numbers[IndexOfInterest])
        if faultyflag == true
            return numbers[IndexOfInterest]
        else
        popfirst!(list)
        push!(list, numbers[IndexOfInterest])
        IndexOfInterest = IndexOfInterest+1
        end
    end
    
return -1
end


a = movelist(numbers)