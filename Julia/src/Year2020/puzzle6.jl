using DataFrames 
using DataStructures

lines = open("../inputFiles/Year2020/puzzle6.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

lines_partb = deepcopy(lines)


function doparsingWithoutSpace(val,l, repeatedlines)
    
while(val+1 <= length(l))

   
    if l[val+1] !== ""
    repeatedlines = true
    l[val] = l[val]*""*l[val+1]
    end

    if l[val+1] == ""
    val = val + 2
    repeatedlines = false
    end
    
    if repeatedlines == true
        deleteat!(l, val+1)
    end

end

return l
end
    
function doparsingWithSpace(val,l, repeatedlines)
    
while(val+1 <= length(l))
    
       
        if l[val+1] !== ""
        repeatedlines = true
        l[val] = l[val]*" "*l[val+1]
        end
    
        if l[val+1] == ""
        val = val + 2
        repeatedlines = false
        end
        
        if repeatedlines == true
            deleteat!(l, val+1)
        end
    
end
    
    return l
end

newInput = doparsingWithoutSpace(1,lines, true)
Totalcount = sum(length.(counter.(newInput)))
println("Answer to q1 is $Totalcount")

newInputb = doparsingWithSpace(1,lines_partb, true)



function CommonCharacterCounter(TotalCounter,groupCounter, newInputb)


for i in 1:2:length(newInputb)

NumPeople = length(split(newInputb[i]))
regex = r"(.+) (.+)"
stringsplit = eachmatch(regex, newInputb[i]) |> collect

if stringsplit == RegexMatch[]
    TotalCounter = TotalCounter + length(newInputb[i])
    continue
end

searchstring = unique(x[2] for x in stringsplit)
tosearchInstring = unique(x[1] for x in stringsplit)
    for j in 1: length(String.(searchstring)[1])
        ss = (String.(searchstring)[1])[j]
        if length( collect(  eachmatch(Regex(string(ss)),String.(tosearchInstring)[1])  ) ) == NumPeople-1
            groupCounter = groupCounter + 1
        else
        continue
        end
    end

TotalCounter = TotalCounter + groupCounter
groupCounter = 0
end
return TotalCounter
end

CommonCharacterCounter(0,0,newInputb)