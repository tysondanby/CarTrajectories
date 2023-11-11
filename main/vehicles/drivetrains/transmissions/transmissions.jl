abstract type Transmission end

#All inertias, accelerations, and speeds are relative the input unless otherwise specified.

struct nspeed{T} <: Transmission
    clutchholdingtorque::T
    clutchslidingtorque::T #at maximum engagement
    ratios::Vector{T}#motor turns per driveshaft turns.
    Is::Vector{T}# inertias relative to the input
end

struct rpmcontrolledcvt{T} <: Transmission
    ratios::Vector{T}
    speeds::Vector{T}
    Is::Vector{T}# inertias
end

mutable struct transmissionstatevars{T} <: StateVars
    speed::T #Speed of clutch plate
end

function unpackstatevars(packedstatevars::transmissionstatevars,T::Transmission)
    return [packedstatevars.speed]
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end

function speedout(T::nspeed,gear::T1,speedin::T2) where T1 where T2
    return speedin*T.ratios[gear]
end

function speedout(T::rpmcontrolledcvt,speedin::T1) where T1
    return interpolate(T.speeds,T.ratios,speedin)*speedin
end


function acceleration(T::nspeed,gear::T1,Qin::T2,Qout::T2) where T1 where T2
    return 
end