abstract type Vehicle end
abstract type VehicleStateVars <: StateVars end

include("drivetrains/drivetrains.jl")
include("motors/motors.jl")
include("suspensions/suspensions.jl")

struct basiccar <: Vehicle
    unsprung::rigidbody
    motor::Motor
    drivetrain::Drivetrain
    suspension::Suspension #Contains all relationships between wheel travel, geometry, and steering.
end
mutable struct basiccarstatevars <: VehicleStateVars
    unsprung::StateVars
    motor::StateVars
    drivetrain::StateVars
    suspension::StateVars #Contains all relationships between wheel travel, geometry, and steering.
end

function unpackstatevars(packedstatevars::basiccarstatevars,v::basiccar)
    unpackedstatevars = []
    for field in fieldnames(typeof(v))
        unpackedstatevars = [unpackedstatevars;upackstatevars(getproperty(packedstatevars,field),getproperty(v,field))]
    end
    return unpackedstatevars
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end

function createstatevars(statevars::T,car::basiccar)

end