{-# LANGUAGE OverloadedStrings #-}
module Main where

import qualified Network.Wai as Wai
import qualified Network.Wai.Handler.WebSockets as WaiWs
import qualified Network.Wai.Handler.Warp as Warp
import qualified Network.WebSockets as WS

import System.Environment (lookupEnv)

import Data.Maybe (fromMaybe)

import Webserver
import ChatServer

-- could change this to Wai's Port type
getPort :: IO Int
getPort = do
    mPort <- lookupEnv "PORT"
    return $ fromMaybe 3000 (read <$> mPort)

main :: IO ()
main = do 
    port <- getPort
    let settings = Warp.setPort port Warp.defaultSettings
    wsapp <- serverApp
    sapp <- scottyApplication
    Warp.runSettings settings $ WaiWs.websocketsOr WS.defaultConnectionOptions wsapp sapp