module Main

import IdrisInvoke

partial
main : IO ()
main = do Idris "--version"
          pure ()

