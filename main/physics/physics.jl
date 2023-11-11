abstract type Body end

struct rigidbody{T} <: Body
    I::Array{T,2}
    m::T
    com::Tuple{T,T,T}
    l::T
    w::T
    h::T
end
mutable struct rigidbodystatevars{T} <: StateVars
    pos::Tuple{T,T,T}
    eulerangles::Tuple{T,T,T}
end

function unpackstatevars(packedstatevars::rigidbodystatevars,r::rigidbody)
    return [packedstatevars.pos...;packedstatevars.eulerangles...]
end

function packstatevars(unpackedstatevars::T,r::rigidbody) where T

end

#TODO: write a friction model for switching between static and sliding