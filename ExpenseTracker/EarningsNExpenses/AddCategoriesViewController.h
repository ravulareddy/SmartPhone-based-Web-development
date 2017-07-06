//
//  AddCategoriesViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import FirebaseAuth;
#import "NSString+Validations.h"
#import "EarningsDashboardViewController.h"

@interface AddCategoriesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *categoryTitle;
@property (weak, nonatomic) IBOutlet UITextField *categorySubTitle;
@property BOOL *categoryAdded;
@property NSMutableDictionary *categoryList;
@property FIRDatabaseReference *dbRef;
@end
