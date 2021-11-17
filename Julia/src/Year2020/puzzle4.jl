using DataFrames


lines = open("inputFiles/Year2020/puzzle4.txt", read=true, write =true) do io
    ids_array = readlines(io)
end



function doparsing(val,l, repeatedlines)
    
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
    


newInput = doparsing(1,lines, true)


#switch_path = "../../GlobalStateMachine/src/state_switch_conditions.h" |> realpath
#io = open(switch_path, "r")

#initial_states_switch = unique([x[2] for x in funs])

validpassports_eyr = contains.(newInput, "eyr") 
validpassports_ecl = contains.(newInput, "ecl") 
validpassports_hcl = contains.(newInput, "hcl") 
validpassports_pid = contains.(newInput, "pid") 
validpassports_cid = contains.(newInput, "cid") 
validpassports_byr = contains.(newInput, "byr") 
validpassports_hgt = contains.(newInput, "hgt")
validpassports_iyr = contains.(newInput, "iyr") 


vp = (validpassports_eyr .& validpassports_ecl .& validpassports_hcl .& validpassports_byr .&validpassports_hgt .& validpassports_iyr) .& (validpassports_pid)



Present = newInput[vp]
# function_regex = r"eyr:(.+)"

# s = split(newInput[1], " " )

# funs = eachmatch.(function_regex, s) |> collect

# for i in 1:length(funs)
# un = unique([x[1] for x in funs[i]])
# break
# end
function checkvalid(validP)
for i in 1:length(Present)
    validflag = false
    tempString = split(Present[i], " ")
    for j in 1:length(tempString)
        if tempString[j][1:3] == "eyr" &&  parse(Int,string(tempString[j][5:end]))  >= 2020 &&  parse(Int,string(tempString[j][5:end]))  <= 2030
           validflag = true  
        
        elseif tempString[j][1:3] == "byr" &&  parse(Int,string(tempString[j][5:end]))  >= 1920 &&  parse(Int,string(tempString[j][5:end]))  <= 2002
            validflag = true  
        
        elseif tempString[j][1:3] == "iyr" &&  parse(Int,string(tempString[j][5:end]))  >= 2010 &&  parse(Int,string(tempString[j][5:end]))  <= 2020
            validflag = true  
        
        elseif tempString[j][1:3] == "hcl" && string(tempString[j][5]) == "#" && length(tempString[j][6:end]) == 6
            for  k in 1:length(tempString[j][6:end])
                if isxdigit(tempString[j][k+5])
                    validflag = true
                else
                    validflag = false
                    break
                end
            end
        
        elseif tempString[j][1:3] == "ecl" && length(tempString[j][5:end]) == 3 && (tempString[j][5:end] == "amb" || tempString[j][5:end] == "blu" || tempString[j][5:end] == "brn" || tempString[j][5:end] == "gry" || tempString[j][5:end] == "grn" || tempString[j][5:end] == "hzl" || tempString[j][5:end] == "oth") 
            validflag = true  
        
        elseif tempString[j][1:3] == "pid" && length(tempString[j][5:end]) == 9 
            for k in 1:length(tempString[j][5:end])
                if occursin(tempString[j][k+4], "0123456789")
                    validflag = true
                else
                    validflag = false
                    break
                end
            end
        elseif tempString[j][1:3] == "cid"
            validflag = true
        elseif tempString[j][1:3] == "hgt" 
            if tempString[j][end-1:end] == "cm" &&
                parse(Int,string(tempString[j][5:end-2])) >=150 && parse(Int,string(tempString[j][5:end-2])) <= 193
                validflag = true   
            
            elseif tempString[j][end-1:end] == "in" && 
                parse(Int,string(tempString[j][5:end-2])) >=59 && parse(Int,string(tempString[j][5:end-2])) <= 76 
                validflag = true 
            else
                validflag = false 
                break
            end
        else
            validflag = false
    
            break

        end

  
    end 
    if validflag == true
        println(i)
        validP = validP + 1
    end
end

return validP
end


naaaa = checkvalid(0)