//
//  AddExpensesViewController.h
//  EarningsNExpenses
//
//  Created by Tejswaroop Geetla on 12/17/16.
//  Copyright © 2016 Sruthi Ravula. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Validations.h"
@import FirebaseAuth;
@import FirebaseDatabase;


@interface AddExpensesViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *expAmount;
@property (weak, nonatomic) IBOutlet UITextField *expDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *expenseCategory;
@property (weak, nonatomic) IBOutlet UITextField *expSubCategory;


@property NSString *userID;
@property (strong, nonatomic) FIRDatabaseReference *dbRef;

@end
