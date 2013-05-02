//
//  Tweet.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (nonatomic, copy) NSString *tweet_id;
@property (nonatomic, copy) NSString *user;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *text;

- (id)initWithName:(NSString *)tweet_id user:(NSString *)user date:(NSString *)date text:(NSString *)text;

@end
