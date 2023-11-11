include("generalphysics.jl")
abstract type Vehicle end
abstract type Motor end
abstract type Differential end
abstract type Drivetrain end
abstract type Suspension end
abstract type Transmission end

struct electricmotor{T} <: Motor
    voltage::T
    kV::T
end

struct generalizedmotor{T} <: Motor
    torquepts::Vector{T}
    rpmpts::Vector{T}
end

struct wheel{T} <: Body
    pressure::T #pressure under NOMINAL conditions
    material::string #https://racecar-engineering.telegraph.co.uk/tech-explained/tyre-dynamics/
    w::T
    r::T
    ci::T #Radius of gyration/Radius
    crr::T#Rolling resistance coeficient
end

struct opendiff <: Differential
    ratio::T #Input turns per output turns
end

struct 2waydiff <: Differential
    ratio::T
    accelpitch::T #meters traveled per rotation of spider gears.
    decelpitch::T #Inf gives a one way diff
    mustatic::T
    mudynamic::T
end

struct viscousdiff <: Differential
    ratio::T
    torqueconstant::T #torque between sides = rotation difference * torqueconstant
end

struct nspeed <: Transmission
    ratios::Vector{T}#motor turns per driveshaft turns.
end

struct simpleawddrivetrain{T} <: Drivetrain
    frontsplit::T
    frontdifferential::Differential
    reardifferential::Differential
    transmission::Transmission
end

struct 4wddrivetrain <: Drivetrain #has a transfer case
    frontdifferential::Differential
    reardifferential::Differential
    transmission::Transmission
end

struct 2wddrivetrain <: Drivetrain
    type::Bool # 0 for fwd 1 for rwd
    differential::Differential
    transmission::Transmission
end

struct basicfourwheelsuspension{T} <: Suspension
    #all values at zero load  and for the right side of the car (max suspension)
    #FRONT SUSPENSION
    fronttopcontrolarmlength::T
    fronttopcontrolarmroot::Tuple{T,T,T}
    fronttopcontrolarmtip::Tuple{T,T,T}
    frontbottomcontrolarmlength::T
    frontbottomcontrolarmroot::Tuple{T,T,T}
    fronttopcontrolarmtip::Tuple{T,T,T}
    frontcontrolarmsmountingaxis::Tuple{T,T,T} #the axis relative the unsprung part of the car that the control arm rotates about. Must be the same for top and bottom control arms
    frontwheel::Tuple{T,T,T} #location of geometric center of wheel.
    frontspringroot::T
    frontspringtip::T
    frontspringconstant::T
    frontbumpdamping::T
    frontrebounddamping::T
    frontpreload::T
    #REAR SUSPENSION
    reartopcontrolarmlength::T
    reartopcontrolarmroot::Tuple{T,T,T}
    reartopcontrolarmtip::Tuple{T,T,T}
    rearbottomcontrolarmlength::T
    rearbottomcontrolarmroot::Tuple{T,T,T}
    reartopcontrolarmtip::Tuple{T,T,T}
    rearcontrolarmsmountingaxis::Tuple{T,T,T} #the axis relative the unsprung part of the car that the control arm rotates about. Must be the same for top and bottom control arms
    rearwheel::Tuple{T,T,T} #location of geometric center of wheel.
    rearspringroot::T
    rearspringtip::T
    rearspringconstant::T
    rearbumpdamping::T
    rearrebounddamping::T
    rearpreload::T
    #STEERING
    pinionradius::T
    steeringleverarm::T #distance between wheel's axis of turning and the rack's connection point.
end

struct basiccar <: Vehicle
    unsprung::rigidbody
    wheels::Vector{wheel}
    motor::Motor
    drivetrain::Drivetrain
    suspension::Suspension #Contains all relationships between wheel travel, geometry, and steering.
end
