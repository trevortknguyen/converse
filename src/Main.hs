{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

import System.Environment (lookupEnv)

import Data.Maybe (fromMaybe)

import HtmlWebpage
import ChatServer

-- could change this to Wai's Port type
getPort :: IO Int
getPort = do
    mPort <- lookupEnv "PORT"
    return $ fromMaybe 3000 (read <$> mPort)

main :: IO ()
main = do 
    -- listening on the same port is not possible
    startServer 9160
    port <- getPort
    scotty port $
        get "/" $ do
            page <- getWebpage
            html page