
-- Aesthetics
moduleName = "Project Galactic System State Managing Hub"
authorName = "GenElectrovise"
luaVersion = "53"
githubLink = "https://github.com/GenElectrovise/Project-Galactic"

-- Functional
doIntroText = true
live = false
database = "data/ssmhub.database"

-- UTIL =============================================================================
-- Functions to do the "heavy lifting": Utilities

-- Print a table because noone else has a good way
function outputTable(table)
  local count = 0
  for i in pairs(table) do
    message = "{" .. arguments[i] .. "}"
    console(message, false)
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

function console(msg, appendLine)
  if appendLine == true then msg = msg .. "\n" end
  io.write(msg)
end

function illegalCommand(commandName)
  console("Illegal command - Use 'help' for a list of commands")
end

-- CORE =============================================================================
-- Functions to process commands and operations

function queryDatabase_getState(name)
  file = io.open(database, "r")
  
  for line in file:lines() do
    
  end
  
end

-- COMMAND ==========================================================================
-- Functions to recieve commands

-- Database command
function commandDatabase()
  if arguments[2] == "no_arg1" then
    console("The 'database' command must have at least one argument: [generate, wipe, dump, delete, get <system_name>]", true)
    return 1
  else
    print("Success")
  end
end

-- Help command
function commandHelp()
  console("\n == COMMANDS ==", true)

  console("\nsystem [add <name, state>, remove <name>, query <name>] - manages the list of available systems.", true)
  console(" ~ 'add <name> <state>' - adds a system with the given 'name' and 'state'.", true)
  console(" ~ 'remove <name>' - removes the system with the given 'name'.", true)
  console(" ~ 'query <name>' - shows the state of the system with the given 'name'.", true)

  console("\nset <name> <state> <push> - sets the 'state' of the system with the given 'name'. 'push' determines whether the change is sent to the system (see 'push' command).", true)

  console("\npush <name> <state> - pushes the state of the system with the given 'name' to the system.", true)

  console("\ndeploy - pushes all states (see 'push' command).", true)

  console("\ndatabase [generate, wipe, dump, delete, get] <name> - works with the file system database.", true)
  console(" ~ generate - remakes the database if it doesn't already exist", true)
  console(" ~ wipe - wipes all data in the database files.", true)
  console(" ~ dump - dumps the contents of the database to the computer console.", true)
  console(" ~ delete - deletes the database, including files.", true)
  console(" ~ get <name> - retrieves the system whose 'name' is specified's database entry.", true)

  console("\nrefresh - reads the file system database into this program's memory", true)

  console("\nhelp - shows this dialogue.", true)

  console("\n == END COMMANDS ==\n", true)

  return 1
end

-- System command
function commandSystem()

  return 1
end

-- Main
function main()
  arguments = readProgramArguments()

  commandArgument = arguments[1]

  commandCompleteCode = 0

  -- Check commands
  if commandArgument == "no_command" or isEmpty(arguments[1]) then
    illegalCommand(commandArgument)

  elseif commandArgument == "system" then
    commandCompleteCode = commandSystem()

  elseif commandArgument == "database" then
    commandCompleteCode = commandDatabase()

  elseif commandArgument == "help" then
    commandCompleteCode = commandHelp()

  else
    illegalCommand(commandName)
  end
end main()






































