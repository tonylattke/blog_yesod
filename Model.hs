{-# LANGUAGE FlexibleInstances #-}

module Model where

import Yesod
import Data.Text (Text)
import Database.Persist.Quasi
import Data.Typeable (Typeable)
import Prelude
import Data.Time

-- You can define all of your database entities in the entities file.
-- You can find more information on persistent and how to declare entities
-- at:
-- http://www.yesodweb.com/book/persistent/
share [mkPersist sqlOnlySettings, mkMigrate "migrateAll"]
    $(persistFileWith lowerCaseSettings "config/models")


-- { "id": 1, "name": "A name of the post", "text": "The content" , "date" : "YYYY-MM-DDTHH:MM:SS.SSSS"}
instance ToJSON (Entity Post) where
    toJSON (Entity pid p) = object
        [ "id"   .= (String $ toPathPiece pid)
        , "name" .= postName p
        , "text" .= postText p
        , "date" .= postDate p
        ]

-- { "id": 1, "post_id": 1, "text": "The comment content" }
instance ToJSON (Entity Comment) where
    toJSON (Entity cid c) = object
        [ "id"      .= (String $ toPathPiece cid)
        , "post_id" .= (String $ toPathPiece $ commentPost c)
        , "name" .= commentName c
        , "text" .= commentText c
        , "date" .= commentDate c
        ]