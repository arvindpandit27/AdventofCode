using Plots

#Vq = 1.0
#Vd = 0.0
#encReadings =  range(0, 65535, length=10000000)


#Ia = 2*sin(fs*encReadings)
#Ib = 2*sin(fs*encReadings + phia)
#Ic = 2*sin(fs*encReadings + phib)


function ClarkVariant(Ia,Ib,Ic)
    Iα = (2/3)*Ia - (1/3)*Ib - (1/3)*Ic 
    Iβ = 1/sqrt(3)*Ib - 1/sqrt(3)*Ic   
    Iγ = (1/3)*Ia + (1/3)*Ib + (1/3)*Ic  
return Iα, Iβ, Iγ
end

function Park(Iα, Iβ, Iγ, theta)
    Id = Iα.*cos.(theta) +  Iβ.*sin.(theta)
    Iq = -Iα.*sin.(theta) +  Iβ.*cos.(theta)
    I0 = Iγ.*ones(length(theta))

return Id, Iq, I0
end

function InvPark(Vd, Vq, V0, theta)
    Vα = Vd*cos.(theta) - Vq*sin.(theta)
    Vβ = Vd*sin.(theta) + Vq*cos.(theta)
    Vγ = V0*ones(length(theta)) 
return Vα, Vβ, Vγ
end

function InvClarkVariant(Vα, Vβ, Vγ)
    Va = Vα + Vγ
    Vb = -1/2*Vα + sqrt(3)/2*Vβ + Vγ
    Vc = -1/2*Vα - sqrt(3)/2*Vβ + Vγ
    return Va, Vb, Vc
end



function runall()
    theta = collect(range(0, 2*pi, length = 10000))
    Vd = 1
    Vq = 0
    V0 = 0
    Vα, Vβ, Vγ =  InvPark(Vd,Vq,V0, theta)
    #plot([Vα, Vβ, Vγ], layout = (3,1))
    #println("α, β, γ voltages are: $(Vα), $(Vβ), $(Vγ) ")
    Va, Vb, Vc = InvClarkVariant(Vα, Vβ, Vγ)
    #println("Phase voltages are: $(Va), $(Vb), $(Vc) ")
    # Simplified motor model
    rs = 1
    Ia = Va/rs
    Ib = Vb/rs 
    Ic = Vc/rs
    #println("Phase currents are: $(Ia), $(Ib), $(Ic) ")
    Iα, Iβ, Iγ = ClarkVariant(Ia,Ib,Ic)
    #println("α, β, γ currents are: $(Iα), $(Iβ), $(Iγ) ")
    Id, Iq, I0 = Park(Iα, Iβ, Iγ, theta)
    #println("d-q-0 currents are: $(Id), $(Iq), $(I0) ")
    return Vα, Vβ,  Va, Vb, Vc, Ia, Ib, Ic, Iα, Iβ, Iγ, Id, Iq, I0
end


theta = collect(range(0, 2*pi, length = 10000))
Vα, Vβ,  Va, Vb, Vc, Ia, Ib, Ic, Iα, Iβ, Iγ, Id, Iq, I0 = runall()

h1 = plot(theta, Vα, label = "Vα")
plot!(h1,(theta, Vβ), label = "Vβ")
 

h2 = plot(theta, Va, label = "Va")
plot!(h2, (theta, Vb), label = "Vb")
plot!(h2, (theta, Vc), label = "Vc")

 
h3 = plot(theta, Ia, label = "Ia")
plot!(h3, (theta, Ib), label = "Ib")
plot!(h3, (theta, Ic), label = "Ic")

h4 = plot(theta, Iα, label = "Iα")
plot!(h4, (theta, Iβ), label = "Iβ")
plot!(h4, (theta, Iγ), label = "Iγ")

h5 = plot(theta, Id, label = "Id")
plot!(h5, (theta, Iq), label = "Iq")

plot(h1, h2, h3, h4, h5, layout = (5,1))


N = 8
KV1 = 1/N 
samplingFreq = 30000

den = (1/KV1) - 1
tau = samplingFreq/(den)
fs = 1/(2*pi*tau)


maxMotorSpeed = 500 ##radps
maxMotorSpeedInfreq = maxMotorSpeed/(2*pi)
polpairs = 14
electricalangleFreq = maxMotorSpeedInfreq*polpairs 
phaseCurrentHarmonics= [1,3,5]
freq = findmax(electricalangleChange*phaseCurrentHarmonics)[1]
sampling1  = 2*freq


fs = 
normalized = 0.444/(sqrt(15))
sampling = cutOff/normalized