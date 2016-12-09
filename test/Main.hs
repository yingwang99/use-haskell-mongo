{-# LANGUAGE OverloadedStrings#-}
{-# LANGUAGE QuasiQuotes      #-}

module Main where

  import           MyLib (app)
  import           Test.Hspec
  import           Test.Hspec.Wai
  --import           Test.Hspec.Wai.JSON

  -- import           Network.Wai (Application)
  --import           Data.Aeson (Value(..), object, (.=))


  main :: IO ()
  main = hspec spec


  spec :: Spec
  spec = with (return app) $ do
    describe "GET /searchMessage?name=hello" $ do
      it "responds with searchMessage" $ do
        get "/searchMessage?name=hello" `shouldRespondWith` "[]" {matchStatus = 200}

    describe "GET /searchMessage?name=cassie" $ do
      it "responds with searchMessage" $ do
        get "/searchMessage?name=cassie" `shouldRespondWith` "[{\"name\":\"cassie\",\"message\":\"hello1\"}]" {matchStatus = 200}

    describe "POST /storeMessage true" $ do
      it "responds with storeMessage" $ do
        post "/storeMessage" [json|{name:"ecky", message:"mess"}|] `shouldRespondWith` "true%"
