{-# LANGUAGE OverloadedStrings #-}
module HtmlWebpage where

import Web.Scotty (ActionM)

import Control.Monad.IO.Class (liftIO)
import Data.Text.Lazy (Text)
import Data.Text.Lazy.Encoding (decodeUtf8)
import qualified Data.ByteString.Lazy as BS (readFile)

getWebpage :: ActionM Text
getWebpage = do
    content <- liftIO $ BS.readFile "html/index.html"
    return $ decodeUtf8 content
