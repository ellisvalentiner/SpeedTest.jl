using SpeedTest
using Base.Test

server = get_ndt_servers()
@test typeof(server) === Dict{String,Any}
@test all(haskey.(server, ["city", "ip", "fqdn", "site", "url", "country"]))

@test_skip run_test()

output = "Testing network path for configuration and performance problems  --  Using IPv4 address\nChecking for Middleboxes . . . . . . . . . . . . . . . . . .  Done\nchecking for firewalls . . . . . . . . . . . . . . . . . . .  Done\nrunning 10s outbound test (client to server) . . . . .  11.68 Mb/s\nrunning 10s inbound test (server to client) . . . . . . 85.58 Mb/s\nsending meta information to server . . . . . Done\nThe slowest link in the end-to-end path is a 10 Mbps Ethernet or WiFi 11b subnet\nServer 'ndt.iupui.mlab1.ord01.measurement-lab.org' is not behind a firewall. [Connection to the ephemeral port was successful]\nClient is probably behind a firewall. [Connection to the ephemeral port failed]\nPacket size is preserved End-to-End\nServer IP addresses are preserved End-to-End\nInformation: Network Address Translation (NAT) box is modifying the Client's IP address\n\tServer says [68.51.212.235] but Client says [ 10.0.1.5]\n"
@test parse_speeds(output) == Array{Float64,1}([11.68, 85.58])

@test_skip speed_test()
