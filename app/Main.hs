
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Proxy (Proxy(..))
import Network.Wai.Handler.Warp
    (defaultSettings, runSettings, setHost, setPort)
import Servant
import Servant.Server.StaticFiles (serveDirectoryWebApp)
import System.Environment (lookupEnv)
import Text.Read (readMaybe)

type API =
    Get '[PlainText] NoContent
    :<|> Raw

server :: Server API
server =
    (throwError err302
        { errHeaders = [("Location", "/index.html")] })
    :<|> serveDirectoryWebApp "public"

main :: IO ()
main = do
    variavelPorta <- lookupEnv "PORT"

    let porta = maybe 10000
            (maybe 10000 id . readMaybe)
            variavelPorta

    let configuracao =
            setHost "0.0.0.0"
            (setPort porta defaultSettings)

    putStrLn ("Site Ranma 1/2 iniciado na porta " ++ show porta)

    runSettings configuracao
        (serve (Proxy :: Proxy API) server)
