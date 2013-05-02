//
//  BrandsTableViewController.m
//  Brand Tweets
//
//  Created by Andrej Zhdanov on 10.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BrandsTableViewController.h"
#import "TweetsTableViewController.h"

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@implementation BrandsTableViewController {
    NSArray *arrCafe, *arrShop, *arrCinema, *arrBeer, *items;
    NSMutableData *receivedData;
    NSString *categoryName, *brandName, *titleCategory;
    BOOL completed;
}

@synthesize brandsCategory;
@synthesize itemsInBrand;
@synthesize tweetsTVC;

- (id)initWithStyle:(UITableViewStyle)style category:(NSString *)category rows:(int)rows {
    self = [super initWithStyle:style];
    if ([category isEqual:@"cafe"]) {
        titleCategory = @"Kafejnīcas";
    }
    else if ([category isEqual:@"shop"]) {
        titleCategory = @"Veikali";
    }
    else if ([category isEqual:@"cinema"]) {
        titleCategory = @"Kinoteātri";
    }
    else {
        titleCategory = @"Alus bruvētāji";
    }
    self.title = [NSString stringWithFormat:@"%@", titleCategory];
    if (self) {
        NSMutableString *fullString = [[NSMutableString alloc] init];
        NSString *tileDirectory = [[NSBundle mainBundle] resourcePath];
        [fullString setString:tileDirectory];
        [fullString setString:[fullString stringByAppendingString:@"/bkg.png"]];
        UIColor *background = [[UIColor alloc] initWithPatternImage:[[UIImage alloc] initWithContentsOfFile:fullString]];
        self.view.backgroundColor = background;
//        self.tableView.separatorColor = [UIColor clearColor];

        brandsCategory = category;
        itemsInBrand = rows;
        completed = NO;

        arrCafe = [NSArray arrayWithObjects:@"Ze Donats", @"Index Cafe", @"Coffee Inn", @"Costa Coffee", @"Double Coffee", @"Muffins and More", @"McCafe", @"InnocentCafe", nil];
        arrShop = [NSArray arrayWithObjects:@"Rimi", @"Maxima", @"Mego", @"Super Netto", @"Prisma", @"Beta", @"Iki", nil];
        arrCinema = [NSArray arrayWithObjects:@"Cinamon", @"Forum Cinemas", @"Splendid Palace", @"K. Suns", @"Multikino", nil];
        arrBeer = [NSArray arrayWithObjects:@"Valmiermuiža", @"Aldaris", @"Tērvetes alus", @"Cēsu alus", @"Brenguļu alus", @"Bauskas alus", @"Brūveris", @"Užavas alus", @"LIDO alus", @"Piebalgas alus", nil];

        UIImage *buttonBack24 = [[UIImage imageNamed:@"backBtn"]
                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    return self;
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsInBrand;
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
    return 48 * (9 - self.itemsInBrand);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    UILabel *label = nil;

    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];

        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [label setMinimumFontSize:16.0];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:16.0]];
        [label setTag:1];

        [[cell contentView] addSubview:label];
    }
    if ([brandsCategory isEqual:@"cafe"]) {items = [[NSArray alloc] initWithArray:arrCafe];}
    else if ([brandsCategory isEqual:@"shop"]) {items = [[NSArray alloc] initWithArray:arrShop];}
    else if ([brandsCategory isEqual:@"cinema"]) {items = [[NSArray alloc] initWithArray:arrCinema];}
    else if ([brandsCategory isEqual:@"beer"]) {items = [[NSArray alloc] initWithArray:arrBeer];}

    NSString *text = [items objectAtIndex:[indexPath row]];
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    if (!label) {
        label = (UILabel *) [cell viewWithTag:1];
    }

    [label setText:text];
    [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, 0, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 3), MAX(size.height, 44.0f))];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    [self downloadXML:[items objectAtIndex:indexPath.row]];
    [HUD show:YES];
}

- (void)downloadXML:(NSString *)brand {
    brandName = brand;

    brand = [brand stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ā" withString:@"a"];
    brand = [brand stringByReplacingOccurrencesOfString:@"č" withString:@"c"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ē" withString:@"e"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ģ" withString:@"g"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ī" withString:@"i"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ķ" withString:@"k"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ļ" withString:@"l"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ņ" withString:@"n"];
    brand = [brand stringByReplacingOccurrencesOfString:@"š" withString:@"s"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ū" withString:@"u"];
    brand = [brand stringByReplacingOccurrencesOfString:@"ž" withString:@"z"];
    NSLog(@"%@", brand);

    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.esmu.lv/xmls/%@.xml", brand]]];

    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

    if (theConnection) {
        receivedData = [NSMutableData data];
    }

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
    [HUD hide:YES afterDelay:0.1];
    completed = YES;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.xml", brandName]];

    [receivedData writeToFile:documentsPath atomically:YES];

    tweetsTVC = [[TweetsTableViewController alloc] initWithStyle:UITableViewStylePlain category:brandsCategory brand:[NSString stringWithFormat:@"%@", brandName]];
    [self.navigationController pushViewController:tweetsTVC animated:YES];
}

@end
