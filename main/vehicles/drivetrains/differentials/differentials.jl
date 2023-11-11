abstract type Differential end

struct opendiff{T} <: Differential
    ratio::T #Input turns per output turns
end

struct twowaydiff{T} <: Differential
    ratio::T
    accelpitch::T #meters traveled per rotation of spider gears.
    decelpitch::T #Inf gives a one way diff
    mustatic::T
    mudynamic::T
end

struct viscousdiff{T} <: Differential
    ratio::T
    torqueconstant::T #torque between sides = rotation difference * torqueconstant
end

mutable struct differentialstatevars{T} <: StateVars
    #the input speed is not a unique state var. it is included in driveline speed
    leftspeed::T
    rightspeed::T
end

function unpackstatevars(packedstatevars::differentialstatevars,d::Differential)
    return [packedstatevars.leftspeed,packedstatevars.rightspeed]
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end