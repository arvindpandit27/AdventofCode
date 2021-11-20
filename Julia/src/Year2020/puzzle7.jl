lines = open("../inputFiles/Year2020/puzzle7.txt", read=true, write =true) do io
    ids_array = readlines(io)
end

regexToFindParentBags = r"(.+) (....) contain (.+)"
regexToSeparateChildrenBags = r"(.) (.+) (b)"
function commaSplitter(s::String)
    return String.(split(s, ", "))
end

function makeParentBags(findbags, ParentBags, OverallChildrenDict)
for i in 1:length(lines)
    findbags = collect(eachmatch(regexToFindParentBags,lines[i])) 
    temp = String.(unique(x[1] for x in findbags)[1])
    push!(ParentBags, temp)
    childString = String.(unique(x[3] for x in findbags)[1])
    children = commaSplitter(childString)

    ChildrenDict = Dict()
    for j in 1:length(children)
        findchildrenbags = collect(eachmatch(regexToSeparateChildrenBags, children[j]))
        if String.(unique(x[2] for x in findchildrenbags)[1]) == "other"
            TypeOfBag = "no other bags"
            numberofBags = 0 
        else    
        numberofBags = parse(Int,unique(x[1] for x in findchildrenbags)[1])
        TypeOfBag = String.(unique(x[2] for x in findchildrenbags)[1])
        end
        push!(ChildrenDict, TypeOfBag => numberofBags)
    end
    OverallChildrenDict = [ OverallChildrenDict; ChildrenDict ];
end
return ParentBags, OverallChildrenDict
end

ParentBags, OverallChildrenDict = (makeParentBags(findbags, [], []))

function RecursiveCountShinyGold(OverallChildrenDict, count,ParentBags, bagToSearch)
    parentindices = haskey.(OverallChildrenDict,bagToSearch)
    ShinyGoldHolders = ParentBags[parentindices]

    i = 1
    while i <= length(ShinyGoldHolders) 
        for j in 1:length(ParentBags)
            if haskey(OverallChildrenDict[j],ShinyGoldHolders[i])
 #               push!(ShinyGoldHolders, ParentBags)
                ShinyGoldHolders = [ShinyGoldHolders; ParentBags[j]];
            end
        end

        i = i + 1;
    end
    return length(unique(ShinyGoldHolders))
end


NumberofUpperBags = RecursiveCountShinyGold(OverallChildrenDict,0,ParentBags, "shiny gold")
