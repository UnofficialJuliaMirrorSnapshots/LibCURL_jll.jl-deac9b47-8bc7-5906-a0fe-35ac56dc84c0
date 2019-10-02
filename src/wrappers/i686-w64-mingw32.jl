# Autogenerated wrapper script for LibCURL_jll for i686-w64-mingw32
export curl, libcurl

using LibSSH2_jll
using MbedTLS_jll
using Zlib_jll
## Global variables
PATH = ""
LIBPATH = ""
LIBPATH_env = "PATH"

# Relative path to `curl`
const curl_splitpath = ["bin", "curl.exe"]

# This will be filled out by __init__() for all products, as it must be done at runtime
curl_path = ""

# curl-specific global declaration
function curl(f::Function; adjust_PATH::Bool = true, adjust_LIBPATH::Bool = true)
    global PATH, LIBPATH
    env_mapping = Dict{String,String}()
    if adjust_PATH
        if !isempty(get(ENV, "PATH", ""))
            env_mapping["PATH"] = string(ENV["PATH"], ';', PATH)
        else
            env_mapping["PATH"] = PATH
        end
    end
    if adjust_LIBPATH
        if !isempty(get(ENV, LIBPATH_env, ""))
            env_mapping[LIBPATH_env] = string(ENV[LIBPATH_env], ';', LIBPATH)
        else
            env_mapping[LIBPATH_env] = LIBPATH
        end
    end
    withenv(env_mapping...) do
        f(curl_path)
    end
end


# Relative path to `libcurl`
const libcurl_splitpath = ["bin", "libcurl-4.dll"]

# This will be filled out by __init__() for all products, as it must be done at runtime
libcurl_path = ""

# libcurl-specific global declaration
# This will be filled out by __init__()
libcurl_handle = C_NULL

# This must be `const` so that we can use it with `ccall()`
const libcurl = "libcurl-4.dll"


"""
Open all libraries
"""
function __init__()
    global prefix = abspath(joinpath(@__DIR__, ".."))

    # Initialize PATH and LIBPATH environment variable listings
    global PATH_list, LIBPATH_list
    append!.(Ref(PATH_list), (LibSSH2_jll.PATH_list, MbedTLS_jll.PATH_list, Zlib_jll.PATH_list,))
    append!.(Ref(LIBPATH_list), (LibSSH2_jll.LIBPATH_list, MbedTLS_jll.LIBPATH_list, Zlib_jll.LIBPATH_list,))

    global curl_path = abspath(joinpath(artifact"LibCURL", curl_splitpath...))

    push!(PATH_list, dirname(curl_path))
    global libcurl_path = abspath(joinpath(artifact"LibCURL", libcurl_splitpath...))

    # Manually `dlopen()` this right now so that future invocations
    # of `ccall` with its `SONAME` will find this path immediately.
    global libcurl_handle = dlopen(libcurl_path)
    push!(LIBPATH_list, dirname(libcurl_path))

    # Filter out duplicate and empty entries in our PATH and LIBPATH entries
    filter!(!isempty, unique!(PATH_list))
    filter!(!isempty, unique!(LIBPATH_list))
    global PATH = join(PATH_list, ';')
    global LIBPATH = join(LIBPATH_list, ';')

    # Add each element of LIBPATH to our DL_LOAD_PATH (necessary on platforms
    # that don't honor our "already opened" trick)
    #for lp in LIBPATH_list
    #    push!(DL_LOAD_PATH, lp)
    #end
end  # __init__()

