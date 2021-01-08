-- Aesthetics
moduleName = "Project Galactic System State Managing Hub"
authorName = "GenElectrovise"
luaVersion = "53"
githubLink = "https://github.com/GenElectrovise/Project-Galactic"

-- Functional
doIntroText = true
live = false
database = "ssmhub.database"

-- UTIL =============================================================================
-- Functions to do the "heavy lifting": Utilities

-- Print a table because noone else has a good way
function outputTable(table)
  local count = 0
  for i in pairs(table) do
    message = "{" .. arguments[i] .. "}"
    print(message, false)
  end
end

-- Is the string empty
function isEmpty(s)
  return s == nil or s == ''
end

-- Get the arguments for the program
function readProgramArguments()
  arguments = {"no_command", "no_arg1", "no_arg3"}

  arg1 = arg[1]
  arg2 = arg[2]
  arg3 = arg[3]

  if not isEmpty(arg1) then
    arguments[1] = arg1
  end

  if not isEmpty(arg2) then
    arguments[2] = arg2
  end

  if not isEmpty(arg3) then
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

function illegalCommand()
  return("Illegal command - Use 'help' for a list of commands")
end

function success(message) 
  return "SUCCESS: " .. message
end

function abnormal(message)
  return "ABNORMAL: " .. message
end

-- CORE =============================================================================
-- Functions to process commands and operations

-- Table -> String (regex '|', end-line '#')
function deserialiseEntry(string)
  local foundSeperators = 0
  local entry = {}

  string:gsub(".", function(char)

      if char == "#" then
        return entry
      elseif char == "|" then
        foundSeperators = foundSeperators + 1
        goto continue
      else
        entry[foundSeperators + 1] = entry[foundSeperators + 1] .. char
      end

      ::continue::
    end)

  return entry
end

-- String -> Table
function serialiseEntry(entry)
  return entry[1] .. "|" .. entry[2] .. "#"
end

-- COMMAND ==========================================================================
-- Functions to recieve commands
-- 1 is success, others failure

function commandSystem()
  if arguments[2] == "no_arg1" then
    return 2,abnormal("The 'system' command must have at least two arguments: [add, remove, query] <system_name>")
  end
  if arguments[3] == "no_arg" then
    return 2,abnormal("The 'system' command must have at least two arguments: [add, remove, query] <system_name>")
  end
end

-- Database command
function commandDatabase()

  if arguments[2] == "no_arg1" then
    return 2,abnormal("The 'database' command must have at least one argument: [generate, wipe, dump, delete, get <system_name>]")

    -- Generate
  elseif arguments[2] == "generate" then
    local file = io.open(database, "w+")
    file:write("#ssmhub database")
    file:close(file)
    return 1, success("Generated database file at: " .. database)

    -- Dump
  elseif arguments[2] == "dump" then
    print("= DUMP START =")
    for line in io.lines(database) do
      print(line)
    end
    print("= DUMP  END  =")
    return 1, success("Dump successful")

  elseif arguments[2] == "delete" then

    x,message,code = os.remove(database)

    if code == nil then return 1,success(database .. " deleted") end

    return code,abnormal(message)

    -- Get
  elseif arguments[2] == "get" then

    -- 2+
    if isEmpty(arguments[3]) then
      return 0, abnormal("The 'database get' command must have a <name> parameter")
      -- 2-

      -- 3+
    else
      local file = io.open(database, "r")

      -- 4+
      for line in io.lines(file) do
        local state = ""
        local id = ""
        local dividersFound = 0

        -- 5+
        line:gsub(".", function(char)

            -- 6+
            if char == "|" then

              -- 7+
              if dividersFound == 0 then
                state = state .. char
                -- 7-
              end

              -- 8+
              if dividersFound == 1 then
                id = id .. char
              end

              -- 8-
              dividersFound = dividersFound + 1

              -- 6-
            end

            -- 5-
          end)

        io.close(file)

        -- 4-
      end

      -- 3-
    end

    -- 9+
  else 
    return 0, illegalCommand()
    -- 9-
  end

  -- 2-
end

-- Help command
function commandHelp()
  print("\n == COMMANDS ==")

  print("\nsystem [add <name, state>, remove <name>, query <name>] - manages the list of available systems.")
  print(" ~ 'add <name> <state>' - adds a system with the given 'name' and 'state'.")
  print(" ~ 'remove <name>' - removes the system with the given 'name'.")
  print(" ~ 'query <name>' - shows the state of the system with the given 'name'.")

  print("\nset <name> <state> <push> - sets the 'state' of the system with the given 'name'. 'push' determines whether the change is sent to the system (see 'push' command).")

  print("\npush <name> <state> - pushes the state of the system with the given 'name' to the system.")

  print("\ndeploy - pushes all states (see 'push' command).")

  print("\ndatabase [generate, dump, delete, get] <name> - works with the file system database.")
  print(" ~ generate - makes a new clean database. Wipes the current one if it exists.")
  print(" ~ dump - dumps the contents of the database to the computer print.")
  print(" ~ get <name> - retrieves the system whose 'name' is specified's database entry.")

  print("\nrefresh - reads the file system database into this program's memory")

  print("\nhelp - shows this dialogue.")

  print("\n == END COMMANDS ==\n")

  return 1, success("Lent a helping hand")
end

-- System command
function commandSystem()

  return 1,success("COMMAND SYSTEM DONE")
end

-- Main
function main()
  arguments = readProgramArguments()

  commandArgument = arguments[1]

  exitCode = 0
  message = "No message recieved from command"

  -- Check commands
  if commandArgument == "no_command" or isEmpty(arguments[1]) then
    illegalCommand(commandArgument)

  elseif commandArgument == "system" then
    exitCode,message = commandSystem()

  elseif commandArgument == "database" then
    exitCode,message = commandDatabase()

  elseif commandArgument == "help" then
    exitCode,message = commandHelp()

  else
    message = illegalCommand(commandArgument)
  end

  print("Exit Code " .. exitCode .. " - " .. message)
end main()


