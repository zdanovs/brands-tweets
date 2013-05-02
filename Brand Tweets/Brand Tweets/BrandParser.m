//
//  BrandParser.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandParser.h"
#import "Brand.h"
#import "Tweet.h"
#import "GDataXMLNode.h"

@implementation BrandParser {
    NSString *categoryName, *brandName;
}

- (NSString *)dataFilePath:(NSString *)brand inCategory:(NSString *)category  {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml", brand]];
    
    return documentsPath;
}

- (Brand *)loadBrand:(NSString *)curBrand inCategory:(NSString *)category {
    
    NSString *filePath = [self dataFilePath:curBrand inCategory:category];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
    if (doc == nil) { return nil; }
    
    Brand *brand = [[Brand alloc] init];
    NSArray *brandTweets = [doc.rootElement elementsForName:@"tweet"];
    for (GDataXMLElement *brandTweet in brandTweets) {
        
        // Let's fill these in!
        NSString *tweet_id, *user, *date, *text;
        
        // tweet_id
        NSArray *tweet_ids = [brandTweet elementsForName:@"tweet_id"];
        if (tweet_ids.count > 0) {
            GDataXMLElement *firstName = (GDataXMLElement *) [tweet_ids objectAtIndex:0];
            tweet_id = firstName.stringValue;
        } else continue;
        NSLog(@"%i", tweet_ids.count);
        
        // user
        NSArray *users = [brandTweet elementsForName:@"user"];
        if (users.count > 0) {
            GDataXMLElement *firstLevel = (GDataXMLElement *) [users objectAtIndex:0];
            user = firstLevel.stringValue;
        } else continue;
        
        // date
        NSArray *dates = [brandTweet elementsForName:@"date"];
        if (dates.count > 0) {
            GDataXMLElement *firstLevel = (GDataXMLElement *) [dates objectAtIndex:0];
            date = firstLevel.stringValue;
        } else continue;
        
        // text
        NSArray *texts = [brandTweet elementsForName:@"text"];
        if (texts.count > 0) {
            GDataXMLElement *firstLevel = (GDataXMLElement *) [texts objectAtIndex:0];
            text = firstLevel.stringValue;
        } else continue;
        
        Tweet *tweet = [[Tweet alloc] initWithName:tweet_id user:user date:date text:text];
        [brand.tweets addObject:tweet];
        
    }
    
    return brand;
    
}

@end
