{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Exception
import Network.HTTP.Client

------------------------------------------------------------------------

main :: IO ()
main = do
  manager <- newManager defaultManagerSettings

  request  <- parseRequest "http://localhost:1500"
  response <- httpLbs request manager `catch`
                (\(_ :: SomeException) -> error "posix/io/net/recv")

  -- Needs to be run through
  -- ../../.stack-work/dist/x86_64-linux/Cabal-2.4.0.1/build/... otherwise stack
  -- crashes.

  writeFile "/tmp/package.txt" (show (responseBody response))
  -- `catch` (\(_ :: SomeException) -> error "posix/io/rw/write")
