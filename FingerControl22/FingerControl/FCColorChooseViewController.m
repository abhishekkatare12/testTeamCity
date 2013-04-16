//
//  FCColorChooseViewController.m
//  FingerControl
//
//  Created by Abhishek sharma on 06/12/12.
//
//

#import "FCColorChooseViewController.h"
#import "FCCommenMethods.h"

@interface FCColorChooseViewController ()

@end

@implementation FCColorChooseViewController
@synthesize forLeft;


- (void)viewDidLoad
{
    [super viewDidLoad];
  NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray: getColorsArray()];
  
 colorsArray = getColorsArray();
 colorImagesArray = getcolorImages();
  
  
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
  
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [colorsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
  [cell setAccessoryType:UITableViewCellAccessoryNone];
  NSLog(@"%d%d%d",FCCOMMEN.colorIndexLeft,FCCOMMEN.colorIndexRight,forLeft);
  if ((FCCOMMEN.colorIndexLeft == indexPath.row && forLeft) || (FCCOMMEN.colorIndexRight == indexPath.row && !forLeft)) {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
  }
  cell.textLabel.text = @"";
  if (forLeft && indexPath.row == [FCCOMMEN colorIndexRight]) {
    cell.textLabel.text = @"RightThumbColor";
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  else if(!forLeft && indexPath.row == [FCCOMMEN colorIndexLeft]){
    cell.textLabel.text = @"LeftThumbColor";
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  cell.imageView.image = [UIImage imageNamed:[colorImagesArray objectAtIndex:indexPath.row]];
  
    // Configure the cell...
    
    return cell;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  if (forLeft && indexPath.row == [FCCOMMEN colorIndexRight]) {
    return;
  }
  else if(!forLeft && indexPath.row == [FCCOMMEN colorIndexLeft]){
    return;
  }

  [FCCOMMEN setUserSelectedCustomDrawingColor:YES];
  if (forLeft) {
    
    [FCCOMMEN setColorIndexLeft:indexPath.row];
    [FCCOMMEN setLeftDrawColor:[getColorsArray() objectAtIndex:indexPath.row]];
    [FCCOMMEN setLeftDrawColorImage:[UIImage imageNamed:[getcolorImages() objectAtIndex:indexPath.row]]];

  }
  else {
    [FCCOMMEN setColorIndexRight:indexPath.row];
    [FCCOMMEN setRightDrawColor:[getColorsArray() objectAtIndex:indexPath.row]];
    [FCCOMMEN setRightDrawColorImage:[UIImage imageNamed:[getcolorImages() objectAtIndex:indexPath.row]]];

  }
    [tableView reloadData];

}

@end
