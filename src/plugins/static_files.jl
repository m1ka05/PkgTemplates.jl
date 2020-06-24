@plugin struct StaticFiles <: Plugin
    files::Array{String} = []
    dests::Array{String} = []
end

# validate() = ...

function hook(p::StaticFiles, t::Template, pkg_dir::AbstractString)
    pkg = basename(pkg_dir)

    for (file, dest) in zip(p.files, p.dests)
        dest = joinpath(pkg_dir, dest)
        mkpath(dirname(dest))
        cp(file, dest)
    end
end
