{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

import HtmlWebpage
import ChatServer

main :: IO ()
main = do 
    startServer
    scotty 3000 $
        get "/" $ do
            page <- getWebpage
            html page