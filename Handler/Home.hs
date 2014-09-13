{-# LANGUAGE TupleSections, OverloadedStrings #-}
module Handler.Home where

import Import

-- import Prelude (head,last)
import Data.Time

getHomeR :: Handler Html
getHomeR = do
    posts <- runDB $ selectList [] [Desc PostDate]
    -- last_day <- fmap utctDay (postDate $ head posts)
    -- let (last_year, _, _) = toGregorian last_day
    -- first_day <- fmap utctDay (postDate $ last posts)
    -- let (first_year, _, _) = toGregorian first_day
    defaultLayout $ do
        aDomId <- newIdent
        setTitle ""
        $(widgetFile "homepage")

getYearR :: Integer -> Handler Html
getYearR year = do
    let from_date = fromGregorian year 1 1
        to_date = fromGregorian (year+1) 1 1
        time = timeOfDayToTime $ TimeOfDay 0 0 0
    posts <- runDB $ selectList [PostDate >. UTCTime from_date time, PostDate <. UTCTime to_date time] [Desc PostDate]
    defaultLayout $ do
        aDomId <- newIdent
        setTitle $ toHtml $ ": " ++ (show year)
        $(widgetFile "homepage")