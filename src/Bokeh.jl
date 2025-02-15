module Bokeh

# Base.Experimental.@compiler_options optimize=0 compile=min

import Base: IdSet
import Base64
import Colors
import Dates
import JSON3
import Markdown
import Tables
import UUIDs

const BOKEH_VERSION = v"2.4.2"

export Field, Value, Document
export figure, plot!
export transform, dodge, factor_mark, factor_cmap, factor_hatch, jitter, linear_cmap, log_cmap
export row, column

include("data.jl")
include("typedefs.jl")
include("settings.jl")
include("spec.jl")
include("core.jl")
include("serialize.jl")
include("types.jl")
include("descs.jl")
include("models.jl")
include("plotting.jl")
include("templates.jl")
include("document.jl")
include("display.jl")
include("init.jl")

precompile(figure, ())
precompile(Figure, ())
precompile(plot!, (ModelInstance, ModelType))
precompile(plot!, (ModelInstance, ModelInstance))
precompile(display, (BokehDisplay, MIME"text/html", ModelInstance))
precompile(display, (BokehDisplay, MIME"text/html", Document))

end
