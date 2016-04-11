{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

import Prelude ()
import Prelude.Compat

import Data.Aeson
import Control.Monad.Except
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant
import System.Directory
import Control.Concurrent.STM.TVar (TVar, readTVarIO, modifyTVar, newTVarIO)
import Control.Monad.STM (atomically)
import qualified System.IO.Strict as Strict
import qualified Data.ByteString.Lazy.Char8 as BS

-- | 1. Hello world!

type HelloAPI = Get '[PlainText] String
hello :: String
hello = "hello world!"

-- | 2-3. Static file

type FileAPI = Get '[JSON] FileContent

newtype FileContent = FileContent String deriving Generic
instance ToJSON FileContent

-- | Update count in serialized 'FileData' instance.
-- Returns 'Nothing' if parsing of 'content' to 'FileData' instance fails.
incCount :: String -> Maybe String
incCount content = (BS.unpack . encode . inc) <$> mfd
  where mfd :: Maybe FileData
        mfd = decode $ BS.pack content
        inc :: FileData -> FileData
        inc fd = fd { count = (count fd) + 1 }

-- | Serve and update contents of file in 'path'.
-- Only updates the contents if it forms a valid JSON serialization of
-- a 'FileData' object. If it is, it increments the count field in
-- the file by 1.
fileServer :: FilePath -> Server FileAPI
fileServer path = do
  exists <- liftIO (doesFileExist path)
  if exists
     then do
          -- read contents from file (strictly, we are writing to the same file soon)
          content <- liftIO (Strict.readFile path)
          case incCount content of
            -- write if succesfully parsed and updated, do nothing otherwise
            Just content' -> liftIO (writeFile path content')
            Nothing -> return ()
          -- have webserver serve the file's contents
          return (FileContent content)
     else throwError custom404Err
  where custom404Err = err404 { errBody = "could not find file." }

data FileData = FileData {
  count :: Int,
  -- underscore to suppress 'defined but not used' warning
  name :: String
} deriving (Generic)

instance FromJSON FileData
instance ToJSON FileData

-- | In memory counter

type CounterAPI = Get '[JSON] FileData

counterServer :: TVar Int -> Server CounterAPI
counterServer counter = do
  counter' <- liftIO $ readTVarIO counter
  liftIO $ stepCounter counter
  return $ FileData counter' "count.json"

stepCounter :: TVar Int -> IO ()
stepCounter counter = liftIO $ atomically $ modifyTVar counter (+ 1)

-- | Combining components into a single API

type API = HelloAPI :<|> ("file" :> FileAPI) :<|> ("counter" :> CounterAPI)

api :: Proxy API
api = Proxy

server :: FilePath -> TVar Int -> Server API
server path counter = return hello :<|> fileServer path :<|> counterServer counter

app :: FilePath -> TVar Int -> Application
app path counter = serve api (server path counter)

main :: IO ()
main = do
  counter <- newTVarIO 0
  run 8081 (app "count.json" counter)
