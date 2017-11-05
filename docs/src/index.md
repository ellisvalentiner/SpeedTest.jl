# SpeedTest.jl

Run network speed tests from Julia.

## Overview

This package facilitates network performance tests (i.e. speed tests) using the [Network Diagnostic Tool (NDT)](https://github.com/ndt-project/ndt/) and [Measurement Lab](https://www.measurementlab.net/) servers.

## Installation

This package **requires** web100clt, a part of the NDT client command line utility.

On macOS:

```bash
brew install web100clt
```

On linux:

```bash
apt update && apt install -y git automake gcc make libssl-dev libjansson-dev python
git clone --recursive https://github.com/ndt-project/ndt
cd ndt/I2util && ./bootstrap.sh && ./configure && make && make install
cd ndt && ./bootstrap && ./configure && make
```

Please note that I cannot help you troubleshoot issues with NDT utilities.

***

Then install this package as you would normally:

```julia
# SpeedTest.jl is not currently registered as an official package
# Please install the development version from GitHub:
Pkg.clone("git://GitHub.com/ellisvalentiner/SpeedTest.jl")
```

If you encounter a clear bug, please file a minimal reproducible example on GitHub.

## Usage

```julia
using SpeedTest

nearest_server = get_ndt_servers(policy="nearest")
server_name = nearest_server["fqdn"]
raw = run_test(server_name)
print(raw)
# Testing network path for configuration and performance problems  --  Using IPv4 address
# Checking for Middleboxes . . . . . . . . . . . . . . . . . .  Done
# checking for firewalls . . . . . . . . . . . . . . . . . . .  Done
# running 10s outbound test (client to server) . . . . .  11.63 Mb/s
# running 10s inbound test (server to client) . . . . . . 4.49 Mb/s
# sending meta information to server . . . . . Done
# The slowest link in the end-to-end path is a 10 Mbps Ethernet or WiFi 11b subnet
# Information: Other network traffic is congesting the link
# Server 'ndt.iupui.mlab1.ord04.measurement-lab.org' is not behind a firewall. [Connection to the ephemeral port was successful]
# Client is probably behind a firewall. [Connection to the ephemeral port failed]
# Packet size is preserved End-to-End
# Server IP addresses are preserved End-to-End
# Information: Network Address Translation (NAT) box is modifying the Client's IP address
# 	Server says [68.51.212.235] but Client says [ 10.0.1.5]
```

or more simply

```julia
using SpeedTest

speed_test()
# Dict{String,Any} with 3 entries:
#   "upload"    => 11.73
#   "download"  => 87.19
#   "timestamp" => 2017-11-04T17:31:06.93
```
