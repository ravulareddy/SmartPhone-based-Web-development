//
//  EarningsTableViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/14/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "EarningsTableViewController.h"

@interface EarningsTableViewController ()

@property (strong, nonatomic) NSMutableDictionary *selectedCategory;
@property NSString *userID;
@property NSMutableDictionary *catgry;
@property NSMutableArray *temp;
@end

@implementation EarningsTableViewController

@synthesize earningsCatergory;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
  //  self.navigationController.navigationItem.backBarButtonItem.enabled = TRUE;
   // [self.navigationItem setHidesBackButton:false animated:YES];
    
    
 //   UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
  //  [[self navigationItem] setRightBarButtonItem:addButton];
    
    
    //Firebase Database
    self.dbRef = [[FIRDatabase database] reference];
    
    earningsCatergory = [[NSMutableArray alloc] init];
  /*  [earningsCatergory addObject:@"SalaryIncome"];
    [earningsCatergory addObject:@"BusinessIncome"];
    [earningsCatergory addObject:@"PropertyIncome"];
    [earningsCatergory addObject:@"Others"]; 
   
   */
    
    self.userCategoryArray = [NSMutableArray new];
    
    // NSDictionary *registeredUser = @{@"emailId":user.email,
    //                                 @"password":self.password.text,
     //                                @"phoneNumber":self.phoneNumber.text};
    
  //  NSMutableDictionary *category = [NSMutableDictionary new];
  //  [category setValue:snapshot.key forKey:@"categoryId"];
   // [category setValue:snapshot.value[@"title"] forKey:@"title"];
   // [category setValue:snapshot.value[@"subTitle"] forKey:@"subTitle"];
    
  _userID = [[[FIRAuth auth] currentUser] uid];
    NSDictionary *categories = @{@"SalaryIncome":@"0",
                                 @"BusinessIncome":@"0",
                                 @"PropertyIncome":@"0",
                                 @"Others":@"0"
                                };
    
    [[[[self.dbRef child:@"categories"] child:_userID] child:@"earnings"]updateChildValues:categories];
    
    
    [[[_dbRef child:@"categories"] queryOrderedByKey] observeSingleEventOfType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * snapshot){
      
        NSMutableDictionary *catgry1 = [NSMutableDictionary new];
        
        [catgry1 setValue:snapshot.key forKey:_userID];
        FIRDataSnapshot *snapshot1 = [snapshot childSnapshotForPath:@"earnings"];
        NSLog(@"snapshot 1" );
        [catgry1 setValue:snapshot1.value forKey:@"title"];
        
         NSLog(@"Entering observe Single event type");
        
        [self.earningsCatergory addObject:catgry1];
        self.categoryAdded = YES;
       
        NSDictionary *title = [NSDictionary new];
        if(earningsCatergory.count > 0)
        {
            for(NSDictionary *dic in earningsCatergory)
            {
                NSLog(@"title :::::::: %@", dic.allKeys);
                NSLog(@"values ::: %@",[dic valueForKey:@"title"] );
                
                title  = (NSDictionary *)[dic valueForKey:@"title"];
                
            }
            
            self.temp = [NSMutableArray new];
            
            for(NSString *key in title)
            {
                NSLog(@"KEyy inside cell::::::::%@", key);
                [self.temp addObject:key];
            }
            for(NSString *val in self.temp)
            {
                NSLog(@"val >> %@", val);
                //   cell.textLabel.text = val;
            }
            
        }
        [self.tableView reloadData];
        
    }];
    
   
    
    
    _catgry = [NSMutableDictionary new];
    
    
    [[[self.dbRef child:@"categories"] queryOrderedByKey] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot){
        
        [_catgry setValue:snapshot.key forKey:_userID];
        FIRDataSnapshot *snapshot1 = [snapshot childSnapshotForPath:@"earnings"];
        NSLog(@"snapshot 2" );
        [_catgry setValue:snapshot1.value forKey:@"title"];
        
        NSLog(@"Entering observe event type");
     
        [self.userCategoryArray addObject:_catgry];
        self.categoryAdded = YES;
        [self.tableView reloadData];
    }];
    
   
    
 //   NSLog(@"userCategoryArray ::::::::: %lu", (unsigned long)_userCategoryArray.count);
    
   
    
    
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{


//else if([identifier isEqualToString:@"earningDetail"]){}

    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.temp count];
 //   return [_userCategoryArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                                            @"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"accessIdentifier"];
    }
    
 //   NSInteger *row = indexPath.row;
 //  NSString *earningsStr = [earningsCatergory objectAtIndex:indexPath.row];
  //   NSString *earningsStr = [_userCategoryArray objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    UIView *myView = [[UIView alloc] init];
    
    
  /*
    if([earningsStr isEqualToString: @"SalaryIncome"])
    {
    cell.textLabel.text = @"Employment Income";
    cell.detailTextLabel.text = @"Income earned in Salary form";
 //   myView.backgroundColor = [UIColor greenColor];
   // cell.textLabel.backgroundColor =[UIColor greenColor];
   // cell.detailTextLabel.backgroundColor = [UIColor greenColor];
        
    }
    else if([earningsStr isEqualToString:@"BusinessIncome"])
    {
   //     myView.backgroundColor = [UIColor purpleColor];

        cell.textLabel.text = @"Business Income";
   //     cell.textLabel.backgroundColor =[UIColor purpleColor];
   //     cell.detailTextLabel.backgroundColor = [UIColor purpleColor];
        cell.detailTextLabel.text = @"Income earned by business";
        

    }
    else if([earningsStr isEqualToString:@"PropertyIncome"])
    {
        cell.textLabel.text = @"Property Income";
  //      cell.textLabel.backgroundColor =[UIColor orangeColor];
        cell.detailTextLabel.text = @"Income earned from Properties";
    //    cell.detailTextLabel.backgroundColor = [UIColor orangeColor];
  //      myView.backgroundColor = [UIColor orangeColor];
        

    }
    else if([earningsStr isEqualToString:@"Others"])
    {
        cell.textLabel.text = @"Other Income";
     //   cell.textLabel.backgroundColor = [UIColor blueColor];
        cell.detailTextLabel.text = @"Income earned by Other forms";
    //    cell.detailTextLabel.backgroundColor = [UIColor blueColor];
      //  myView.backgroundColor = [UIColor blueColor];
    }
   
    */
  
  
 /*   if(!_categoryAdded)
    {
         self.category = [NSMutableDictionary dictionary];
    }
    else
    {
        NSMutableArray *title = [NSMutableArray new];
        [title addObject:_category.allKeys];
        
        NSMutableArray *subtitle = [NSMutableArray new];
        [subtitle addObject:_category.allValues];
        
        if(title.count > 0 && subtitle.count > 0)
        {
        for(NSString *source in title)
        {
            cell.textLabel.text = source;
        }
         for(NSString *srcSub in subtitle)
         {
             cell.textLabel.text = srcSub;
         }
            
            NSLog(@"Updated table with new categories successfully!!");
        }
    }
  */
    
   
    cell.textLabel.text = [self.temp objectAtIndex:indexPath.row];
  
    
   /* if(self.earningsCatergory.count >0)
    {
        for(NSString *title in earningsCatergory)
        {
            NSLog(@"Title earnings :::: %@", title);
            cell.textLabel.text = title;
        }
    }
    */
    cell.backgroundView = myView;
    
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //Perform a segue.
    [self performSegueWithIdentifier:@"addIncomeForSource"
                              sender:[self.temp objectAtIndex:indexPath.row]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
 if([segue.identifier isEqualToString:@"addIncomeForSource"])
 {
     AddIncomeViewController *incomeVC = (AddIncomeViewController *)segue.destinationViewController;
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     incomeVC.incomeSrcText = (NSString *)[self.temp objectAtIndex:indexPath.row];
 
 //[self performSegueWithIdentifier:@"addIncomeForSource" sender:self];
 }
 
  /* if([segue.identifier isEqualToString:@"earningDetail"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSLog(@"%ld",(long)indexPath.row);
       NSString *selectedCategory = (NSString *)[earningsCatergory objectAtIndex:indexPath.row];
        
        EarningsDetailViewController *edVc =(EarningsDetailViewController *)segue.destinationViewController;
        edVc.update=YES;
        edVc.userID = _userID;
        edVc.category = selectedCategory;
    }
    else if([segue.identifier isEqualToString:@"addIncome"])
    {
     AddIncomeViewController *addIncome =(AddIncomeViewController *)segue.destinationViewController;
   
        
    }*/
 }
    

    
    



@end
