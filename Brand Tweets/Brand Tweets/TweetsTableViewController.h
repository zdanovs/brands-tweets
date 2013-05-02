//
//  TweetsTableViewController.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class Brand;
@class TwitterController;

@interface TweetsTableViewController : UITableViewController <MBProgressHUDDelegate> {
	MBProgressHUD *HUD;
    Brand *_brand;
    TwitterController *twitterController;
}

@property (nonatomic, retain) Brand *brand;
@property (nonatomic, retain) TwitterController *twitterController;

- (id) initWithStyle:(UITableViewStyle)style category:(NSString *)category brand:(NSString *)brandName;

@end
