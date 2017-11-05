using Documenter, SpeedTest

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs"),
    repo   = "github.com/ellisvalentiner/SpeedTest.jl.git",
    julia  = "0.6"
)
