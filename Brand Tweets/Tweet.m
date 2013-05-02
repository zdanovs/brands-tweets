//
//  Tweet.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
@synthesize tweet_id = _tweet_id;
@synthesize user = _user;
@synthesize date = _date;
@synthesize text = _text;

- (id)initWithName:(NSString *)tweet_id user:(NSString *)user date:(NSString *)date text:(NSString *)text{
    
    if ((self = [super init])) {
        self.tweet_id = tweet_id;
        self.user = user;
        self.date = date;
        self.text = text;
    }    
    return self;
    
}

- (void) dealloc {
    self.tweet_id = nil;    
}

@end
