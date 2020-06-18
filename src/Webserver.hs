{-# LANGUAGE OverloadedStrings #-}
module Webserver where

import Web.Scotty
import qualified Network.Wai as Wai

scottyApplication :: IO Wai.Application
scottyApplication = 
    scottyApp $ do
        get "/" $
            file "html/index.html"
