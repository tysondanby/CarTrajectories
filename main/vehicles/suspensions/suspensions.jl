abstract type Suspension end
abstract type FourWheelSuspension <: Suspension end

include("wheels/wheels.jl")

struct geometricfourwheelsuspension{T} <: FourWheelSuspension
    #all values at zero load  and for the right side of the car (max suspension)
    #FRONT SUSPENSION
    fronttopcontrolarmroot::Tuple{T,T,T}
    fronttopcontrolarmtip::Tuple{T,T,T}
    frontbottomcontrolarmroot::Tuple{T,T,T}
    frontbottomcontrolarmtip::Tuple{T,T,T}
    frontcontrolarmsmountingaxis::Tuple{T,T,T} #the axis relative the unsprung part of the car that the control arm rotates about. Must be the same for top and bottom control arms
    frontwheel::Wheel
    frontwheelpos::Tuple{T,T,T} #location of geometric center of wheel.
    frontspringroot::Tuple{T,T,T}
    frontspringtip::Tuple{T,T,T}
    frontspringconstant::T
    frontbumpdamping::T
    frontrebounddamping::T
    frontpreload::T
    frontrollbaraxis::Tuple{T,T,T}
    frontrollbarstiffness::T #Nm/Rad
    frontrollbarlinkageroot::Tuple{T,T,T} #where linkage connects to rollbar
    frontrollbarlinkagetip::Tuple{T,T,T} #where linkage connects to wheel half of spring.
    #REAR SUSPENSION
    reartopcontrolarmroot::Tuple{T,T,T}
    reartopcontrolarmtip::Tuple{T,T,T}
    rearbottomcontrolarmroot::Tuple{T,T,T}
    rearbottomcontrolarmtip::Tuple{T,T,T}
    rearcontrolarmsmountingaxis::Tuple{T,T,T} #the axis relative the unsprung part of the car that the control arm rotates about. Must be the same for top and bottom control arms
    rearwheel::Wheel
    rearwheelpos::Tuple{T,T,T} #location of geometric center of wheel.
    rearspringroot::Tuple{T,T,T}
    rearspringtip::Tuple{T,T,T}
    rearspringconstant::T
    rearbumpdamping::T
    rearrebounddamping::T
    rearpreload::T
    rearrollbaraxis::Tuple{T,T,T}
    rearrollbarstiffness::T #Nm/Rad
    rearrollbarlinkageroot::Tuple{T,T,T} #where linkage connects to rollbar
    rearrollbarlinkagetip::Tuple{T,T,T} #where linkage connects to wheel half of spring.
    #STEERING
    pinionradius::T
    steeringleverarm::T #distance between wheel's axis of turning and the rack's connection point.
    fronttoeout::T #Nominal
    reartoeout::T #Nominal
end

struct basicfourwheelsuspension{T} <: FourWheelSuspension
    #Nominal is car at rest on a level surface. All values are nominal.
    fronttoeout::T
    frontcamber::T
    frontcamberrate::T #change in camber per unit movement up into wheelwell
    frontcaster::T
    frontstiffness::T
    frontbumpdamping::T
    frontrebounddamping::T
    frontsrollstiffness::T
    frontwheelpos::T
    frontwheel::Wheel
    reartoeout::T
    rearcamber::T
    rearcamberrate::T
    rearstiffness::T
    rearbumpdamping::T
    rearrebounddamping::T
    rearsrollstiffness::T
    rearwheelpos::T
    rearwheel::Wheel

    steeringratio::T#degrees steering wheel rotation per degree of tire movement
end

mutable struct fourwheelsuspensionstatevars <: StateVars
    frontleftcompression::T #Spring compression
    frontrightcompression::T #Spring compression
    rearleftcompression::T #Spring compression
    rearrightcompression::T #Spring compression
    frontwheels::StateVars
    rearwheels::StateVars
end

function unpackstatevars(packedstatevars::fourwheelsuspensionstatevars,s::FourWheelSuspension)
    unpackedstatevars = []
    for field in fieldnames(typeof(packedstatevars))
        if typeof(getproperty(packedstatevars,field)) == :StateVars
            unpackedstatevars = [unpackedstatevars;upackstatevars(getproperty(packedstatevars,field),getproperty(s,field))]
        else
            unpackstatevars = [unpackedstatevars;getproperty(packedstatevars,field)]
        end
    end
    return unpackedstatevars
end

function packstatevars(unpackedstatevars::T,v::basiccar) where T

end