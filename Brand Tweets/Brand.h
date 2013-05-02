//
//  Brand.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brand : NSObject {
    NSMutableArray *_tweets;
}

@property (nonatomic, retain) NSMutableArray *tweets;

@end
