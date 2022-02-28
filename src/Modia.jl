"""
Main module of Modia.

* Developer: Hilding Elmqvist, Mogram AB
* First version: December 2020
* License: MIT (expat)

"""
module Modia

const path = dirname(dirname(@__FILE__))   # Absolute path of package directory
const Version = "0.8.0"
const Date = "2022-03-01"
const modelsPath = joinpath(Modia.path, "models")

print(" \n\nWelcome to ")
print("Mod")
printstyled("ia", bold=true, color=:red)
print(" - ")
printstyled("Dynamic ", color=:light_black)
print("Mod")
printstyled("eling and Simulation with Jul", color=:light_black)
printstyled("ia", bold=true, color=:red)

println()
println("Version $Version ($Date)")


# Defalut switch settings
logStatistics = false
logExecution = false
logCalculations = false

useNewCodeGeneration = false
experimentalTranslation = false

using Reexport

@reexport using Unitful                 # export Unitful symbols
@reexport using DifferentialEquations   # export DifferentialEquations symbols

export ModiaBase
export CVODE_BDF, IDA
export instantiateModel, @instantiateModel, assert, stringifyDefinition
export stripUnit

export simulate!, linearize!, get_result
export @usingModiaPlot, usePlotPackage, usePreviousPlotPackage, currentPlotPackage
export resultInfo, printResultInfo, rawSignal, getPlotSignal, defaultHeading
export signalNames, timeSignalName, hasOneTimeSignal, hasSignal

export SimulationModel, measurementToString, get_lastValue
export positive, negative, previous, edge, after, reinit, pre
export initial, terminal, isInitial, isTerminal, initLinearEquationsIteration!
export get_xNames
export registerExtraSimulateKeywordArguments
export get_extraSimulateKeywordArgumentsDict




import Sundials
const  CVODE_BDF = Sundials.CVODE_BDF
const  IDA = Sundials.IDA


using Base.Meta: isexpr
using OrderedCollections: OrderedDict

using ModiaBase
using ModiaBase.Symbolic
using ModiaBase.Simplify
using ModiaBase.BLTandPantelidesUtilities
using ModiaBase.BLTandPantelides
using ModiaBase.Differentiate

import ModiaResult
import ModiaResult: usePlotPackage, usePreviousPlotPackage, currentPlotPackage
import ModiaResult: resultInfo, printResultInfo, rawSignal, getPlotSignal, defaultHeading
import ModiaResult: signalNames, timeSignalName, hasOneTimeSignal, hasSignal

import StaticArrays   # Make StaticArrays available for the tests


using  Measurements
import MonteCarloMeasurements
using JSON
#using Profile
import Test
using  TimerOutputs
using  InteractiveUtils

global to = TimerOutput()

Unitful.unit(      v::MonteCarloMeasurements.AbstractParticles{T,N}) where {T,N} = unit(T)
Unitful.upreferred(v::MonteCarloMeasurements.AbstractParticles{T,N}) where {T,N} = uconvert(upreferred(unit(v)), v)

# append! as needed in EquationAndStateInfo.jl and in CodeGeneration.jl
appendVariable!(v1::Vector{FloatType}, s::FloatType) where {FloatType} = push!(v1,s)
appendVariable!(v1::Vector{FloatType}, v2)           where {FloatType} = append!(v1,v2)


"""
    stripUnit(v)

Convert the unit of `v` to the preferred units (default are the SI units),
and then strip the unit. For details see `upreferred` and `preferunits` in
[Unitful](https://painterqubits.github.io/Unitful.jl/stable/conversion/)

The function is defined as: `stripUnit(v) = ustrip.(upreferred.(v))`.
"""
stripUnit(v) = ustrip.(upreferred.(v))

include("EquationAndStateInfo.jl")
include("StateSelection.jl")

include("ModelCollections.jl")
include("EvaluateParameters.jl")
include("EventHandler.jl")
include("CodeGeneration.jl")
# include("GenerateGetDerivatives.jl")
include("Synchronous.jl")
include("SimulateAndPlot.jl")
include("ReverseDiffInterface.jl")
include("PathPlanning.jl")
include("JSONModel.jl")

# include("IncidencePlot.jl")
# using .IncidencePlot
# Base.Experimental.@optlevel 0

const drawIncidence = false


include("ModiaLang.jl")

end