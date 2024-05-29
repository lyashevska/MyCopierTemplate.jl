using MyCopierTemplate
using Documenter

DocMeta.setdocmeta!(MyCopierTemplate, :DocTestSetup, :(using MyCopierTemplate); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers

function nice_name(file)
  file = replace(file, r"^[0-9]*-" => "")
  if haskey(page_rename, file)
    return page_rename[file]
  end
  return splitext(file)[1] |> x -> replace(x, "-" => " ") |> titlecase
end

makedocs(;
  modules = [MyCopierTemplate],
  doctest = true,
  linkcheck = true,
  authors = "Olga Lyashevska <olga.lyashevska@gmail.com> and contributors",
  repo = "https://github.com/lyashevska/MyCopierTemplate.jl/blob/{commit}{path}#{line}",
  sitename = "MyCopierTemplate.jl",
  format = Documenter.HTML(;
    prettyurls = true,
    canonical = "https://lyashevska.github.io/MyCopierTemplate.jl",
    assets = ["assets/style.css"],
  ),
  pages = [
    "Home" => "index.md"
    [
      nice_name(file) => file for
      file in readdir(joinpath(@__DIR__, "src")) if file != "index.md" && splitext(file)[2] == ".md"
    ]
  ],
)

deploydocs(; repo = "github.com/lyashevska/MyCopierTemplate.jl", push_preview = true)
