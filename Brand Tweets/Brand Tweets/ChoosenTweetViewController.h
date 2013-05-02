//
//  ChoosenTweetViewController.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 11.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChoosenTweet;

@interface ChoosenTweetViewController : UIViewController <NSURLConnectionDelegate>

- (id) initWithTweet:(ChoosenTweet *)tweet;
- (NSString *)parseDate:(NSString *)inStrDate;
- (void) loadBottom;
- (void) loadMiddle;

@end
