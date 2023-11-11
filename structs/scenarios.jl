abstract type Scenario end

struct splinetrack{T} <: Scenario
    surf::string
    xpts::Vector{T}
    ypts::Vector{T}
    zpts::Vector{T}
    ths::Vector{T}#Bank angles
    ws::Vector{T} #track width
    fraclcurb::Vector{T} #Left Curb
    lcurbth::Vector{T}
    fracrcurb::Vector{T} #Right Curb
    rcurbth::Vector{T}
end