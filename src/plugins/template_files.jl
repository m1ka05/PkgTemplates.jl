@plugin struct TemplateFiles <: Plugin
    files::Array{String} = []
    dests::Array{String} = []
    vars::Dict{String, String} = Dict()
end

view(p::TemplateFiles, t::Template, pkg::AbstractString) = merge(p.vars, Dict(
    "PKG" => pkg,
))

# validate() = ...

function hook(p::TemplateFiles, t::Template, pkg_dir::AbstractString)
    pkg = basename(pkg_dir)

    for (file, dest) in zip(p.files, p.dests)
        dest = joinpath(pkg_dir, dest)
        mkpath(dirname(dest))
        f = render_file(file, combined_view(p, t, pkg), tags(p))
        gen_file(dest, f)
    end
end
