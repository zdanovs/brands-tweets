//
//  Brand.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Brand.h"

@implementation Brand
@synthesize tweets = _tweets;

- (id)init {
    
    if ((self = [super init])) {
        self.tweets = [[NSMutableArray alloc] init];
    }
    return self;
    
}

- (void) dealloc {
    self.tweets = nil;
}

@end