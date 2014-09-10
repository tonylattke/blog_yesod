module Handler.Post where

import Import

import Data.Maybe (fromJust)
import Data.Time (getCurrentTime)

entryForm :: Form Post
entryForm = renderDivs $ Post
	<$> areq   textField "name" Nothing
	<*> areq   textField "text" Nothing
    <*> lift (liftIO getCurrentTime)

-- Get Post

getPostR :: PostId -> Handler Html
getPostR postId = do
	post <- runDB $ get404 postId
	defaultLayout $ do
		setTitle $ toHtml $ postName post
		$(widgetFile "post/post")

-- New Post

getPostNewR :: Handler Html
getPostNewR = do
	(_, enctype) <- generateFormPost entryForm
	maybetoken <- fmap reqToken getRequest
	defaultLayout $ do
		setTitle ":New Post"
		$(widgetFile "post/new")

postPostNewR :: Handler Html
postPostNewR = do
	((res,_),enctype) <- runFormPost entryForm
	maybetoken <- fmap reqToken getRequest
	case res of 
		FormSuccess post -> do 
			postId <- runDB $ insert post
			setMessage $ toHtml $ (postName post) <> " created"
			redirect $ PostR postId 
		_ -> defaultLayout $ do
			setMessage $ "Error on the form"
			setTitle "Please correct your entry form"
			--case maybetoken of
			--	Just token -> toWidget [hamlet| <input type="hidden" name="_token" value="#{token}">|]
			--	Nothing -> toWidget [hamlet|<input type="hidden" name="_token" value="null">|]
			$(widgetFile "post/new")

-- Edit Post

getPostEditR :: PostId -> Handler Html
getPostEditR postId = do
	post <- runDB $ get404 postId
	(_, enctype) <- generateFormPost entryForm
	maybetoken <- fmap reqToken getRequest
	defaultLayout $ do
		setTitle $ toHtml $ postName post
		$(widgetFile "post/edit")

postPostEditR :: PostId -> Handler Html
postPostEditR postId = do
	name_update <- lookupPostParam "f1"
	text_update <- lookupPostParam "f2"
	_ <- runDB $ update postId [PostName =. (fromJust name_update), PostText =. (fromJust text_update)]
	defaultLayout $ do
		redirect $ PostR postId

-- Delete Post

postPostDeleteR :: PostId -> Handler Html
postPostDeleteR postId = do
	_ <- runDB $ delete postId
	defaultLayout $ do
		redirect $ HomeR