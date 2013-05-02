//
//  choosenTweet.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 11.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoosenTweet : NSObject {
    NSString *screenName;
    NSString *text;
    NSString *date;
    UIImage *image;
}
@property (nonatomic, retain) NSString *screenName;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) UIImage *image;

@end
