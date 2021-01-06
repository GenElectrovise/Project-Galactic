
-- Aesthetics
moduleName = "Project Galactic System State Managing Hub"
authorName = "GenElectrovise"
luaVersion = "53"
githubLink = "https://github.com/GenElectrovise/Project-Galactic"

-- Functional
doIntroText = true
live = false

-- UTIL =============================================================================

-- Print a table because noone else has a good way
function outputTable(table)
  local count = 0
  for i in pairs(table) do
    message = "{" .. arguments[i] .. "}"
    console(message, false)
  end
end

-- Is the string empty
local function isempty(s)
  return s == nil or s == ''
end

-- Get the arguments for the program
function readProgramArguments()
  arguments = {"no_command", "no_arg1", "no_arg3"}
  
  arg1 = arg[1]
  arg2 = arg[2]
  arg3 = arg[3]
  
  if not isempty(arg1) then 
    arguments[1] = arg1
  end
  
  if not isempty(arg2) then 
    arguments[2] = arg2
  end
  
  if not isempty(arg3) then 
    arguments[3] = arg3
  end

  return arguments
end

-- Return the length of the given table
function lengthOfTable(table)
  local count = 0
  for _ in pairs(arguments) do count = count + 1 end
  return count
end

function console(msg, appendLine)
  if appendLine == true then print(msg)
  else io.write(msg) end
end

-- CORE =============================================================================

-- Main
local function main()
  arguments = readProgramArguments()
  
  argsCount = lengthOfTable(arguments)
  
  outputTable(arguments)
end main()
