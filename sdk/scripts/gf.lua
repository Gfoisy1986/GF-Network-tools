------------------------------------------------------------
-- GF Unified CLI (Portable SDK)
------------------------------------------------------------
-- List .f90 files on Windows (CMD does not expand wildcards)
local function list_f90_files(path)
local files = {}
local p = io.popen('dir "' .. path .. '" /b 2>nul')
if p then
    for file in p:lines() do
        if file:match("%.f90$") then
            table.insert(files, file)
            end
            end
            p:close()
            end
            return files
            end

-- 1. Detect script directory
local function script_dir()
local info = debug.getinfo(1, "S")
local path = info.source:sub(2)
return path:match("(.*/)") or path:match("(.*\\)")
end

local SCRIPT_DIR = script_dir():gsub("\\", "/")

-- 2. Compute SDK root
local SDK_ROOT = SCRIPT_DIR .. "../.."
SDK_ROOT = SDK_ROOT:gsub("\\", "/")

-- 3. Load path.cfg from same folder as gf.lua
local cfg = {}
for line in io.lines(SCRIPT_DIR .. "path.cfg") do
    local k, v = line:match("([^=]+)=(.+)")
    if k and v then cfg[k] = v end
        end

        -- 4. Detect OS
        local is_windows = package.config:sub(1,1) == "\\"
        local osname = is_windows and "windows" or "unix"

        -- 5. Detect architecture
        local arch = jit and jit.arch
        or os.getenv("PROCESSOR_ARCHITECTURE")
        or os.getenv("HOSTTYPE")
        or "unknown"

        arch = arch:lower()
        if arch == "amd64" or arch == "x86_64" then arch = "x86_64" end
            if arch == "arm64" or arch == "aarch64" then arch = "arm64" end

                -- 6. Select toolchain paths
                local LUA_PATH
                local GFORTRAN_PATH
                local NASM_PATH

                if is_windows then
                    LUA_PATH      = cfg["LUA_WIN_" .. arch]
                    GFORTRAN_PATH = cfg["GFORTRAN_WIN_" .. arch]
                    NASM_PATH     = cfg["NASM_WIN_" .. arch]
                    else
                        LUA_PATH      = cfg["LUA_UNIX_" .. arch]
                        GFORTRAN_PATH = cfg["GFORTRAN_UNIX_" .. arch]
                        NASM_PATH     = cfg["NASM_UNIX_" .. arch]
                        end

                        -- 7. Build local PATH (not global)
                        local sep = is_windows and ";" or ":"
                        local LOCAL_PATH = ""

                        local function add(p)
                        if p then
                            LOCAL_PATH = LOCAL_PATH .. SDK_ROOT .. "/" .. p .. sep
                            end
                            end

                            add(LUA_PATH)
                            add(GFORTRAN_PATH)
                            add(NASM_PATH)

                            -- Append system PATH
                            LOCAL_PATH = LOCAL_PATH .. os.getenv("PATH")

                            -- 8. Command dispatcher
                            local cmd = arg[1]

                            -- doctor
                            if cmd == "doctor" then
                                print("GF SDK Diagnostics")
                                print("-------------------")
                                print("OS:         ", osname)
                                print("Arch:       ", arch)
                                print("Script Dir: ", SCRIPT_DIR)
                                print("SDK Root:   ", SDK_ROOT)
                                print("")
                                print("Toolchain Paths:")
                                print("  Lua:      ", LUA_PATH or "not found")
                                print("  GFortran: ", GFORTRAN_PATH or "not found")
                                print("  NASM:     ", NASM_PATH or "not found")
                                print("")
                                print("Local PATH:")
                                print(LOCAL_PATH)
                                return
                                end

                                -- hello
                                if cmd == "hello" then
                                    print("Hello from the unified GF CLI!")
                                    return
                                    end

                                    -- default help
                                    print("GF CLI")
                                    print("Usage:")
                                    print("  gf doctor   - check environment")
                                    print("  gf hello    - test CLI")

                                    ------------------------------------------------------------
                                    -- Command: new <project>
                                    ------------------------------------------------------------
                                    if cmd == "new" then
                                        local name = arg[2]
                                        if not name then
                                            print("Usage: gf new <project>")
                                            return
                                            end

                                            print("Creating new project:", name)

                                            -- OS‑specific mkdir
                                            if is_windows then
                                                os.execute('mkdir "' .. name .. '"')
                                                os.execute('mkdir "' .. name .. '\\src"')
                                                os.execute('mkdir "' .. name .. '\\build"')
                                                else
                                                    os.execute('mkdir -p "' .. name .. '/src"')
                                                    os.execute('mkdir -p "' .. name .. '/build"')
                                                    end

                                                    -- Create main.f90
                                                    local path = name .. (is_windows and "\\src\\main.f90" or "/src/main.f90")
                                                    local f = io.open(path, "w")

                                                    if not f then
                                                        print("Error: could not create file:", path)
                                                        return
                                                        end

                                                        f:write([[
                                                            program main
                                                            print *, "Hello from GF-Fortran-SDK!"
                                                            end program main
                                                        ]])
                                                        f:close()

                                                        print("Project created at ./" .. name)
                                                        return
                                                        end



                                                        ------------------------------------------------------------
                                                        -- Command: build <project>
                                                        ------------------------------------------------------------
                                                        if cmd == "build" then
                                                            local name = arg[2]
                                                            if not name then
                                                                print("Usage: gf build <project>")
                                                                return
                                                                end

                                                                print("Building project:", name)

                                                                local src_dir = name .. "/src"
                                                                local out = name .. "/build/app"
                                                                if is_windows then out = out .. ".exe" end

                                                                    local compile_cmd

                                                                    if is_windows then
                                                                        -- Manually list .f90 files
                                                                        local files = list_f90_files(src_dir)
                                                                        if #files == 0 then
                                                                            print("Error: no .f90 files found in " .. src_dir)
                                                                            return
                                                                            end

                                                                            -- Build file list
                                                                            local file_list = ""
                                                                            for _, f in ipairs(files) do
                                                                                file_list = file_list .. '"' .. src_dir .. '\\' .. f .. '" '
                                                                                end

                                                                                compile_cmd = 'set "PATH=' .. LOCAL_PATH .. '" & gfortran ' .. file_list .. ' -o "' .. out .. '"'

                                                                                else
                                                                                    -- Linux/macOS: wildcard expansion works
                                                                                    compile_cmd = 'PATH="' .. LOCAL_PATH .. '" gfortran ' .. src_dir .. '/*.f90 -o ' .. out
                                                                                    end

                                                                                    os.execute(compile_cmd)

                                                                                    print("Build complete → " .. out)
                                                                                    return
                                                                                    end


                                                                                    ------------------------------------------------------------------------------------------------------
                                                                                    -- Command: run <project>
                                                                                    ------------------------------------------------------------
                                                                                    if cmd == "run" then
                                                                                        local name = arg[2]
                                                                                        if not name then
                                                                                            print("Usage: gf run <project>")
                                                                                            return
                                                                                            end

                                                                                            -- Build executable path
                                                                                            local exe = name .. "/build/app"
                                                                                            if is_windows then
                                                                                                exe = name .. "\\build\\app.exe"   -- Windows path
                                                                                                end

                                                                                                -- Check if executable exists
                                                                                                local f = io.open(exe, "rb")
                                                                                                if not f then
                                                                                                    print("Error: executable not found:", exe)
                                                                                                    print("Hint: run 'gf build " .. name .. "' first")
                                                                                                    return
                                                                                                    end
                                                                                                    f:close()

                                                                                                    print("Running:", exe)

                                                                                                    -- Execute
                                                                                                    local run_cmd
                                                                                                    if is_windows then
                                                                                                        run_cmd = '."' .. "\\" .. exe .. '"'   -- .\hello2\build\app.exe
                                                                                                        else
                                                                                                            run_cmd = "./" .. exe
                                                                                                            end

                                                                                                            os.execute(run_cmd)
                                                                                                            return
                                                                                                            end


                                                                                                            ------------------------------------------------------------
                                                                                                            -- Command: clean <project>
                                                                                                            ------------------------------------------------------------
                                                                                                            if cmd == "clean" then
                                                                                                                local name = arg[2]
                                                                                                                if not name then
                                                                                                                    print("Usage: gf clean <project>")
                                                                                                                    return
                                                                                                                    end

                                                                                                                    local build_dir = name .. (is_windows and "\\build" or "/build")

                                                                                                                    print("Cleaning project:", name)

                                                                                                                    -- Remove build directory
                                                                                                                    if is_windows then
                                                                                                                        os.execute('rmdir /S /Q "' .. build_dir .. '"')
                                                                                                                        os.execute('mkdir "' .. build_dir .. '"')
                                                                                                                        else
                                                                                                                            os.execute('rm -rf "' .. build_dir .. '"')
                                                                                                                            os.execute('mkdir -p "' .. build_dir .. '"')
                                                                                                                            end

                                                                                                                            print("Clean complete → " .. build_dir)
                                                                                                                            return
                                                                                                                            end


