
"""
Identify NDT servers
"""
function get_ndt_servers(; policy::String="geo", metro::String="", ip::String="", address_family::String="ipv4", country::String="", city::String="")
  @assert in(policy, ["geo", "random", "metro", "country", "all"])
  resp = Requests.get("https://mlab-ns.appspot.com/ndt"; query=Dict("policy"=>policy))
  Requests.json(resp)
end

"""
Run network test to specified server
"""
function run_test(fqdn::String)
  read(`web100clt --name $fqdn`, String)
end

"""
Parse web100clt output
"""
function parse_speeds(output::String)
  x = matchall(r"\d+.\d+ [Mb/s|kb/s]", output)
  speed = Array{Float64,1}()
  for i in 1:length(x)
    if ismatch(r" k", x[i])
      append!(speed, 0.001 * float(matchall(r"\d+.\d+", x[i])))
    else
      append!(speed, float(matchall(r"\d+.\d+", x[i])))
    end
  end
  return speed
end

"""

"""
function speedtest(;server_name::String="", policy::String="geo", kwargs...)
  if server_name !== ""
    serverinfo = get_ndt_servers(policy=policy, kwargs...)
    servername = serverinfo["fqdn"]
  end
  timestamp = now()
  raw = run_test(servername)
  speeds = parse_speeds(raw)
  if length(speeds) == 2
    output = Dict("timestamp"=>timestamp, "upload"=>speeds[1], "download"=>speeds[2], "serverinfo"=>serverinfo, "response"=>raw)
  else
    output = Dict("timestamp"=>timestamp, "upload"=>0, "download"=>0, "serverinfo"=>serverinfo, "response"=>raw)
  end
  return output
end
