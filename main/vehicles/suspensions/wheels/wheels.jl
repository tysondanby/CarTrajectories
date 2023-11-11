abstract type Wheel <: Body end

struct simplewheel{T} <: Wheel
    pressure::T #pressure with no applied force
    dampingcoefficient::T 
    material::String #only for geting friction properties
    w::T
    r::T
    m::T
    ci::T #Radius of gyration/Radius
    crr::T#Rolling resistance coeficient
end

struct midfidelitywheel{T} <: Wheel
    pressure::T #pressure with no applied force
    treadthickness::T
    sidewallthickness::T
    radialairgap::T
    material::String #https://racecar-engineering.telegraph.co.uk/tech-explained/tyre-dynamics/
    treadpattern::T
    w::T
    r::T
    m::T
    ci::T #Radius of gyration/Radius
    crr::T#Rolling resistance coeficient
end

mutable struct wheelstatevars{T} <: StateVars
    #Bottom of tyre (position wise neglecting sliding) is on track or in the air. it is not an independent state var.
    speed::T
end

function unpackstatevars(packedstatevars::wheelstatevars,w::Wheel)
    return [packedstatevars.speed]
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end