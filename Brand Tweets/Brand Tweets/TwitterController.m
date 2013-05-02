//
//  AppController.m
//  MGTwitterEngine
//
//  Created by Matt Gemmell on 10/02/2008.
//  Copyright 2008 Instinctive Code.
//

#import "TwitterController.h"
#import "ChoosenTweet.h"
#import "ChoosenTweetViewController.h"

@implementation TwitterController

@synthesize navigationController;

- (void)startTwitter
{
    navigationController = [[UINavigationController alloc] init];
    // Put your Twitter username and password here:
    NSString *username = @"a_zdanovs";
    NSString *consumerKey = @"MQ6ntfD6ueLBmGDDSl1wHA";
    NSString *consumerSecret = @"oJU2vau6gSc11OlRzlIeaoLoYg3i47jg4wkmoE6sLc";
    
    // Create a TwitterEngine and set our login details.
    twitterEngine = [[MGTwitterEngine alloc] initWithDelegate:self];
    [twitterEngine setUsesSecureConnection:NO];
    [twitterEngine setConsumerKey:consumerKey secret:consumerSecret];
    [twitterEngine setUsername:username];
    
    token = [[OAToken alloc] initWithKey:@"381352528-QXXFyC0XaQSn2VpcUsna0oaNbsRplFU2deEdsGCW"
                                  secret:@"Wr9KgMzWwaGNnzngwfsooxz1S84iWQrf3RUuXfjuVs"];
    [twitterEngine setAccessToken:token];
}

- (void)getInfoByTweetID:(NSString *)tweetID toNavController:(UINavigationController *)navController withProgress:(MBProgressHUD *)HUD
{
    receivedHUD = [[MBProgressHUD alloc] init];
    receivedHUD = HUD;
    navigationController = navController;
    unsigned long long ullvalue = strtoull([tweetID UTF8String], NULL, 0);
    [twitterEngine getUpdate:ullvalue];
}

- (void)dealloc
{
}


#pragma mark MGTwitterEngineDelegate methods


- (void)requestSucceeded:(NSString *)connectionIdentifier
{
    NSLog(@"Request succeeded for connectionIdentifier = %@", connectionIdentifier);
}


- (void)requestFailed:(NSString *)connectionIdentifier withError:(NSError *)error
{
    NSLog(@"Request failed for connectionIdentifier = %@, error = %@ (%@)", 
          connectionIdentifier, 
          [error localizedDescription], 
          [error userInfo]);
}


- (void)statusesReceived:(NSArray *)statuses forRequest:(NSString *)connectionIdentifier
{
//    NSLog(@"Got statuses for %@:\r%@", connectionIdentifier, statuses);
    ChoosenTweet *tweet = [[ChoosenTweet alloc] init];
    for(NSDictionary *tweetDict in statuses) {
        NSString *screenName = [[tweetDict objectForKey:@"user"] objectForKey:@"screen_name"];
        UIImage *image = [[tweetDict objectForKey:@"user"] objectForKey:@"profile_image_url"];
        NSString *text = [tweetDict objectForKey:@"text"];
        NSString *date = [tweetDict objectForKey:@"created_at"];
        tweet.screenName = screenName;
        tweet.text = text;
        tweet.date = date;
        tweet.image = image;
//        [self.tweets addObject:tweet];
    }
    ChoosenTweetViewController *vc = [[ChoosenTweetViewController alloc] initWithTweet:tweet];
    
    [navigationController pushViewController:vc animated:YES];
    [receivedHUD hide:YES afterDelay:0.1];
}


- (void)directMessagesReceived:(NSArray *)messages forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got direct messages for %@:\r%@", connectionIdentifier, messages);
}


- (void)userInfoReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user info for %@:\r%@", connectionIdentifier, userInfo);
}


- (void)miscInfoReceived:(NSArray *)miscInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got misc info for %@:\r%@", connectionIdentifier, miscInfo);
}


- (void)searchResultsReceived:(NSArray *)searchResults forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got search results for %@:\r%@", connectionIdentifier, searchResults);
}


- (void)socialGraphInfoReceived:(NSArray *)socialGraphInfo forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Got social graph results for %@:\r%@", connectionIdentifier, socialGraphInfo);
}

- (void)userListsReceived:(NSArray *)userInfo forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got user lists for %@:\r%@", connectionIdentifier, userInfo);
}

- (void)imageReceived:(UIImage *)image forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got an image for %@: %@", connectionIdentifier, image);
    
    // Save image to the Desktop.
//    NSString *path = [[NSString stringWithFormat:@"~/Desktop/%@.tiff", connectionIdentifier] stringByExpandingTildeInPath];
//    [[image TIFFRepresentation] writeToFile:path atomically:NO];
}

- (void)connectionFinished:(NSString *)connectionIdentifier
{
    NSLog(@"Connection finished %@", connectionIdentifier);

//	if ([twitterEngine numberOfConnections] == 0)
//	{
//		[NSApp terminate:self];
//	}
}

- (void)accessTokenReceived:(OAToken *)aToken forRequest:(NSString *)connectionIdentifier
{
	NSLog(@"Access token received! %@",aToken);

//	[self getInfoByTweetID:tweetID];
}

#if YAJL_AVAILABLE || TOUCHJSON_AVAILABLE

- (void)receivedObject:(NSDictionary *)dictionary forRequest:(NSString *)connectionIdentifier
{
    NSLog(@"Got an object for %@: %@", connectionIdentifier, dictionary);
}

#endif

@end
