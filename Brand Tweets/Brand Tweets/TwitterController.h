//
//  AppController.h
//  MGTwitterEngine
//
//  Created by Matt Gemmell on 10/02/2008.
//  Copyright 2008 Instinctive Code.
//

#import "MGTwitterEngine.h"
#import "MBProgressHUD.h"

@class OAToken;

@interface TwitterController : NSObject <MGTwitterEngineDelegate, MBProgressHUDDelegate> {
    MBProgressHUD *receivedHUD;
    MGTwitterEngine *twitterEngine;
	OAToken *token;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
// this gets called when the OAuth token is received
-(void)startTwitter;
-(void)getInfoByTweetID:(NSString *)tweetID toNavController:(UINavigationController *)navController withProgress:(MBProgressHUD *)HUD;

@end
