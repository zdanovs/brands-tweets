//
//  TweetsTableViewController.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TweetsTableViewController.h"
#import "Tweet.h"
#import "Brand.h"
#import "BrandParser.h"
#import "TwitterController.h"

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


@implementation TweetsTableViewController {
    int tweetCount;
}

@synthesize brand = _brand;
@synthesize twitterController;

- (id)initWithStyle:(UITableViewStyle)style category:(NSString *)category brand:(NSString *)brandName
{
    self = [super initWithStyle:style];
    self.title = [NSString stringWithFormat:@"%@", brandName] ;
    if (self) {
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bkg.png"]];
        self.view.backgroundColor = background;
//        self.tableView.separatorColor = [UIColor clearColor];
        
        self.view.frame = CGRectMake(0, 0, 320, 460);
        self.brand = [[[BrandParser alloc] init] loadBrand:brandName inCategory:category];
        
        if (_brand != nil) {
            for (Tweet *tweet in _brand.tweets) {
                tweetCount++;
            }
        }
        
        twitterController = [[TwitterController alloc] init];
        [twitterController startTwitter];
        
        UIImage *buttonBack24 = [[UIImage imageNamed:@"backBtn"]
                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
        
        self.tableView.separatorColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"separator"]];
    }
    return self;
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetCount;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    NSMutableString *fullString = [[NSMutableString alloc] init];
    NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
    [fullString setString:tileDirectory];
    [fullString setString:[fullString stringByAppendingString:@"/bkg.png"]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
    view.backgroundColor = background;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30 * (9 - tweetCount);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    UILabel *label = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:14.0];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:14.0]];
        [label setTag:1];
        
        [[cell contentView] addSubview:label];
    }
    Tweet *tweet = [_brand.tweets objectAtIndex:[indexPath row]];
    NSString *text = tweet.text;
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    if (!label) {
        label = (UILabel*)[cell viewWithTag:1];
    }
    
    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 3), MAX(size.height, 44.0f))];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [[_brand.tweets objectAtIndex:[indexPath row]] text];
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = MAX(size.height, 44.0f);
    return height + (CELL_CONTENT_MARGIN * 2);
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Tweet *tweet = [_brand.tweets objectAtIndex:[indexPath row]];
    
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES]; 
    HUD.delegate = self;
	HUD.labelText = @"Loading"; 
    
    [twitterController getInfoByTweetID:tweet.tweet_id toNavController:self.navigationController withProgress:HUD];
    
    [HUD show:YES];
}

@end
