{-# LANGUAGE OverloadedStrings#-}
{-# LANGUAGE QuasiQuotes      #-}

module Main where

  import           MyLib (app)
  import           Test.Hspec
  import           Test.Hspec.Wai
  import           Test.Hspec.Wai.JSON

  --import           Network.Wai (Application)
  --import           Data.Aeson (Value(..), object, (.=))


  main :: IO ()
  main = hspec spec


  spec :: Spec
  spec = with (return app) $ do
    describe "POST /storeMessage true" $ do
      it "responds with storeMessage" $ do
        post "/storeMessage" [json|{name:"ecky", message:"mess"}|] `shouldRespondWith` "true%"

    describe "GET /searchMessage?name=ecky" $ do
      it "responds with searchMessage" $ do
        get "/searchMessage?name=ecky1" `shouldRespondWith` "[]" {matchStatus = 200}

    describe "GET /searchMessage?name=ecky" $ do
      it "responds with searchMessage" $ do
        get "/searchMessage?name=ecky" `shouldRespondWith` "[{\"name\":\"ecky\",\"message\":\"mess\"}]" {matchStatus = 200}
