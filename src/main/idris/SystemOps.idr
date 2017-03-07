module SystemOps

-- ALternative: http://stackoverflow.com/a/28971647
export
system : String  -> IO Int
system   command = foreign FFI_C "system" (String -> IO Int) (command)

export
mkdir : String  -> IO Int
mkdir   path    =  system ("mkdir -p \"" ++ path ++ "\"")
-- mkdir   path      mode =  foreign FFI_C "mkdir" (String -> Int -> IO Int) path mode

-- export
-- chdir : String -> IO Int
-- chdir   path   =  foreign FFI_C "chdir" (String -> IO Int) path

export
getenv : String -> IO String
getenv   name   =  foreign FFI_C "getenv" (String -> IO String) name

export
wget : String -> String     -> IO Int
wget   url       targetFile =  system ("curl -o " ++ targetFile ++ " -L " ++ url)

export
rm : String -> IO Int
rm   path   =  foreign FFI_C "remove" (String -> IO Int) path


