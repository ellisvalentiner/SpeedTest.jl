
"""
Identify NDT servers
"""
function get_ndt_servers(; policy::String="nearest")
  @assert in(policy, ["nearest", "all"])
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
  speed = collect(Iterators.flatten(matchall.(r"\d+.\d+", matchall(r"\d+.\d+ Mb/s", output))))
  return float.(speed)
end

"""

"""
function speed_test(;server_name::String="")
  if server_name !== ""
    nearest_server = get_ndt_servers(policy="nearest")
    server_name = nearest_server["fqdn"]
  end
  timestamp = now()
  raw = run_test(server_name)
  speeds = parse_speeds(raw)
  return Dict("timestamp"=>timestamp, "upload"=>speeds[1], "download"=>speeds[2])
end
