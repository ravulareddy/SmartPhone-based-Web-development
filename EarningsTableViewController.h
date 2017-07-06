//
//  EarningsTableViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/14/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EarningsDetailViewController.h"
#import "AddIncomeViewController.h"

@import FirebaseStorage;
@import FirebaseDatabase;
@import Firebase;

@interface EarningsTableViewController : UITableViewController

@property NSMutableArray *earningsCatergory;
@property NSMutableArray *userCategoryArray;

@property (strong, nonatomic) FIRStorageReference *storageRef;
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property NSMutableArray *categories;
@property BOOL *categoryAdded;
@property NSMutableDictionary *category;

@end
