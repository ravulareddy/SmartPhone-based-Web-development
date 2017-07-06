//
//  EarningsDashboardViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/16/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "EarningsDashboardViewController.h"

@interface EarningsDashboardViewController ()

@end

@implementation EarningsDashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //   NSLog(@"category list events dasboard :: %@", _categoryList.allKeys.description);
   // _categoryList = [NSMutableDictionary new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)unwindToEarningsDashboar:(UIStoryboardSegue *)segue
{
    
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"viewCategories"])
    {
        EarningsTableViewController *controller = (EarningsTableViewController *)segue.destinationViewController;
        controller.categoryAdded = _categoryAdded;
         NSLog(@"category list count 2 :: ");
        controller.category =(NSMutableDictionary *)_categoryList;
    }
}
*/

@end
