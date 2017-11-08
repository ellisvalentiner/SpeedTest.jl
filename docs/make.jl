using Documenter, SpeedTest

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs", "python-markdown-math"),
    repo   = "github.com/ellisvalentiner/SpeedTest.jl.git",
    julia  = "0.6"
)
