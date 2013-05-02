//
//  MainViewController.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrandsTableViewController;

@interface MainViewController : UIViewController {
    BrandsTableViewController *brandsTVC;
}

@property (nonatomic, retain) BrandsTableViewController *brandsTVC;


@end
