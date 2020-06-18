{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty

import Data.Monoid (mconcat)
import Data.Text.Lazy (Text)

import Control.Monad.IO.Class (liftIO)

import qualified Data.ByteString.Lazy as BS (readFile)

import Data.Text.Lazy.Encoding (decodeUtf8)

getWebpage :: ActionM Text
getWebpage = do
    content <- liftIO $ BS.readFile "html/index.html"
    return $ decodeUtf8 content

main :: IO ()
main = scotty 3000 $
    get "/" $ do
        page <- getWebpage
        html page