{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import

getHomeR :: Handler Html
getHomeR = do
    --(formWidget, formEnctype) <- generateFormPost sampleForm
    --let submission = Nothing :: Maybe (FileInfo, Text)
    --    handlerName = "getHomeR" :: Text
    posts <- runDB $ selectList [] [Desc PostDate]
    defaultLayout $ do
        aDomId <- newIdent
        setTitle ""
        $(widgetFile "homepage")

getYearR :: Integer -> Handler Html
getYearR year = do
    allPosts <- runDB $ selectList [] [Desc PostDate]
    let posts = allPosts
    defaultLayout $ do
        aDomId <- newIdent
        setTitle "Blog"
        $(widgetFile "homepage")