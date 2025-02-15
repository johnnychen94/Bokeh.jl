Serializer() = Serializer(Dict{String,Any}(), Dict{String,Any}())

serialize(s::Serializer, x::Nothing) = nothing
serialize(s::Serializer, x::Missing) = "NaN"
serialize(s::Serializer, x::Bool) = x
serialize(s::Serializer, x::Int) = x
serialize(s::Serializer, x::BigInt) = x
serialize(s::Serializer, x::Integer) = (y=mod(x,Int); y==x ? y : convert(BigInt, x))
serialize(s::Serializer, x::Real) = _naninfstr(convert(Float64, x))
serialize(s::Serializer, x::AbstractString) = convert(String, x)
serialize(s::Serializer, x::Symbol) = String(x)
serialize(s::Serializer, x::AbstractVector) = [serialize(s,x) for x in x]
serialize(s::Serializer, x::AbstractMatrix) = [serialize(s,x) for x in eachcol(x)]
serialize(s::Serializer, x::AbstractDict) = Dict(serialize(s,k)=>serialize(s,v) for (k,v) in x)
serialize(s::Serializer, x::Tuple) = [serialize(s,x) for x in x]

function serialize(s::Serializer, x::Field)
    ans = Dict{String,Any}("field" => x.name)
    if x.transform !== nothing
        ans["transform"] = serialize(s, x.transform)
    end
    return ans
end

function serialize(s::Serializer, x::Value)
    ans = Dict{String,Any}("value" => serialize(s, x.value))
    if x.transform !== nothing
        ans["transform"] = serialize(s, x.transform)
    end
    return ans
end

_naninfstr(x::Float64) = isnan(x) ? "NaN" : isinf(x) ? signbit(x) ? "-Infinity" : "Infinity" : x
