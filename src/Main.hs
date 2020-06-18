{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

import Data.Monoid (mconcat)
import Data.Text.Lazy (Text)
 

getWebpage :: ActionM Text
getWebpage = do
    return "<h1>Scotty!</h1>"

main :: IO ()
main = scotty 3000 $
    get "/" $ do
        page <- getWebpage
        html page