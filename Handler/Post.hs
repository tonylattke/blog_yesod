module Handler.Post where

import Import

entryForm :: Form Post
entryForm = renderDivs $ Post
	<$> areq   textField "name" Nothing
	<*> areq   textField "text" Nothing
	<*> areq   timeField "hour" Nothing
	<*> areq   dayField  "day" 	Nothing

getPostR :: PostId -> Handler RepHtml
getPostR postId = do
	post <- runDB $ get404 postId
	defaultLayout $ do
		setTitle $ toHtml $ postName post
		$(widgetFile "post/post")

getPostNewR :: Handler RepHtml
getPostNewR = do
	(postWidget, enctype) <- generateFormPost entryForm
	defaultLayout $ do
		setTitle "- Create Post"
		$(widgetFile "post/new")

postPostNewR :: Handler RepHtml
postPostNewR = do
	((res,postWidget),enctype) <- runFormPost entryForm
	case res of 
		FormSuccess post -> do 
			postId <- runDB $ insert post
			setMessage $ toHtml $ (postName post) <> " created"
			redirect $ PostR postId 
		_ -> defaultLayout $ do
			setMessage $ "Error on the form"
			setTitle "Please correct your entry form"
			$(widgetFile "post/new")