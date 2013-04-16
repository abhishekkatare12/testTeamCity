//
//  FCInAppItemsViewController.m
//  FingerControl
//
//  Created by Abhishek sharma on 05/12/12.
//
//

#import "FCInAppItemsViewController.h"
#import "RageIAPHelper.h"
#import <StoreKit/StoreKit.h>
#import "FCCommenMethods.h"
#import "MBProgressHUD.h"




@interface FCInAppItemsViewController () {
  NSArray *_products;
  NSNumberFormatter * _priceFormatter;
  MBProgressHUD *hud;
}
@end

@implementation FCInAppItemsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Purchase";
  
//  self.refreshControl = [[UIRefreshControl alloc] init];
//  [self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
  [self showHood];
  [self reload];
  //[self.refreshControl beginRefreshing];
  
  _priceFormatter = [[NSNumberFormatter alloc] init];
  [_priceFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
  [_priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  
 // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStyleBordered target:self action:@selector(restoreTapped:)];
  
}


- (void)restoreTapped:(id)sender {
  [[RageIAPHelper sharedInstance] restoreCompletedTransactions];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:NO];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setHidden:YES];
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)productPurchased:(NSNotification *)notification {
  [self performSelectorOnMainThread:@selector(hideHood) withObject:nil waitUntilDone:NO];
  NSString * productIdentifier = notification.object;
  
  if ([productIdentifier isEqualToString:@"com.appysod.20000coins"]) {
    [[FCCommenMethods sharedInstance] setNumberOfCoins:[[FCCommenMethods sharedInstance] numberOfCoins] + 20000] ;
  }
  else if ([productIdentifier isEqualToString:@"com.appysod.100000coins"]) {
    [[FCCommenMethods sharedInstance] setNumberOfCoins:[[FCCommenMethods sharedInstance] numberOfCoins] + 100000] ;
  }
  else if ([productIdentifier isEqualToString:@"com.appysod.250000coins"]) {
    [[FCCommenMethods sharedInstance] setNumberOfCoins:[[FCCommenMethods sharedInstance] numberOfCoins] + 250000] ;
  }
  [_products enumerateObjectsUsingBlock:^(SKProduct * product, NSUInteger idx, BOOL *stop) {
    if ([product.productIdentifier isEqualToString:productIdentifier]) {
      [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
      *stop = YES;
    }
  }];
  
}

- (void)reload {
  _products = nil;
  [self.tableView reloadData];
  [[RageIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products) {
    if (success) {
      _products = products;
      
      [self.tableView reloadData];
      [self hideHood];
    }
    //[self.refreshControl endRefreshing];
  }];
}

- (void) showHood {
  hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  hud.detailsLabelText = @"Loading..";
}

- (void) hideHood {
  [MBProgressHUD hideHUDForView:self.view animated:YES];
  hud = nil;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
  }
  
  SKProduct * product = (SKProduct *) _products[indexPath.row];
  
  cell.textLabel.text = product.localizedTitle;
  [_priceFormatter setLocale:product.priceLocale];
  cell.detailTextLabel.text = [_priceFormatter stringFromNumber:product.price];
  
  if ([[RageIAPHelper sharedInstance] productPurchased:product.productIdentifier]) {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.accessoryView = nil;
  } else {
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buyButton.frame = CGRectMake(0, 0, 72, 37);
    [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
    buyButton.tag = indexPath.row;
    [buyButton addTarget:self action:@selector(buyButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryView = buyButton;
  }
  cell.imageView.image = [UIImage imageNamed:@"CoinTilted.png"];
  
  return cell;
}

- (void)buyButtonTapped:(id)sender {
  
  [self showHood];
  UIButton *buyButton = (UIButton *)sender;
  SKProduct *product = _products[buyButton.tag];
  
  NSLog(@"Buying %@...", product.productIdentifier);
  [[RageIAPHelper sharedInstance] buyProduct:product];
  
}

@end
