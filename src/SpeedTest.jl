module SpeedTest

# package code goes here
using ArgCheck
using Requests

include("utils.jl")
export get_ndt_servers, run_test, parse_speeds, speedtest

end # module
