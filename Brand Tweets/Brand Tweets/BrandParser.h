//
//  BrandParser.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Brand;

@interface BrandParser : NSObject {
    
}

- (Brand *)loadBrand:(NSString *)brandName inCategory:(NSString *)category;

@end
