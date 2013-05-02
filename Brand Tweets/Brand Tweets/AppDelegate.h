//
//  AppDelegate.h
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
    MainViewController *viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;
@property (nonatomic, retain) MainViewController *viewController;

@end
