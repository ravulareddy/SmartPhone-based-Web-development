//
//  EarningsDetailViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/15/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseDatabase;
@import FirebaseAuth;

@interface EarningsDetailViewController : UIViewController


@property BOOL update;
@property NSString *category;
@property NSString *userID;
@property (strong, nonatomic) FIRDatabaseReference *dbRef;
@property (weak, nonatomic) IBOutlet UITextField *totalamount;
@property (weak, nonatomic) IBOutlet UITextField *salaryIncome;
@property (weak, nonatomic) IBOutlet UITextField *businessIncome;
@property (weak, nonatomic) IBOutlet UITextField *propertyIncome;
@property (weak, nonatomic) IBOutlet UITextField *otherIncome;

@end
