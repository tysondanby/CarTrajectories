abstract type Body end

struct rigidbody{T} <: Body
    I::Array{T,2}
    m::T
    com::Vector{T}
    l::T
    w::T
    h::T
end

function torque(motor::electricmotor,RPM,throttle)
    return Q
end
function torque(motor::generalizedmotor,RPM,throttle)
    return Q
end