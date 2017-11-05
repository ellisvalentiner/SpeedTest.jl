using Documenter, SpeedTest

makedocs()

deploydocs(
    deps   = Deps.pip("mkdocs"),
    repo   = "github.com/USER_NAME/PACKAGE_NAME.jl.git",
    julia  = "0.6"
)
