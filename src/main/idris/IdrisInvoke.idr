module IdrisInvoke

import SystemOps
import System.Info

extract : String -> IO Int
extract   file   = system ("tar -xzf " ++ file ++ " -C $(dirname " ++ file ++ ") ")

ensureIdris : String  -> IO String
ensureIdris   version =
  let IO_HOME                 = getenv "HOME"
      IO_IBT_HOME             = map (++ "/.ibt")  IO_HOME
      IO_IBT_STORE            = map (++ "/store") IO_IBT_HOME
      IO_IDRIS_INSTALLATIONS  = map (++ "/idris") IO_IBT_STORE
      target                  = "idris-" ++ os ++ "-" ++ version
      URL_ROOT                = "https://dl.bintray.com/bryghts/Idris/idris/" ++ os ++ "/" ++ version
      IO_IDRIS_HOME           = map (++ ("/" ++ target)) IO_IDRIS_INSTALLATIONS
      IO_IDRIS_EXECUTABLE     = map (++ "/bin/idris") IO_IDRIS_HOME
      IO_CAN_EXEC_IDRIS       = do IDRIS_EXECUTABLE <- IO_IDRIS_EXECUTABLE
                                   status <- system (IDRIS_EXECUTABLE ++ " --version >> /dev/null")
                                   pure (status == 0)
  in (do can                 <- IO_CAN_EXEC_IDRIS
         IDRIS_INSTALLATIONS <- IO_IDRIS_INSTALLATIONS
         IDRIS_HOME          <- IO_IDRIS_HOME
         if can then pure IDRIS_HOME
                else do mkdir IDRIS_INSTALLATIONS
                        PACKAGE_NAME <- pure (target ++ ".tar.gz")
                        FULL_URL     <- pure (URL_ROOT ++ "/" ++ PACKAGE_NAME)
                        FULL_PATH    <- pure (IDRIS_INSTALLATIONS ++ "/" ++ PACKAGE_NAME)
                        wget FULL_URL FULL_PATH
                        extract FULL_PATH
                        rm FULL_PATH
                        pure IDRIS_HOME)


idris : (version: String) -> (params: String) -> IO Int
idris    version              params          =
  do idrisHome <- ensureIdris version
     system (idrisHome ++ "/bin/idris " ++ params)

idris12 : String
idris12 = "0.12.2"

idris99 : String
idris99 = "0.99"

export
Idris : String -> IO Int
Idris   params = idris idris99 params
