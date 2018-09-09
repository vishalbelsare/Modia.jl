module Synchronous

using ..Instantiation

#= Synchronous Modelica primitives

Clock() 
Clock(intervalCounter::Int, resolution::Int=1)  # Add version with rational number
Clock(interval::Float64) 
Clock(condition::Bool, startInterval::Float64=0.0) 
Clock(c::Clock, solverMethod) 

previous(x)

sample(u, c::Clock)
sample(u) 

hold(u) = u

subSample(u, factor::Int)
superSample(u, factor::Int)
shiftSample(u, shiftCounter::Int, resolution::Int=1)  # Add version with rational number
backSample(u, backCounter::Int, resolution::Int=1)  # Add version with rational number

noClock() 

interval(u)

=#

# The argument list of function F is extended with the argument simulationModel.

const nClock = 100
const nSample = 100
const nPrevious = 100
const nCrossings = 100

mutable struct Store
    clock::Vector{Float64}
    sample::Vector{Any}
    previous::Vector{Any}
    nextPrevious::Vector{Any}
    crossings::Vector{Any}
  
    Store() = new(zeros(nClock), Array{Any}(nSample), zeros(nPrevious), zeros(nPrevious), zeros(nCrossings))
end

isLog(m) = true

# -------------------------------------------------------------------

# Temporary:
allInstances(s) = return s


function Clock(interval::Float64, m, nr::Int) 
    return false
end

function positive(crossing::Float64, m, nr::Int)
end

positiveChange(crossing::Float64, m, nr::Int) = error("not defined")
positiveEdge(crossing::Float64, m, nr::Int) = error("not defined")

function sample(v, clock::Bool, m, nr::Int) 
    return v
end

# initPrevious not used
function initPrevious(v, m, nr::Int) 
    return v
end

function previous(v, clock::Bool, m, nr::Int) 
    return v
end

function updatePrevious(v, m, nr::Int) 
    return v
end

hold(v) = v

end