abstract type Drivetrain end
abstract type BasicDrivetrain <: Drivetrain end
abstract type BasicDrivetrainStateVars <: StateVars end

include("differentials/differentials.jl")
include("transmissions/transmissions.jl")

struct simpleawddrivetrain{T} <: BasicDrivetrain
    frontsplit::T
    frontdifferential::Differential
    reardifferential::Differential
    transmission::Transmission
    If::T #inertia of driveline
    Ir::T #inertia of driveline
end

struct fourdrivetrain{T} <: BasicDrivetrain #has a transfer case
    frontdifferential::Differential
    reardifferential::Differential
    transmission::Transmission
    I::T #inertia of driveline
end

struct twodrivetrain{T} <: BasicDrivetrain
    type::Bool # 0 for fwd 1 for rwd
    differential::Differential
    transmission::Transmission
    I::T #inertia of driveline
end

mutable struct twodrivetrainstatevars{T} <: BasicDrivetrainStateVars
    differential::StateVars
    transmission::StateVars
    drivelinespeed::T
end

mutable struct fourdrivetrainstatevars{T} <: BasicDrivetrainStateVars
    frontdifferential::StateVars
    reardifferential::StateVars
    transmission::StateVars
    drivelinespeed::T
end

mutable struct simpleawddrivetrainstatevars{T} <: BasicDrivetrainStateVars
    frontdifferential::StateVars
    reardifferential::StateVars
    transmission::StateVars
    frontdrivelinespeed::T
    reardrivelinespeed::T
end

function unpackstatevars(packedstatevars::BasicDrivetrainStateVars,d::BasicDrivetrain)
    unpackedstatevars = []
    for field in fieldnames(typeof(packedstatevars))
        if typeof(getproperty(packedstatevars,field)) == :StateVars
            unpackedstatevars = [unpackedstatevars;upackstatevars(getproperty(packedstatevars,field),getproperty(d,field))]
        else
            unpackstatevars = [unpackedstatevars;getproperty(packedstatevars,field)]
        end
    end
    return unpackedstatevars
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end