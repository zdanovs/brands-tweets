//
//  ChoosenTweetViewController.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 11.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChoosenTweetViewController.h"
#import "ChoosenTweet.h"

@implementation ChoosenTweetViewController {
    NSMutableData *receivedData;
    NSString *name4S;
    CGFloat height;
}

- (id)initWithTweet:(ChoosenTweet *)tweet {
    self = [super init];
    if (self) {
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 260, 20)];
        name.backgroundColor = [UIColor clearColor];
        name.textColor = [UIColor whiteColor];
        name.text = [NSString stringWithFormat:@"@%@", tweet.screenName];

        NSString *receivedDate = [self parseDate:tweet.date];

        UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(80, 50, 260, 20)];
        date.backgroundColor = [UIColor whiteColor];
        date.text = receivedDate;
        date.backgroundColor = [UIColor clearColor];
        date.textColor = [UIColor whiteColor];
        date.font = [UIFont italicSystemFontOfSize:12.0f];

        // Get the text so we can measure it
        NSString *textS = tweet.text;
        // Get a CGSize for the width and, effectively, unlimited height
        CGSize constraint = CGSizeMake(270, 20000.0f);
        // Get the size of the text given the CGSize we just made as a constraint
        CGSize size = [textS sizeWithFont:[UIFont systemFontOfSize:18.0] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        // Get the height of our measurement, with a minimum of 44 (standard cell size)
        height = MAX(size.height, 44.0f);

        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(25, 143, 270, height)];
        [text setLineBreakMode:UILineBreakModeWordWrap];
        [text setMinimumFontSize:18.0];
        [text setNumberOfLines:0];
        [text setFont:[UIFont systemFontOfSize:18.0]];
        text.backgroundColor = [UIColor clearColor];
        text.textColor = [UIColor whiteColor];
        text.text = tweet.text;
        name4S = [NSString stringWithFormat:@"%@", tweet.screenName];


        NSLog(@"%@", tweet.image);

        NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", tweet.image]]];

        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

        if (theConnection) {
            receivedData = [NSMutableData data];
        }

        [self.view addSubview:name];
        [self.view addSubview:date];
        [self.view addSubview:text];

        NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
        NSMutableString *fullString = [[NSMutableString alloc] init];
        [fullString setString:tileDirectory];
        [fullString setString:[fullString stringByAppendingString:@"/bkg.png"]];
        UIColor *background = [[UIColor alloc] initWithPatternImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
        self.view.backgroundColor = background;
    }
    return self;
}

- (void)loadView {
    [super loadView];

    NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
    NSMutableString *fullString = [[NSMutableString alloc] init];
    [fullString setString:tileDirectory];
    [fullString setString:[fullString stringByAppendingString:@"/bubbleUp.png"]];
    UIImageView *bubbleUp = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 300, 70)];
    [bubbleUp setImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
    [self.view addSubview:bubbleUp];

    if (height > 44.0) {
        [self loadMiddle];
    }

    [self loadBottom];
}

- (void)loadMiddle {
    NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
    NSMutableString *fullString = [[NSMutableString alloc] init];
    [fullString setString:tileDirectory];
    [fullString setString:[fullString stringByAppendingString:@"/bubbleMiddle.png"]];
    UIImageView *bubbleMiddle = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, 300, height - 44)];
    [bubbleMiddle setImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
    [self.view addSubview:bubbleMiddle];
}

- (void)loadBottom {
    NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
    NSMutableString *fullString = [[NSMutableString alloc] init];
    [fullString setString:tileDirectory];
    [fullString setString:[fullString stringByAppendingString:@"/bubbleDown.png"]];
    UIImageView *bubbleDown = [[UIImageView alloc] initWithFrame:CGRectMake(10, 143 + height - 17, 300, 42)];
    [bubbleDown setImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
    [self.view addSubview:bubbleDown];
}

- (NSString *)parseDate:(NSString *)inStrDate {
    NSLog(@"%@", inStrDate);

    NSString *ordinal, *month, *lastDigit;
    month = [inStrDate substringWithRange:NSMakeRange(8, 2)];
    lastDigit = [month substringFromIndex:([month length] - 1)];

    if ([month isEqualToString:@"11"] || [month isEqualToString:@"12"] || [month isEqualToString:@"13"]) {
        ordinal = @"th";
    } else if ([lastDigit isEqualToString:@"1"]) {
        ordinal = @"st";
    } else if ([lastDigit isEqualToString:@"2"]) {
        ordinal = @"nd";
    } else if ([lastDigit isEqualToString:@"3"]) {
        ordinal = @"rd";
    } else {
        ordinal = @"th";
    }

    inStrDate = [NSString stringWithFormat:@"%@%@ %@ %@ %@",
                                           [inStrDate substringWithRange:NSMakeRange(8, 2)],
                                           ordinal,
                                           [inStrDate substringWithRange:NSMakeRange(4, 3)],
                                           [inStrDate substringWithRange:NSMakeRange(26, 4)],
                                           [inStrDate substringWithRange:NSMakeRange(11, 8)]];
    NSLog(@"%@", inStrDate);

    return inStrDate;
}
#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
            [error localizedDescription],
            [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Succeeded! Received %d bytes of data", [receivedData length]);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.JPG", name4S]];

    [receivedData writeToFile:documentsPath atomically:YES];


    UIImageView *statusBar = [[UIImageView alloc] init];
    statusBar.frame = CGRectMake(20, 20, 48, 48);
    [statusBar setImage:[[UIImage alloc] initWithContentsOfFile:documentsPath]];
    [self.view addSubview:statusBar];
}

@end
