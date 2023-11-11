abstract type Motor end
abstract type BasicMotor <: Motor end
#STRUCTS

struct electricmotor{T} <: BasicMotor
    voltage::T
    kV::T
    I::T #inertia
end

struct generalizedmotor{T} <: BasicMotor
    torquepts::Vector{T}
    rpmpts::Vector{T}
    I::T #inertia
end

mutable struct basicmotorstatevars{T} <: StateVars
    speed::T
end

function unpackstatevars(packedstatevars::basicmotorstatevars,m::BasicMotor)
    return [packedstatevars.speed]
end

function packstatevars(unpackedstatevars::T,m::BasicMotor) where T

end

#FUNCTIONS

function torque(motor::electricmotor,RPM,throttle)
    Q=0
    return Q
end

function torque(motor::generalizedmotor,RPM,throttle)
    Q=0
    return Q
end