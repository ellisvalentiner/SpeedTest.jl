# SpeedTest

[![Build Status](https://travis-ci.org/ellisvalentiner/SpeedTest.jl.svg?branch=master)](https://travis-ci.org/ellisvalentiner/SpeedTest.jl)

[![Coverage Status](https://coveralls.io/repos/ellisvalentiner/SpeedTest.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/ellisvalentiner/SpeedTest.jl?branch=master)

[![codecov.io](http://codecov.io/github/ellisvalentiner/SpeedTest.jl/coverage.svg?branch=master)](http://codecov.io/github/ellisvalentiner/SpeedTest.jl?branch=master)

Run network speed tests from Julia.

## Overview

This package facilitates network performance tests (i.e. speed tests) using Network Diagnostic Test (NDT) servers.

## Installation

This package **requires** web100clt, the [NDT]() client command line utility.

On macOS:

```bash
brew install web100clt
```

On linux:

```bash
apt-get update && apt-get install -y git automake gcc make libssl-dev libjansson-dev python
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
```

or more simply

```julia
using SpeedTest

speed_test()
```
