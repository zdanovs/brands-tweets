//
//  BrandsTableViewController.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class TweetsTableViewController;

@interface BrandsTableViewController : UITableViewController <NSURLConnectionDelegate, MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    TweetsTableViewController *tweetsTVC;
    NSString *brandsCategory;
}

@property (nonatomic, retain) TweetsTableViewController *tweetsTVC;
@property (nonatomic, retain) NSString *brandsCategory;
@property int itemsInBrand;

- (void) downloadXML:(NSString *)brand;
- (id) initWithStyle:(UITableViewStyle)style category:(NSString *)category rows:(int)rows;

@end
