//
//  AddCategoriesViewController.m
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import "AddCategoriesViewController.h"

@interface AddCategoriesViewController ()
@property NSString *userID;

@end

@implementation AddCategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Firebase Db reference
    self.dbRef = [[FIRDatabase database] reference];
     _userID = [[[FIRAuth auth] currentUser] uid];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)addCategoryButtonClicked:(id)sender {
    
    
    if([_categoryTitle.text isEmpty] || [_categorySubTitle.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"All Fields must be filled in!" message:@"Warning!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add new Source of Income Successfully!" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    _categoryList = [NSMutableDictionary new];
    NSString *trimmedString = [self.categoryTitle.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
    NSDictionary *categories = @{trimmedString:@"0"};
    
    NSDictionary *temp = @{@"title":trimmedString,
                           @"subTitle":_categorySubTitle.text};
    [_categoryList addEntriesFromDictionary:temp];
    _categoryAdded = YES;
    
     [[[[self.dbRef child:@"categories"] child:_userID] child:@"earnings"]updateChildValues:categories];
     NSLog(@"Income source added Successfully for the user  !!:::::: ");
   
}



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   

    
}

*/


@end
