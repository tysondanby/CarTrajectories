abstract type StateVars end


function interpolate(xs::Vector{T},ys::Vector{T},x::T) where T
    #TODO? assert xs are in order and x is within the range
    found = false
    i = 0
    #find upper bound
    while (found == false) && (i < length(xs))
        i = i+1
        if x < xs[i]
            found == true
        end
    end
    return (y[i-1]-y[i])/(x[i-1]-x[i]) * (x-x[i]) + y[i]
end