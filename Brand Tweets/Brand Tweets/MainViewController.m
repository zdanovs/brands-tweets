//
//  MainViewController.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "BrandsTableViewController.h"

@implementation MainViewController {
    NSString *category;
    int rows;
}

@synthesize brandsTVC;

- (id)init {
    self = [super init];

    if (self) {
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bkg.png"]];
        self.view.backgroundColor = background;

        self.title = @"Kategorijas";

        UIImage *NavigationPortraitBackground = [[UIImage imageNamed:@"navBkg"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];

        [[UINavigationBar appearance] setBackgroundImage:NavigationPortraitBackground
                                           forBarMetrics:UIBarMetricsDefault];

        UIImage *buttonBack24 = [[UIImage imageNamed:@"backBtn"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    }

    return self;
}

- (void)loadView {
    [super loadView];

    UIButton *cafe = [[UIButton alloc] init];
    cafe = [UIButton buttonWithType:UIButtonTypeCustom];
    cafe.frame = CGRectMake(64, 70, 64, 74);
    [cafe setTitle:@"Kafejnīcas" forState:UIControlStateNormal];
    [cafe addTarget:self action:@selector(showTweets:) forControlEvents:UIControlEventTouchUpInside];
    cafe.tag = 1;
    UIImage *cafeImage = [UIImage imageNamed:@"cafe.png"];
    [cafe setImage:cafeImage forState:UIControlStateNormal];
    UILabel *cafeLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 160, 40)];
    cafeLabel.text = @"Kafejnīcas";
    cafeLabel.textColor = [UIColor whiteColor];
    cafeLabel.backgroundColor = [UIColor clearColor];
    cafeLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cafeLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:cafeLabel];
    [self.view addSubview:cafe];

    UIButton *shop = [[UIButton alloc] init];
    shop = [UIButton buttonWithType:UIButtonTypeCustom];
    shop.frame = CGRectMake(192, 70, 70, 71);
    [shop setTitle:@"Produktu veikali" forState:UIControlStateNormal];
    [shop addTarget:self action:@selector(showTweets:) forControlEvents:UIControlEventTouchUpInside];
    shop.tag = 2;
    [shop setImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
    UILabel *shopLabel = [[UILabel alloc] initWithFrame:CGRectMake(190, 150, 160, 40)];
    shopLabel.numberOfLines = 0;
    shopLabel.text = @"Produktu\n  veikali";
    shopLabel.textColor = [UIColor whiteColor];
    shopLabel.backgroundColor = [UIColor clearColor];
    shopLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    shopLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:shopLabel];
    [self.view addSubview:shop];

    UIButton *cinema = [[UIButton alloc] init];
    cinema = [UIButton buttonWithType:UIButtonTypeCustom];
    cinema.frame = CGRectMake(64, 248, 64, 65);
    [cinema setTitle:@"Kinoteātri" forState:UIControlStateNormal];
    [cinema addTarget:self action:@selector(showTweets:) forControlEvents:UIControlEventTouchUpInside];
    cinema.tag = 3;
    [cinema setImage:[UIImage imageNamed:@"cinema.png"] forState:UIControlStateNormal];
    UILabel *cinemaLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 320, 160, 40)];
    cinemaLabel.text = @"Kinoteātri";
    cinemaLabel.textColor = [UIColor whiteColor];
    cinemaLabel.backgroundColor = [UIColor clearColor];
    cinemaLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    cinemaLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:cinemaLabel];
    [self.view addSubview:cinema];

    UIButton *beer = [[UIButton alloc] init];
    beer = [UIButton buttonWithType:UIButtonTypeCustom];
    beer.frame = CGRectMake(200, 244, 55, 68);
    [beer setTitle:@"Alus bruvētāji" forState:UIControlStateNormal];
    [beer addTarget:self action:@selector(showTweets:) forControlEvents:UIControlEventTouchUpInside];
    beer.tag = 4;
    [beer setImage:[UIImage imageNamed:@"beer.png"] forState:UIControlStateNormal];
    UILabel *beerLabel = [[UILabel alloc] initWithFrame:CGRectMake(195, 320, 160, 40)];
    beerLabel.numberOfLines = 0;
    beerLabel.text = @"   Alus\nbrūvētāji";
    beerLabel.textColor = [UIColor whiteColor];
    beerLabel.backgroundColor = [UIColor clearColor];
    beerLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    beerLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.view addSubview:beerLabel];
    [self.view addSubview:beer];
}

- (void)showTweets:(id)sender {
    UIButton *button = (UIButton *) sender;
    switch (button.tag) {
        case 1:
            category = @"cafe";
            rows = 8;
            break;
        case 2:
            category = @"shop";
            rows = 7;
            break;
        case 3:
            category = @"cinema";
            rows = 5;
            break;
        case 4:
            category = @"beer";
            rows = 10;
            break;
        default:
            break;
    }
    brandsTVC = [[BrandsTableViewController alloc] initWithStyle:UITableViewStylePlain category:category rows:rows];
    [self.navigationController pushViewController:brandsTVC animated:YES];
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
